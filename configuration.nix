{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/base.nix
      ./modules/gui.nix
      ./modules/dev.nix
      ./modules/accounts.nix
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    firewall = {
      enable = false;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };

  #############################################################################
  # Packages and environment
  #############################################################################

  nixpkgs.config.allowUnfree = true;

#  environment.systemPackages = with pkgs; [
#    git   # distributed vcs
#  ];

  system.stateVersion = "21.11"; # Did you read the comment?
}
