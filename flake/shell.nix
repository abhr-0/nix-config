{
  perSystem =
    { config, pkgs, ... }: # { system, ...}
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt
          nurl
        ];

        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };
}
