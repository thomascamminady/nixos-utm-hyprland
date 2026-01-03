{ pkgs, ... }:

{
  users.users.thomas = {
    isNormalUser = true;
    description = "Thomas";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$7YFMQZXtN3DSYFLH$yJtf36.O2D.H2PAc5jbt9KWTGlxWx/19mLge8JLRf0c55UReKzArSc4IMOlaQnp99ZN8SZzDQS7SL6Fck.47O0";
  };

  security.sudo.wheelNeedsPassword = false;
}
