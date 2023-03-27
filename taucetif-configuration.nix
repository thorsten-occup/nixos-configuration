# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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
  boot.initrd.luks.devices."luks-907700fd-30b8-45ae-915a-921ae497adba".device = "/dev/disk/by-uuid/907700fd-30b8-45ae-915a-921ae497adba";
  boot.initrd.luks.devices."luks-907700fd-30b8-45ae-915a-921ae497adba".keyFile = "/crypto_keyfile.bin";

  networking = {
    hostName = "taucetif";
    networkmanager.enable = true;
  };

  #############################################################################
  # Accounts (don't forget to set a password with 'passwd')
  #############################################################################

  environment.variables = {
    DEFAULT_USER = "earthling";
  };

  programs.fish.enable = true;

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

  hardware.pulseaudio.enable = false;
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
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

  security.rtkit.enable = true;
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "unstable"; # Did you read the comment?
}
