{
  imports = [
    ./nixos.nix
    ./pre-commit.nix
    ./shell.nix
    # ./home-manager.nix # Not used currently, as home-manager is being used as a nixos module. Can be enabled if standalone home-manager configuration is needed in the future.
  ];
}
