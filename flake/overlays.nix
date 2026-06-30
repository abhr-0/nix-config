{
  flake.overlays.default = final: prev: {
    vimPlugins = prev.vimPlugins.extend (
      _: _: {
        # final' and prev'
        # Not in nixpkgs
        blink-cmp-copilot-chat = final.vimUtils.buildVimPlugin {
          name = "blink-cmp-copilot-chat";
          src = final.fetchFromGitHub {
            owner = "pxwg";
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
