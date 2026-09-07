{
  perSystem =
    { config, pkgs, ... }: # { system, ...}
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt
          nurl
          age
          ssh-to-age
          sops
        ];

        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };
}
