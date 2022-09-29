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

  environment.pantheon.excludePackages = with pkgs.pantheon; [
    elementary-calculator
    elementary-calendar
    elementary-camera
    elementary-code
    #elementary-files
    elementary-mail
    elementary-music
    elementary-photos
    #elementary-screenshot
    elementary-tasks
    #elementary-terminal
    elementary-videos
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
