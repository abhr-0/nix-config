{ inputs, ... }: {
  imports = [ inputs.git-hooks-nix.flakeModule ];

  perSystem = { config, pkgs, ... }: {
    pre-commit.settings = {
      excludes = [ "hardware-configuration\\.nix" ];
      hooks = {
        deadnix.enable = true;
        statix = {
          enable = true;
          settings.ignore = [ "hardware-configuration\\.nix" ]; # FIXME #1
        };
        nixfmt.enable = true;
      };
    };

    devShells.default = pkgs.mkShell {
      packages =
        with pkgs;
        [
          nixd
          nurl
          nix-init
          age
          ssh-to-age
          sops
          nix-update
        ]
        ++ config.pre-commit.settings.enabledPackages;

      shellHook = ''
        ${config.pre-commit.shellHook}
      '';
    };

    formatter = pkgs.nixfmt;
  };
}
