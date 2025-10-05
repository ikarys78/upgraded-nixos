{ config, lib, pkgs, inputs, otputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nixos/hyprland.nix
      ./modules/nixos/fonts.nix
    ];
 
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  
  users.users.ykarys = {
    isNormalUser = true;
    extraGroups = [ "wheel"]; # Enable ‘sudo’ for the user
    password = "123"; 
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
      firefox
      kitty
      wofi
      git
    ];
  };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    
  ];
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      nix-path = config.nix.nixPath;
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?

}

