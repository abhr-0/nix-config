{ pkgs, ... }:
let
  username = "abhraneel mukherjee";
  vmname = "win11";
  winrdpScript = pkgs.writeShellScriptBin "winrdp" ''
    if [[ "$(${pkgs.libvirt}/bin/virsh -c qemu:///system domstate ${vmname})" != "running" ]]; then
      ${pkgs.libvirt}/bin/virsh -c qemu:///system start ${vmname}
      sleep 35 # Wait for the VM to boot up before trying to connect
    fi

    cmd="${pkgs.freerdp}/bin/xfreerdp \
      /v:$(${pkgs.libvirt}/bin/virsh -c qemu:///system domifaddr ${vmname} \
      | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}') \
      /network:lan /gfx:avc444 /dynamic-resolution /async-update /async-channels /sound /clipboard \
      /cert:tofu /u:\"${username}\" /f /drive:share,$HOME/Public /d:\"\""

    eval "$cmd"
  '';
  # Note: /multimon for multi-monitor setup
in
{
  home.packages = [
    winrdpScript
  ];

  # xdg.desktopEntries not working for some reason
  home.file.".local/share/applications/winrdp.desktop" = {
    executable = true;
    text = ''
      [Desktop Entry]
      Name=Windows RDP
      Exec=${winrdpScript}/bin/winrdp
      Icon=${pkgs.adwaita-icon-theme}/share/icons/Adwaita/scalable/places/network-workgroup.svg
      Type=Application
      Terminal=true
    '';
  };
}
