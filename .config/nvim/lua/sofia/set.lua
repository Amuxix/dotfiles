vim.opt.encoding = "utf-8" -- utf-8 by default

vim.opt.nu = true -- Make line numbers appear to the left of the text
vim.opt.relativenumber = true -- Make these line numbers "relative." It's hard to explain. See what it does by disabeling it. Trust me, you'll want this, it's great for vim keybinds to have it like this

-- Tab display
vim.opt.tabstop = 2 
vim.opt.softtabstop = 2
-- Make the tab key do 2 spaces
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- make "enter" enter to the right indentation level
-- vim.opt.smartindent = true

-- Slightly highlight the line of the cursor
vim.opt.cursorline = true

-- Use system clipboard by default
vim.opt.clipboard = "unnamed"

-- How far can the cursor go to the edge of the screen before the buffer starts scrolling>
vim.opt.scrolloff = 8
vim.opt.sidescrolloff=5

-- Find+replaces settings: This way, you ignore case if there isonly lowercase in the search, but be case-sensitive if there are uppercase characters in the search
vim.opt.ignorecase=true
vim.opt.smartcase=true

-- What to show trailing whitespace as
vim.opt.list = true
vim.opt.listchars = {tab = '▸ ', trail = '·'}

-- Make <> behave like {} and (), probably not needed for scala
vim.opt.matchpairs:append("<:>")

-- How fast to read to see if another program has changed a file
vim.opt.updatetime = 50

-- Visual indication of your code lines getitng too long
vim.opt.colorcolumn = "140"

-- Really nice function: Make text get highlighted in a different colour when you copy it, to give some visual feedback.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})
