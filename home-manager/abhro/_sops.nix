# Not used in current setup
{ inputs, ... }:
{
  # Use imports instead when using home-manager as standalone
  # imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "/home/abhro/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.nix-secrets}/secrets/abhro.yaml";
    defaultSopsFormat = "yaml";
  };
}
