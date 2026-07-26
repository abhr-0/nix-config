{ config, lib, ... }: {
  virtualisation.vmVariant = {
    virtualisation = {
      cores = 4;
      memorySize = 4096;
      sharedDirectories = { };
    };
    users.users.abhro = {
      isNormalUser = true;
      hashedPasswordFile = lib.mkVMOverride null;
      password = "test";
    };
    home-manager.users.abhro.services.flatpak.packages = lib.mkVMOverride [ ];
    services.usbguard.enable = lib.mkVMOverride false;
    systemSettings =
      (lib.mapAttrs (
        _: value: if value ? enable then (value // { enable = lib.mkVMOverride false; }) else value
      ) config.systemSettings)
      // {
        bootloader = lib.mkVMOverride "none";
      };
  };
}
