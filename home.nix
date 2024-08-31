{ callPackage, config, pkgs, ... }:

{
   home.stateVersion = "24.11";
   home.username = "musashi";
   home.homeDirectory = "/home/musashi/";

   home.packages = [
     pkgs.jetbrains-mono
   ];

#  home.packages = [
#    pkgs.bat
#    pkgs.fd
#    pkgs.fzf
#    pkgs.gh
#    pkgs.htop
#    pkgs.jq
#    pkgs.ripgrep
#    pkgs.tree
#    pkgs.watch
#    pkgs.neovim
#    pkgs.zsh
#    pkgs.git
#    pkgs.delta
#    pkgs.rofi
#    pkgs.nodejs # Node is required for Copilot.vim
#  ]);
#
#  home.sessionVariables = {
#    LANG = "en_US.UTF-8";
#    LC_CTYPE = "en_US.UTF-8";
#    LC_ALL = "en_US.UTF-8";
#    EDITOR = "nvim";
#    PAGER = "less -FirSwX";
#  };

######## Programs ######## 

  programs.git = {
    enable = true;
    userName = "Leonardo Essia";
    userEmail = "leonardo@essia.dev";
    aliases = {
      cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      delta.enable = true;
      color.ui = true;
      init.defaultBranch = "main";
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    secureSocket = false;
    escapeTime = 0;
    historyLimit = 100000;
    plugins = with pkgs;
      [
        tmuxPlugins.fuzzback
	tmuxPlugins.pain-control
      ];
    extraConfig = ''
      set -ga terminal-overrides ",*256col*:Tc"
      set -g renumber-windows on
    '';
  };


}

