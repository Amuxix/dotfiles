return {
  -- Packer can manage itself
  { "wbthomason/packer.nvim" },

  -- Better colorcolumn
  { "xiyaowong/virtcolumn.nvim" },

  -- Adds "gc" and "gcc" to comment out based on file-extension
  { "tpope/vim-commentary" },

  { "ConradIrwin/vim-bracketed-paste" },
  { "HiPhish/nvim-ts-rainbow2" },
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
