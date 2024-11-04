{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "figatell";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "es";
  };
}
