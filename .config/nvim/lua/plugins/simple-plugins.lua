return {
  -- Better colorcolumn
  { "xiyaowong/virtcolumn.nvim" },

  -- Adds "gc" and "gcc" to comment out based on file-extension
  { "tpope/vim-commentary" },

  { "ConradIrwin/vim-bracketed-paste" },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-fugitive" },


  -- Show register content when you try to access it in Neovim. Written in Lua.
  {
    "tversteeg/registers.nvim",
    config = function()
      require("registers").setup()
    end,
  },
}
