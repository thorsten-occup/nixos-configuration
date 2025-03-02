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
    librefox
    pcloud
    foliate   # eBook viewer
    helvum    # GTK patchbay for pipewire
  ];

  environment.pantheon.excludePackages = with pkgs.pantheon; [
    elementary-calculator
    #elementary-calendar
    elementary-code
    #elementary-mail
    elementary-music
    elementary-photos
    elementary-videos
    sideload
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
