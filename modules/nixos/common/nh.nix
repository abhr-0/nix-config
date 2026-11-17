{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 4 --keep-one";
      dates = "weekly";
    };
    flake = "/home/abhro/Projects/nix-config";
  };
}
