{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    fish
    gh            # GitHub CLI
    lazygit
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    curl          # you shouldknow
    bitwarden-cli # secure and free password manager
    tree
    calibre
    readest
    firefox
    thunderbird
    vivaldi
    bitwarden # secure and free password manager
    pcloud
    helvum    # GTK patchbay for pipewire
    whatsapp-for-linux
    openssl
    rustup
    clang
    clippy
    uv
    warp-terminal
    kiro
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
	      colorscheme koehler
      '';
    };
    withPython3 = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    newSession = true;
    plugins = [
      pkgs.tmuxPlugins.nord
    ];
    terminal = "screen-256color";
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

}
