{ pkgs, ... }: {

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
  ];

  # Cosmic Desktop
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;
  programs.firefox.preferences = {
    # disable libadwaita theming for Firefox
    "widget.gtk.libadwaita-colors.enabled" = false;
  };

  #services = {
  #  desktopManager.plasma6.enable = true;
  #  displayManager.sddm.enable = true;
  #  displayManager.sddm.wayland.enable = true;
  #};
  
  environment.systemPackages = with pkgs; [
    #cosmic-reader
    fish
    gh            # GitHub CLI
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    curl          # you shouldknow
    tree
    readest
    vivaldi
    bitwarden-desktop
    crosspipe
    #fragments
    karere
    openssl
    go
    uv
    zed-editor
    vscode
    opencode
    github-copilot-cli

    ## KDE Utilities
    #kdePackages.discover # Optional: Software center for Flatpaks/firmware updates
    #kdePackages.kcalc # Calculator
    #kdePackages.kcharselect # Character map
    #kdePackages.kclock # Clock app
    #kdePackages.kcolorchooser # Color picker
    #kdePackages.kolourpaint # Simple paint program
    #kdePackages.ksystemlog # System log viewer
    #kdePackages.sddm-kcm # SDDM configuration module
    #kdiff3 # File/directory comparison tool
    
    # Hardware/System Utilities (Optional)
    hardinfo2 # System benchmarks and hardware info
    wayland-utils # Wayland diagnostic tools
    wl-clipboard # Wayland copy/paste support
    vlc # Media player
  ];

  #environment.plasma6.excludePackages = with pkgs; [
  #  kdePackages.elisa # Music player
  #  kdePackages.kdepim-runtime # Akonadi agents
  #  kdePackages.kmahjongg
  #  kdePackages.kmines
  #  kdePackages.konversation # IRC client
  #  kdePackages.kpat # Solitaire
  #  kdePackages.ksudoku
  #  #kdePackages.ktorrent
  #];

  #############################################################################
  # Additional configuration
  #############################################################################

  services.fwupd.enable = true;

  # necessary for uv
  programs.nix-ld.enable = true;

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
    plugins = [
      pkgs.tmuxPlugins.power-theme
    ];
    terminal = "screen-256color";
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

}
