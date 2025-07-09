{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    fish
    fishPlugins.hydro
    gh            # GitHub CLI
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    curl          # you shouldknow
    bitwarden-cli # secure and free password manager
    tree
    # vimPlugins.rust-vim
    # vimPlugins.go-nvim
    vivaldi
    bitwarden # secure and free password manager
    mailspring
    pcloud
    helvum    # GTK patchbay for pipewire
    whatsapp-for-linux
    uv
    warp-terminal
    opencode
    zed-editor
    vscode
    vscode-extensions.editorconfig.editorconfig
    vscode-extensions.ms-python.python
    vscode-extensions.vscodevim.vim
    vscode-extensions.redhat.vscode-yaml
    vscode-extensions.hashicorp.terraform
    vscode-extensions.github.github-vscode-theme
  ];

  #############################################################################
  # Program configuration
  #############################################################################

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
      #pkgs.tmuxPlugins.power-theme
    ];
    terminal = "screen-256color";
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

}
