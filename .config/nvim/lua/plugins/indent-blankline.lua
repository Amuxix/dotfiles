-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

local function setup()
  show_first_indent_level = false
  max_indent_increase = 1
  use_treesitter = true
  show_current_context = true
  show_current_context_start = true
  char_highlight_list = {
    "rainbowcol1",
    "rainbowcol2",
    "rainbowcol3",
    "rainbowcol4",
    "rainbowcol5",
    "rainbowcol6",
  }
end

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = { list = true },
    config = setup,
}
