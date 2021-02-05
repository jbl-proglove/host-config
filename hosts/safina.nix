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
    device = "/dev/disk/by-uuid/dd0d906a-1e05-468f-808d-9428205f13bb";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/28B2-8CE5";
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
