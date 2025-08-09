# Abhro's NixOS setup

This repo contains my NixOS (+ home-manager) configuration.

> Reminder to self: Make sure to read 'manual-setup.md' to setup the non-nixified things

# TODO

- [ ] Home-manager should get a dedicated config in NixOS config
- [ ] Check whether usbguard-notifier works
- [ ] Understand the sops setup better and checckout `age.generateKey` option
- [ ] Resolve other TODOs

# Directory structure

| Directory/File Name | Use                                |
| ------------------- | ---------------------------------- |
| `./flake.nix`       | Flake config                       |
| `./flake.lock`      | Locks the version                  |
| `./home-manager/*`  | Home manager config                |
| `./hosts/*`         | NixOS config specific to each host |
| `./nixosModules/*`  | Contains common NixOS modules      |

> This config was initialised using [Mysterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
