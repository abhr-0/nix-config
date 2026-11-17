# abhr-0's NixOS setup

This repo contains my NixOS and Home Manager configuration, plus a standalone Nixvim
(Neovim) config.

> Reminder to self: Make sure to read 'manual-setup.md' to setup the non-nixified things

# Hosts

This configuration is currently used by the following hosts:

| Hostname | Type       | Description                   |
| -------- | ---------- | ----------------------------- |
| `earth`  | 💻 Laptop  | Primary Device                |
| `pluto`  | 🖥 Desktop | Old system, used occasionally |

# Directory structure

| Directory/File Name        | Use                                 |
| -------------------------- | ----------------------------------- |
| `./flake.{nix,lock}`       | Flake inputs and lockfile           |
| `./hosts/*`                | NixOS config specific to each host  |
| `./modules/flake-parts/*`  | Flake outputs (flake-parts modules) |
| `./modules/nixos/*`        | NixOS modules                       |
| `./modules/home-manager/*` | Home Manager modules                |
| `./modules/nixvim/*`       | Nixvim modules                      |
| `./pkgs/*`                 | Local package declarations          |
| `./secrets/*`              | Secrets (Encrypted with sops + age) |
| `./.sops.yaml`             | sops recipients and creation rules  |
| `./.github/*`              | CI workflows and Dependabot         |

`modules/` is split by module class: each directory holds modules for one option
set and evaluator. Anything prefixed with `_` inside it is deliberately inactive —
`import-tree` skips those paths, so they are never evaluated.
