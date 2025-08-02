{
  description = "abhr-0's NixOS + home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/abhr-0/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

    # Secureboot support
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    hardware.url = "github:nixos/nixos-hardware";

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Templates
    templates = {
      url = "github:the-nix-way/dev-templates";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      # self,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }
      # top@{ config, withSystem, moduleWithSystem, ... }:
      {
        imports = [ inputs.git-hooks-nix.flakeModule ];

        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];

        flake =
          let
            genNixosConfigurations =
              configurationList:
              inputs.nixpkgs.lib.genAttrs configurationList (name: mkNixOS { hostName = name; });
            mkNixOS =
              {
                hostName,
                system ? "x86_64-linux",
              }:
              inputs.nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs hostName system; };
                # > Our main nixos configuration file <
                modules = [ ./hosts/${hostName}/configuration.nix ];
              };
          in
          {
            # Available through 'nixos-rebuild --flake .#your-hostname'
            nixosConfigurations = genNixosConfigurations [
              "desktop"
              "laptop"
            ];

            # Standalone home-manager configuration entrypoint
            # Available through 'home-manager --flake .#your-username@your-hostname'
            homeConfigurations."abhro" = inputs.home-manager.lib.homeManagerConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux"; # Home-manager requires 'pkgs' instance
              extraSpecialArgs = { inherit inputs; };
              # > Our main home-manager configuration file <
              modules = [ ./home-manager/abhro/home.nix ];
            };
          };

        perSystem =
          { config, pkgs, ... }: # { system, ...}
          {
            pre-commit.settings.hooks =
              let
                excludes = [ "hardware-configuration\\.nix" ];
              in
              {
                deadnix = {
                  enable = true;
                  inherit excludes;
                };
                statix = {
                  enable = true;
                  # inherit excludes; # TODO: Does't work: https://github.com/cachix/git-hooks.nix/issues/288
                  settings.ignore = [ "hardware-configuration.nix" ];
                };
                nixfmt-rfc-style = {
                  enable = true;
                  inherit excludes;
                };
              };

            devShells.default = pkgs.mkShell {
              packages = with pkgs; [
                nixd
                nixfmt-rfc-style
              ];

              shellHook = ''
                ${config.pre-commit.installationScript}
              '';
            };
          };
      };
}
