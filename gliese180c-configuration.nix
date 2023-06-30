{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./extra/base.nix
      ./extra/gui.nix
      ./extra/dev.nix
      ./extra/work.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-048f63e1-3751-45e8-870a-005ebd67a45a".device = "/dev/disk/by-uuid/048f63e1-3751-45e8-870a-005ebd67a45a";
  boot.initrd.luks.devices."luks-048f63e1-3751-45e8-870a-005ebd67a45a".keyFile = "/crypto_keyfile.bin";

  networking = {
    hostName = "gliese180c";
    networkmanager.enable = true;
  };

  #############################################################################
  # Accounts (don't forget to set a password with 'passwd')
  #############################################################################

  programs.fish.enable = true;

  environment.variables = {
    DEFAULT_USER = "earthling";
  };

  users.users.earthling = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Earthling";
    createHome = true;
    home = "/home/earthling";
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  users.users.powerless = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Capt. Powerless";
    createHome = true;
    home = "/home/powerless";
    uid = 1010;
  };

  #############################################################################
  # Locals
  #############################################################################

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts.fonts = with pkgs; [
    powerline-fonts
  ];

  powerManagement.powertop.enable = true;
  security.sudo.enable = true;

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
    pulse.enable = true;
  };

  services.fwupd.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.gnome.gnome-keyring.enable = true;

  #############################################################################
  # Misc
  #############################################################################

  hardware.pulseaudio.enable = false;
  sound.enable = true;
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "unstable";
}
