{ pkgs, ... }: {

  #############################################################################
  # Base configuration
  #----------------------------------------------------------------------------
  #
  #############################################################################

  #############################################################################
  # Packages and environment
  #############################################################################

  environment.systemPackages = with pkgs; [
    fish
    fishPlugins.hydro
    gh            # GitHub CLI
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    glow          # render markdown on the CLI
    curl          # you shouldknow
    xh            # friendly and fast tool for sending HTTP requests
    bitwarden-cli # secure and free password manager
    tree
    vimPlugins.rust-vim
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

}
