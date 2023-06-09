local metals = require('metals')
local metals_config = metals.bare_config()

local lsp_keybinds = require('sofia.lsp-keybinds')

metals_config.settings = {
    showImplicitArguments = true,
}

metals_config.on_attach = function(client, bufnr)
    metals.setup_dap()
    lsp_keybinds.set_keybinds()
end

vim.keymap.set('n', '<leader>ws', function()
    metals.hover_worksheet()
end)

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt", "java" },
    callback = function()
        metals.initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})
