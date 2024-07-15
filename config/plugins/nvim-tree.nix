{
  plugins.nvim-tree = {
    enable = true;
    openOnSetupFile = true;
    autoReloadOnWrite = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ee";
      action = "<cmd>NvimTreeToggle<CR>";
      options = {
        silent = true;
        desc = "Toggle file explorer";
      };
    }
  ];
}
