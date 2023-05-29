local lsp = require("lsp-zero")

local lsp_keybinds = require('sofia.lsp-keybinds')

lsp.preset("recommended")

lsp.ensure_installed({
  -- Javascript/Typescrip/HTML/CSS
  'tsserver',
  'html',

  -- Python
  'pyright',

  -- Ruby
  -- 'ruby_ls',

  -- Docker
  'dockerls',
  'docker_compose_language_service',

  -- SQL
  'sqlls',

  -- Scripting
  'powershell_es',
  'bashls',

  -- Data formats
  'yamlls',
  'lemminx',
  'taplo',
  'jsonls',
})

-- Lua
-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-Y>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-y>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-s>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(lsp_keybinds.set_keybinds())

lsp.nvim_workspace()

lsp.setup()
