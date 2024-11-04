{ pkgs, ... }:

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

  fonts.packages = with pkgs; [
    fira-mono
  ];

  system.stateVersion = "24.05";
}
