# NOTE: Needed as bitwarden-destop in not installed as a system package
# Read: https://bitwarden.com/help/biometrics/#set-up-biometrics-for-desktop-app
# Source of text: https://github.com/bitwarden/clients/blob/main/apps/desktop/resources/com.bitwarden.desktop.policy
{ writeTextFile }:
writeTextFile {
  name = "bitwarden-polkit-policy";
  destination = "/share/polkit-1/actions/com.bitwarden.Bitwarden.policy";
  text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE policyconfig PUBLIC
     "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
     "http://www.freedesktop.org/standards/PolicyKit/1/policyconfig.dtd">

    <policyconfig>
      <action id="com.bitwarden.Bitwarden.unlock">
        <description>Unlock Bitwarden</description>
        <message>Authenticating to unlock Bitwarden</message>
        <defaults>
          <allow_any>auth_self</allow_any>
          <allow_inactive>auth_self</allow_inactive>
          <allow_active>auth_self</allow_active>
        </defaults>
      </action>
    </policyconfig>
  '';
}
