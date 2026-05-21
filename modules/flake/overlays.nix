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

        # Not in nixpkgs
        blink-cmp-copilot-chat = final.vimUtils.buildVimPlugin {
          name = "blink-cmp-copilot-chat";
          src = final.fetchFromGitHub {
            owner = "prxwg";
            repo = "blink-cmp-copilot-chat";
            rev = "f6b88c9a0afa3080ab3157a630717a0962533185";
            hash = "sha256-J5/fYG06WNl5ykH2K9RDOeZQ1zkZHpsKld4Vyl8TCAI=";
          };
          version = "0.0.0-unstable-2027-05-19";
        };
      }
    );
  };
}
