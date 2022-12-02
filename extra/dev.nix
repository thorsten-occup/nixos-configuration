{ pkgs, ... }: {

  #############################################################################
  # Dev configuration
  #----------------------------------------------------------------------------
  #
  #############################################################################

  # Packages and environment
  #############################################################################

  environment.systemPackages = with pkgs; [
    rustc
    cargo
    cargo-ui
    cargo-vet
    python310
    dhall                    # a configuration language
    cue                      # data constraint language
    azure-cli
    dagger
    buildah
    kubernetes-helm
    kubectl
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
