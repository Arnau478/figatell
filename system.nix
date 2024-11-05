{ pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless = {
    enable = true;
    networks = import ./secrets/networks.nix;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.arnau = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  environment.systemPackages = with pkgs; [
    neofetch
    tree
  ];

  xdg.portal.wlr.enable = true;
  programs.sway.enable = true; # TODO: Why is this needed?

  programs.fish.enable = true;

  # TODO: Put this into home/?
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    fira-mono
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  system.stateVersion = "24.05";
}
