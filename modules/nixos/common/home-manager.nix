{
  self,
  inputs,
  hostName,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [
      # Use sharedModules instead of imports when using home-manager as a NixOS module
      # inputs.sops-nix.homeManagerModules.sops

      (inputs.import-tree ../../../home-manager/abhro)
    ];
    extraSpecialArgs = { inherit inputs hostName self; };
    users.abhro = ../../../home-manager/abhro/home.nix;
  };
}
