# abhr-0's NixOS setup

This repo contains my NixOS (+ home-manager) configuration.

> Reminder to self: Make sure to read 'manual-setup.md' to setup the non-nixified things

# Hosts

This configuration is cuurently used by the following hosts:

| Hostname | Type       | Description                   |
| -------- | ---------- | ----------------------------- |
| `earth`  | 💻 Laptop  | Primary Device                |
| `pluto`  | 🖥 Desktop | Old system, used occationally |

# Directory structure

| Directory/File Name        | Use                                 |
| -------------------------- | ----------------------------------  |
| `./flake.nix`              | Flake config                        |
| `./flake.lock`             | Lockfile for flake                  |
| `./flake/*`                | Contains flake-parts modules        |
| `./hosts/*`                | NixOS config specific to each host  |
| `./modules/nixos/*`        | NixOS modules                       |
| `./modules/home-manager/*` | Home Manager modules                |
| `./modules/nixvim/*`       | Nixvim modules                      |
| `./pkgs/*`                 | Local package declarations          |
| `./secrets/*`              | Secrets (Encrypted with sops + age) |

`modules/` is split by module class: each directory holds modules for one option
set and evaluator. Anything prefixed with `_` inside it is deliberately inactive —
`import-tree` skips those paths, so they are never evaluated.


