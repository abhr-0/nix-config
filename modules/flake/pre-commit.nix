{ inputs, ... }:
{
  imports = [ inputs.git-hooks-nix.flakeModule ];
  perSystem = {
    pre-commit.settings.hooks =
      let
        excludes = [ "hardware-configuration\\.nix" ];
      in
      {
        deadnix = {
          enable = true;
          inherit excludes;
        };
        statix = {
          enable = true;
          # inherit excludes; # FIXME #1
          settings.ignore = excludes;
        };
        nixfmt-rfc-style = {
          enable = true;
          inherit excludes;
        };
      };
  };
}
