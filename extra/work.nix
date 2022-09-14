{ pkgs, ... }: {

  #############################################################################
  # Packages needed for work
  #----------------------------------------------------------------------------
  #
  #############################################################################


  # Packages
  #############################################################################

  environment.systemPackages = with pkgs; [
    google-chrome
    #slack
    #teams
    vscode
    vscode-extensions.editorconfig.editorconfig
    vscode-extensions.ms-python.python
    vscode-extensions.vscodevim.vim
    #vscode-extensions.dhall.dhall-lang
    vscode-extensions.redhat.vscode-yaml
    vscode-extensions.hashicorp.terraform
    vscode-extensions.github.github-vscode-theme
    vscode-extensions.ms-kubernetes-tools.vscode-kubernetes-tools
    vscode-extensions.arcticicestudio.nord-visual-studio-code
    #vscode-extensions.haskell.haskell
  ];


  # Services
  #############################################################################

}
