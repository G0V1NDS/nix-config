{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
  keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICxKQtKkR7jkse0KMDvVZvwvNwT0gUkQ7At7Mcs9GEop guru@1password"];
in {
  users.users = {
    guru =
      {
        description = "Govind Singh";
        home =
          if isDarwin
          then "/Users/guru"
          else "/home/guru";
        openssh.authorizedKeys.keys = keys;
      }
      // lib.optionalAttrs isLinux {
        hashedPasswordFile = config.age.secrets.guru.path;
        isNormalUser = true;
        createHome = true;
        shell = pkgs.fish;
        extraGroups = ["wheel" "media"]; # Enable ‘sudo’ for the user.
      };
  };

  nix.settings.extra-trusted-users = ["guru"];

  home-manager.users.guru = import ../home/guru;
}
