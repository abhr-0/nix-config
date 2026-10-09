# Not used in current setup
{ config }: {
  # Use imports instead when using home-manager as standalone
  # imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/abhro.yaml;
    defaultSopsFormat = "yaml";
  };
}
