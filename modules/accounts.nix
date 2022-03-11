{ pkgs, ... }: {

  #############################################################################
  # Define users
  #----------------------------------------------------------------------------
  # Don't forget to set a password with 'passwd'
  #############################################################################

  environment.variables = {
    DEFAULT_USER = "earthling";
  };

  users.users.earthling = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Earthling";
    createHome = true;
    home = "/home/earthling";
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  users.users.powerless = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Capt. Powerless";
    createHome = true;
    home = "/home/powerless";
    uid = 1010;
  };
}
