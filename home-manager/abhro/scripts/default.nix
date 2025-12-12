{ pkgs, ... }:
{
  home.packages = [
    (import ./winrdp.nix { inherit pkgs; })
  ];

  # xdg.desktopEntries not working for some reason
  home.file.".local/share/applications/winrdp.desktop" = {
    executable = true;
    text = ''
      [Desktop Entry]
      Name=Windows RDP
      Exec=${import ./winrdp.nix { inherit pkgs; }}/bin/winrdp
      Icon=${pkgs.adwaita-icon-theme}/share/icons/Adwaita/scalable/places/network-workgroup.svg
      Type=Application
      Terminal=true
    '';
  };
}
