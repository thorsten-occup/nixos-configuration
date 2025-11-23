{ pkgs, ... }: {

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.hack
  ];

  environment.systemPackages = with pkgs; [
    fish
    gh            # GitHub CLI
    lazygit
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    curl          # you shouldknow
    tree
    readest
    cosmic-reader

    qutebrowser
    firefox
    vivaldi
    bitwarden-desktop
    helvum    # GTK patchbay for pipewire
    wasistlos
    openssl
    rustup
    clang
    clippy
    uv
    warp-terminal
    opencode
    zed-editor
    vscode
  ];

  #############################################################################
  # Additional configuration
  #############################################################################

  services.fwupd.enable = true;

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
