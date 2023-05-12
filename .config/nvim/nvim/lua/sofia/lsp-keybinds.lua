local NAME = "lsp-keybinds"

local function set_keybinds()
    -- you should be able to understand what this does by now.
    vim.keymap.set("n", "gd",  vim.lsp.buf.definition)
    vim.keymap.set("n", "<leader>j",  vim.lsp.buf.hover)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
    vim.keymap.set("n", "gr", vim.lsp.buf.references)
    vim.keymap.set("n", "gDs", vim.lsp.buf.document_symbol)
    vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
    vim.keymap.set("n", "F", vim.lsp.buf.format)

    -- The only one that you might not like: automatically format on save. autocmd does not work in lua jet, so we have to use vim.cmd
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
end

return {set_keybinds = set_keybinds}
