-- Leader key is a key you start custom keybinds with. This gives you another layer. Remeber, these are vim keybinds, so it's ordered. "<leader>cd" means you have to press space *then* c *then* d

-- set leader to space
vim.g.mapleader = " "

-- set vim's internal file manager to "space-c-d"
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Make vim center the screen (zz) when going to insert mode. It'll be disorientating at first, but it's great.
vim.keymap.set("n", "a", "zza")
vim.keymap.set("n", "A", "zzA")
vim.keymap.set("n", "o", "zzo")
vim.keymap.set("n", "O", "zzO")

-- "q" starts a macro be default. Now does nothing.
vim.keymap.set("n", "q", "<Nop>")

-- "p" usually pastes clipboard *and* copies to current clipboard. You might want to paste one thing all over, so this keybind sets space-p to paste and copy to the null (delete) clipboard, so you keep your current copy
vim.keymap.set("x", "<leader>p", [["_dP]])

-- space-y to copy to your computer's clipboard. Usefull if you want to copy something to discord e.d.
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- space-d, same as space-p
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "dd", [["_dd]])


-- Cancel search with Control-Q
vim.keymap.set("n", "<C-q>", ":noh<CR>")

-- Quit without saving
vim.keymap.set("n", "QQ", ":q!<CR>")

-- Movement
vim.keymap.set({"n", "o", "v", "x"}, "m", "h")
vim.keymap.set({"n", "o", "v", "x"}, "n", "j")
vim.keymap.set({"n", "o", "v", "x"}, "e", "k")
vim.keymap.set({"n", "o", "v", "x"}, "i", "l")
-- Word movement
vim.keymap.set({"n", "o", "v", "x"}, "j", "b")
vim.keymap.set({"n", "o", "v", "x"}, "r", "e")
vim.keymap.set({"n", "o", "v", "x"}, "J", "B")
vim.keymap.set({"n", "o", "v", "x"}, "R", "E")
-- Page Movement
vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")

-- Insert
vim.keymap.set("n", "t", "zzi")
vim.keymap.set("n", "T", "zzI")

-- Cut Copy Paste
vim.keymap.set({"n", "o", "v", "x"}, "<C-x>", "d")
vim.keymap.set({"n", "o", "v", "x"}, "<C-X>", "dd")
vim.keymap.set({"n", "o", "v", "x"}, "<C-c>", "y")
vim.keymap.set({"n", "o", "v", "x"}, "<C-C>", "yy")
vim.keymap.set({"n", "o", "v", "x"}, "<C-v>", "p")
vim.keymap.set({"n", "o", "v", "x"}, "<C-V>", "P")

-- Undo and Redo
vim.keymap.set({"n", "o", "v", "x"}, "<C-z>", "u")
vim.keymap.set({"n", "o", "v", "x"}, "<C-y>", "<C-R>")

-- Move lines around. In normal, shift-N/E will move line under cursor up or down, in visual, the while block will move
vim.keymap.set("n", "N", ":move +1<cr>")
vim.keymap.set("n", "E", ":move -2<cr>")
vim.keymap.set("v", "N", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "E", ":move '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-N>", ":copy.<cr>")
vim.keymap.set("v", "<C-N>", ":'<,'>copy '><cr>")

