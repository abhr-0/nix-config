# abhr-0's NixOS setup

This repo contains my NixOS (+ home-manager) configuration.

> Reminder to self: Make sure to read 'manual-setup.md' to setup the non-nixified things

# Hosts
This configuration is cuurently used by the following hosts:

| Hostname | Type    | Description                   |
| -------- | ------- | ----------------------------- |
| `earth`  | Laptop  | Primary Device                |
| `pluto`  | Desktop | Old system, used occationally |

# Directory structure

| Directory/File Name | Use                                 |
| ------------------- | ----------------------------------  |
| `./flake.nix`       | Flake config                        |
| `./flake.lock`      | Lockfile for flake                  |
| `./home-manager/*`  | Home Manager config                 |
| `./hosts/*`         | NixOS config specific to each host  |
| `./flake/*`         | Contains flake-parts modules        |
| `./nixosModules/*`  | NixOS modules                       |
| `./nixvim/*`        | Nixvim modules                      |
| `./secrets/*`       | Secrets (Encrypted with sops + age) |

