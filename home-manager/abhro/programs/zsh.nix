{
  programs.zsh = {
    enable = true; # Must explicity include for direnv and starship

    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "$terminfo[kcuu1]" ];
      searchDownKey = [ "$terminfo[kcud1]" ];
      # Ctrl+U aborts the search
    };

    history = {
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    defaultKeymap = "viins";
  };
}
