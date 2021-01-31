{ lib, pkgs, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;

  name = "Julius Blank";
in
{
  imports = [ ../../profiles/develop ./graphical ];

  # TODO pull in packages from github.com/juliusblank/nix-home

  home-manager.users.julius = {
    imports = [ ../profiles/git ../profiles/alacritty ../profiles/direnv ];

    home = {
      file = {
          ".zshrc".text = "#";
      };
    };

    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    programs.git = {
        userName = name;
        userEmail = "julius.blank@proglove.de";
        signing = {
            # TODO setup key
            key = "";
            signByDefault = true;
        };
    };

    programs.ssh = {
        enable = true;
        hashKnownHosts = true;

        matchBlocks =
          let
            githubKey = toFile "github" (readFile ../../secrets/github);
          in
          {
              github = {
                  host = "github.com";
                  identityFile = githubKey;
                  extraOptions = { AddKeysToAgent = "yes" };
              };
          };
    };
  };

  users.users.julius = {
    uid = 1011;
    description = name;
    hashedPassword = fileContents ../../secrets/julius;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
