{
  imports = [
    ./fidget.nix
    ./none-ls.nix
    ./trouble.nix
  ];

  plugins = {
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        nixd.enable = true;
      };
      keymaps.lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
    lsp-lines = {
      enable = true;
      currentLine = true;
    };
  };
}
