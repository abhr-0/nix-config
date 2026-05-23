{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.systemSettings.podman.enable = lib.mkEnableOption "Enable Podman for container management";

  config = lib.mkIf config.systemSettings.podman.enable {
    environment.systemPackages = with pkgs; [ podman-compose ]; # KEEP: `podman compose` uses this

    virtualisation = {
      # Enable common container config files in /etc/containers
      containers.enable = true;

      podman = {
        enable = true;
        dockerCompat = true; # Create `docker` alias for podman

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
