{ pkgs, ... }:
let
  username = "abhraneel mukherjee";
  vmname = "win11";
in
pkgs.writeShellScriptBin "winrdp" ''
  if [[ "$(${pkgs.libvirt}/bin/virsh -c qemu:///system domstate ${vmname})" != "running" ]]; then
    ${pkgs.libvirt}/bin/virsh -c qemu:///system start ${vmname}
    sleep 15
  fi

  cmd="${pkgs.freerdp}/bin/xfreerdp \
    /v:$(${pkgs.libvirt}/bin/virsh -c qemu:///system domifaddr ${vmname} \
    | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}') \
    /network:lan /gfx:avc444 /dynamic-resolution /async-update /async-channels /sound /clipboard \
    /cert:tofu /u:\"${username}\" /f /drive:share,$HOME/Public /d:\"\""

  eval "$cmd"
''
# Note: /multimon for multi-monitor setup
