{ lib, modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../profiles/graphical
    ../profiles/laptop
    ../profiles/misc/disable-mitigations.nix
    ../users/noah
    ../users/julius
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/63256507-abfc-4c01-bcf8-295ec70cdb37";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/9B2A-6408";
    fsType = "vfat";
  };

  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  services.picom = {
    backend = "glx";
    vSync = true;
  };

  security.mitigations.acceptRisk = true;
}
