{ pkgs, ... }: {

  #############################################################################
  # Basic system configuration
  #############################################################################


  # Locals
  #############################################################################

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts.fonts = with pkgs; [
    powerline-fonts
  ];

  powerManagement.powertop.enable = true;
  security.sudo.enable = true;

  # Program configuration
  #############################################################################

  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      fetch = { prune = true; };
    };
  };

  programs.htop.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set nocompatible
        syntax on
        set foldmethod=syntax
        set nu
        filetype indent plugin on
      '';
    };
    withPython3 = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    newSession = true;
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "helm" "kubectl"];
      theme = "robbyrussell";
    };
  };

  # Packages and environment
  #############################################################################

  environment.systemPackages = with pkgs; [
    git           # distributed vcs
    gh            # GitHub CLI
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    glow          # render markdown on the CLI
    curl          # you shouldknow
    xh            # friendly and fast tool for sending HTTP requests
    bitwarden-cli # secure and free password manager
    tree
  ];

  #############################################################################
  # Services
  #############################################################################

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    media-session.enable = true;
    pulse.enable = true;
  };

  services.fwupd.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;


  #############################################################################
  # Virtualisation
  #############################################################################

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.libvirtd.enable = true;

  #############################################################################
  # Misc
  #############################################################################

  hardware.pulseaudio.enable = false;
  sound.enable = true;
}
