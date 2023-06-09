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

  use { 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} }
  use { 'nvim-treesitter/nvim-treesitter-context' }
  use { 'HiPhish/nvim-ts-rainbow2' }
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use {
    'sindrets/diffview.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }

  -- Get yourself a nice tree view on the left-hand-side when you want it.
  use { "nvim-tree/nvim-tree.lua" }

  -- Process comments with text like "TODO" properly
  use {
    'folke/todo-comments.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' }
    }
  }

  -- Adds "gc" and "gcc" to comment out based on file-extension
  use { "tpope/vim-commentary" }

  -- Show register content when you try to access it in Neovim. Written in Lua.
  use {
  "tversteeg/registers.nvim",
  config = function()
    require("registers").setup()
  end,
  }


  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use 'folke/trouble.nvim'
  -- use 'mg979/vim-visual-multi'
  use 'ggandor/leap.nvim'
  use 'tpope/vim-fugitive'


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
