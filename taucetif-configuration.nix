{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./extra/gui.nix
      ./extra/dev.nix
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "taucetif";
    interfaces = {
      enp2s0.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
    firewall = {
      enable = false;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };


  # Accounts (don't forget to set a password with 'passwd')
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

  nixpkgs.config.allowUnfree = true;

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
    pulse.enable = true;
  };

  services.fwupd.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;


  # Misc
  #############################################################################

  hardware.pulseaudio.enable = false;
  sound.enable = true;

  system.stateVersion = "22.05";
}
