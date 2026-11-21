{ config, lib, ... }:
let
  inherit (lib) mkVMOverride;

  # The only VM knob: features forced off in the VM. Everything not listed here
  # inherits the host's value untouched, so there are no "enable" overrides.
  vmDisabled = [
    "firewalld" # firewall/hardware networking belongs to the physical host
    "fprint"
    "homeWifi"
    "plymouth"
    "printer"
    "secrets" # no age key inside the VM
    "usbguard"
    "virt-manager"
  ];

  # `systemSettings` is a set of independently declared options rather than one
  # option, so the feature set is whatever declares an `enable`. `bootloader`
  # is an enum and is handled separately below.
  featureNames = builtins.attrNames (
    lib.filterAttrs (_: value: builtins.isAttrs value && value ? enable) (config.systemSettings or { })
  );

  unknownVmDisabled = lib.subtractLists featureNames vmDisabled;
in
{
  # Kept at host level: assertions inside `virtualisation.vmVariant` belong to
  # the VM configuration and are only checked when building the VM, so they
  # would not gate host evaluation or `nix flake check`.
  assertions = [
    {
      assertion = unknownVmDisabled == [ ];
      message = "vmVariant: vmDisabled lists unknown feature(s): ${
        lib.concatMapStringsSep ", " (name: "systemSettings.${name}") unknownVmDisabled
      }.";
    }
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      cores = 4;
      memorySize = 4096;
      sharedDirectories = { };
    };
    users.users.abhro = {
      isNormalUser = true;
      hashedPasswordFile = mkVMOverride null;
      password = "test";
    };
    home-manager.users.abhro.services.flatpak.packages =
      lib.mkIf config.systemSettings.home-manager.enable
        (mkVMOverride [ ]);
    systemSettings =
      lib.genAttrs vmDisabled (_: {
        enable = mkVMOverride false;
      })
      // {
        # lanzaboote in a VM drags in secure-boot/TPM services, including one
        # that reboots on success, so no host bootloader is configured here.
        bootloader = mkVMOverride "none";
      };
  };
}
