# This file is used to used for temporary overrides that are not yet merged
# upstream. Once the fix is merged, the override should be removed and the
# version should be updated to the latest release.
{
  flake.overlays.default = final: prev: {
    vimPlugins = prev.vimPlugins.extend (
      _: prev': {
        # TODO: Remove when fix is merged upstream
        CopilotChat-nvim = prev'.CopilotChat-nvim.overrideAttrs (_: {
          src = final.fetchFromGitHub {
            owner = "abhr-0";
            repo = "CopilotChat.nvim";
            rev = "1564-auto-insert-mode-fix";
            hash = "sha256-SmOVivGlDXxbPdgeb83utwg/u512BcKboknSNap0uok=";
          };
          version = "local";
        });
      }
    );
  };
}
