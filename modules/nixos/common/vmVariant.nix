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
    systemSettings =
      (lib.mapAttrs
        (_: value: if value ? enable then (value // { enable = lib.mkVMOverride false; }) else value)
        # HM stays as configured in the VM, so the VM mirrors the host setup.
        (lib.filterAttrs (name: _: name != "home-manager") config.systemSettings)
      )
      // {
        bootloader = lib.mkVMOverride "none";
      };
  };
}
