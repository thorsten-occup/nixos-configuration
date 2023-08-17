{ pkgs, ... }: {

  #############################################################################
  # Dev configuration
  #----------------------------------------------------------------------------
  #
  #############################################################################

  # Packages and environment
  #############################################################################

  environment.systemPackages = with pkgs; [
    go
    kubernetes-helm
    kubectl
    packer
    terraform
    terraform-providers.vault
    vault
  ];

  # Services
  #############################################################################

  #services.k3s.enable = true;
  #systemd.services.k3s.enable = false;

  # Virtualisation
  #############################################################################

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

}
