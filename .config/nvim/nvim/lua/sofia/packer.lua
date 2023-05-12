    vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Telescope fuzzy finder. The best way to move around vim.
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.1",
    requires = {
      {"nvim-lua/plenary.nvim"}
    }
  }

  -- Get yourself a nice tree view on the left-hand-side when you want it.
  use { "nvim-tree/nvim-tree.lua" }
  use { 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} }
  use { 'nvim-treesitter/nvim-treesitter-context' }

  -- Adds "gc" and "gcc" to comment out based on file-extension
  use { "tpope/vim-commentary" }

  -- Show register content when you try to access it in Neovim. Written in Lua.
  use {
  "tversteeg/registers.nvim",
  config = function()
    require("registers").setup()
  end,
  }

  -- This plugin provides LanguageClient-neovim status indicator for lightline.
  -- use {
  --   "palpatineli/lightline-lsc-nvim",
  --   requires = {
  --       {"autozimu/LanguageClient-neovim"},
  --       {"itchyny/lightline.vim"},
  --   }
  -- }
  use "itchyny/lightline.vim"

  -- Scala metals
  use {
    "scalameta/nvim-metals",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "mfussenegger/nvim-dap" },
    }
  }

  use "lukas-reineke/indent-blankline.nvim"

  -- Better colorcolumn
  use "xiyaowong/virtcolumn.nvim"
end)
