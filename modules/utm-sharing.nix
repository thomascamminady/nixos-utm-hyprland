{ config, pkgs, ... }:

let
  # UTM's VirtFS uses the fixed tag "share" for the shared directory. citeturn0search0turn0search8
  mountPointRaw = "/mnt/utm";
  mountPoint = "/mnt/share";
in
{
  environment.systemPackages = with pkgs; [ bindfs ];

  systemd.tmpfiles.rules = [
    "d ${mountPointRaw} 0755 root root - -"
    "d ${mountPoint} 0755 thomas users - -"
  ];

  # 1) Mount the UTM VirtFS share (9p over virtio)
  # UTM docs recommend this fstab entry for Linux guests. citeturn0search8
  fileSystems."${mountPointRaw}" = {
    device = "share";
    fsType = "9p";
    options = [
      "trans=virtio"
      "version=9p2000.L"
      "rw"
      "_netdev"
      "nofail"
      "auto"
    ];
  };

  # 2) Fix permissions: macOS user/group are commonly 501/20; map them to guest thomas (1000).
  # This makes the share writable without fiddling with permissions each boot. citeturn0search4
  systemd.mounts = [
    {
      what = mountPointRaw;
      where = mountPoint;
      type = "fuse.bindfs";
      options = "map=501/1000:@20/@1000";
      after = [ "mnt-utm.mount" ];
      requires = [ "mnt-utm.mount" ];
      wantedBy = [ "multi-user.target" ];
    }
  ];
}
