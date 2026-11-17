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
          nurl
          nix-init
          age
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
