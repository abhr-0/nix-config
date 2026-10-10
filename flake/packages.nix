{
  perSystem = { pkgs, ... }: {
    packages = {
      blink-cmp-copilot-chat = pkgs.callPackage ../pkgs/blink-cmp-copilot-chat.nix { };
      bitwarden-polkit-policy = pkgs.callPackage ../pkgs/bitwarden-polkit-policy.nix { };
    };
  };
}
