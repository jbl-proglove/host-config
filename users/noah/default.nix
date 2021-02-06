{ lib, pkgs, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;

  name = "Noah Blank";
in
{
  imports = [ ../../profiles/develop ./graphical ];
  # TODO set keyboard to German (confifguration.nix: console.keyMap = "de";)

  users.users.root.hashedPassword = fileContents ../../secrets/root;

  home-manager.users.noah = {
    imports = [ ../profiles/git ../profiles/alacritty ../profiles/direnv ];

    home = {
      file = {
        ".zshrc".text = "#";
      };
    };

  };

  users.users.noah = {
    uid = 1001;
    description = name;
    hashedPassword = fileContents ../../secrets/noah;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
