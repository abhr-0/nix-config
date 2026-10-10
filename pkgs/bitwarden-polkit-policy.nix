# NOTE: Needed as bitwarden-destop in not installed as a system package
# Read: https://bitwarden.com/help/biometrics/#set-up-biometrics-for-desktop-app
{ runCommand, bitwarden-desktop }:
# {writeTextFile, bitwarden-desktop}:

# (pkgs.writeTextFile rec {
#   name = "bitwarden-polkit-policy";
#   destination = "/share/polkit-1/actions/com.bitwarden.Bitwarden.policy";
#   text = builtins.readFile ("${pkgs.bitwarden-desktop}" + "${destination}");
# })

# FIXME: Consider downloading from the direct github repo
runCommand "bitwarden-polkit-policy" { } ''
  mkdir -p $out/share/polkit-1/actions
  cp ${bitwarden-desktop}/share/polkit-1/actions/com.bitwarden.Bitwarden.policy $out/share/polkit-1/actions/
''

# final.runCommand "bitwarden-polkit-policy" { } ''
#   mkdir -p $out/share/polkit-1/actions
#   cp ${final.bitwarden-desktop.src}/apps/desktop/resources/com.bitwarden.desktop.policy $out/share/polkit-1/actions/com.bitwarden.Bitwarden.policy
# '';

# final.writeTextFile {
#   name = "bitwarden-polkit-policy";
#   destination = "/share/polkit-1/actions/com.bitwarden.Bitwarden.policy";
#   text = builtins.readFile "${final.bitwarden-desktop.src}/apps/desktop/resources/com.bitwarden.desktop.policy";
# })
