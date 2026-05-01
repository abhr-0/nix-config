{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    # Use sharedModules instead of imports when using home-manager as a NixOS module
    sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
    extraSpecialArgs = { inherit inputs; };
    users.abhro = ../../../home-manager/abhro/home.nix;
  };
}
