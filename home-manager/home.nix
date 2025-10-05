{ config, pkgs, lib, ... }:

{
  imports = [
    ../modules/hm/git.nix
    ../modules/hm/zsh.nix
  ];
  home.username = "ykarys";
  home.homeDirectory = "/home/ykarys";

  programs.zsh.enable = true;
  programs.git.enable = true;

  home.stateVersion = "23.11";
}

