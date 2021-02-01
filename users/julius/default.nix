{ lib, pkgs, ... }:
let
  inherit (builtins) toFile readFile;
  inherit (lib) fileContents mkForce;

  name = "Julius Blank";
in
{
  imports = [ ../../profiles/develop ./graphical ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # TODO pull in packages from github.com/juliusblank/nix-home

  home-manager.users.julius = {
    imports = [ ../profiles/git ../profiles/alacritty ../profiles/direnv ];

    home = {
      file = {
        ".zshrc".text = "#";
        ".gnupg/gpg-agent.conf".text = ''
          pinentry-program ${pkgs.pinentry_curses}/bin/pinentry-curses
        '';
      };
    };

    programs.git = {
      userName = name;
      userEmail = "julius.blank@proglove.de";
      signing = {
        key = "0C3E750F33B35B7A";
        signByDefault = true;
      };
    };

    programs.ssh = {
      enable = true;
      hashKnownHosts = true;

      matchBlocks =
        let
          githubKey = toFile "github" (readFile ../../secrets/github_jbl-proglove_safina);
        in
        {
          github = {
            host = "github.com";
            identityFile = githubKey;
            extraOptions = { AddKeysToAgent = "yes"; };
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
