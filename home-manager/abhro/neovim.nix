{ self, ... }:
{
  home =
    let
      customNeovim = self.packages."x86_64-linux".neovim;
    in
    {
      packages = [ customNeovim ];
      sessionVariables.EDITOR = "${customNeovim}/bin/nvim";
      shellAliases.vimdiff = "nvim -d";
    };
}
