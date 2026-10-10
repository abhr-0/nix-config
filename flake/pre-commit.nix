{ inputs, ... }:
{
  imports = [ inputs.git-hooks-nix.flakeModule ];
  perSystem.pre-commit.settings = {
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
}
