{ pkgs, ... }: {

  ############################################################################
  # Enable nvidia driver (no support from nouveau ... any more)
  ############################################################################

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;  # see the note above
  hardware.nvidia.branch = "legacy_580";
  hardware.nvidia.modesetting.enable = true;

  ############################################################################
  # Fingerprint reader
  ############################################################################

  # Install the driver
  services.fprintd.enable = true;
  # If simply enabling fprintd is not enough, try enabling fprintd.tod...
  # services.fprintd.tod.enable = true;
  # ...and use one of the next four drivers
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-elan; # Elan(04f3:0c4b) driver
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090; # (Marked as broken as of 2025/04/23!) driver for 2016 ThinkPads
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix-550a; # Goodix 550a driver (from Lenovo)

  # however for focaltech 2808:a658, use fprintd with overidden package (without tod)
  # services.fprintd.package = pkgs.fprintd.override {
  #   libfprint = pkgs.libfprint-focaltech-2808-a658;
  # };
  # this package is deprecated as of 2026 due to copyright reasons, you may search the internet for archived caches
}
