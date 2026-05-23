{
  perSystem =
    { config, pkgs, ... }: # { system, ...}
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt-rfc-style
          nurl
        ];

        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };
}
