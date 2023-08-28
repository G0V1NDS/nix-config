# home manager config
{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  imports = [
    ./apps/alacritty.nix
    ./apps/bash.nix
    ./apps/bat.nix
    ./apps/bottom.nix
    ./apps/direnv.nix
    ./apps/exa.nix
    ./apps/fish.nix
    ./apps/fzf.nix
    ./apps/git.nix
    ./apps/neovim.nix
    ./apps/nushell
    ./apps/ssh.nix
    ./apps/zellij.nix
    ./apps/zsh.nix
  ];

  home = {
    username = "joseph";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/joseph"
      else "/home/joseph";
    packages = with pkgs; [
      # custom packages
      recyclarr

      # nix
      alejandra
      cachix
      nix-prefetch
      nixpkgs-fmt
      nixpkgs-review
      rnix-lsp

      # misc
      age
      bashInteractive
      croc # file sharing
      exiftool
      fd
      hugo
      httpie
      just
      jq
      less
      ncdu
      python311
      rclone
      restic
      rsync
      silver-searcher
      spoof-mac
      tldr

      # languages
      nodejs
      cargo
      rustc
      zigpkgs.master

      # python
      python311Packages.poetry-core
    ];
    stateVersion = "22.11";
    shellAliases = {
      top = "btm";
      copy = "rsync -rvg --progress"; # copy <source> <destination>
      cat = "bat --paging=never --style=plain,header";
    };
  };

  programs = {
    gitui.enable = true;
    lazygit.enable = true;
    home-manager.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    zoxide.enable = true;
  };

  xdg = {
    # todo: look into this option more
    enable = false;
  };
}
