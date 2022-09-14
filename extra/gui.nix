{ pkgs, ... }: {

  #############################################################################
  # GUI configuration
  #----------------------------------------------------------------------------
  #
  #############################################################################

  #############################################################################
  # Program configuration
  #############################################################################

  programs.light.enable = true;
  programs.pantheon-tweaks.enable = true;

  #############################################################################
  # Packages and environment
  #############################################################################

  environment.systemPackages = with pkgs; [
    alacritty 
    bitwarden # secure and free password manager
    firefox
    foliate
    pcloud
    foliate   # eBook viewer
    helvum    # GTK patchbay for pipewire
  ];

  #############################################################################
  # Services
  #############################################################################

  services.xserver = {
    enable = true;
    desktopManager.pantheon.enable = true;
    displayManager.lightdm.enable = true;
    layout = "us,us";
    xkbVariant = "intl";
    libinput.enable = true;
  };
}
