{ pkgs, ... }: {

  #############################################################################
  # Dev configuration
  #----------------------------------------------------------------------------
  #
  #############################################################################

  # Packages and environment
  #############################################################################

  environment.systemPackages = with pkgs; [
    azure-cli
    buildah
    kubernetes-helm
    kubectl
    opentofu
    vault
    uv
    zed-editor
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
