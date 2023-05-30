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
vim.keymap.set("n", "q", "")

-- "p" usually pastes clipboard *and* copies to current clipboard. You might want to paste one thing all over, so this keybind sets space-p to paste and copy to the null (delete) clipboard, so you keep your current copy
vim.keymap.set("x", "<leader>p", [["_dP]])

-- space-y to copy to your computer's clipboard. Usefull if you want to copy something to discord e.d.
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- space-d, same as space-p
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "dd", [["_dd]])


-- Cancel search with Control-Q
vim.keymap.set("n", "<C-q>", "<cmd>noh<cr>")

-- Quit without saving
vim.keymap.set("n", "QQ", "<cmd>q!<cr>")

-- Movement
vim.keymap.set({"n", "v"}, "m", "h")
vim.keymap.set({"n", "v"}, "n", "j")
vim.keymap.set({"n", "v"}, "e", "k")
vim.keymap.set({"n", "v"}, "i", "l")
-- Word movement
vim.keymap.set({"n", "v"}, "j", "b")
vim.keymap.set({"n", "v"}, "r", "e")
vim.keymap.set({"n", "v"}, "J", "B")
vim.keymap.set({"n", "v"}, "R", "E")
-- Page Movement
vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")

-- Insert
vim.keymap.set("n", "t", "zzi")
vim.keymap.set("n", "T", "zzI")

-- Cut Copy Paste
vim.keymap.set({"n", "v"}, "<C-x>", "d")
vim.keymap.set({"n", "v"}, "<C-X>", "dd")
vim.keymap.set({"n", "v"}, "<C-c>", "y")
vim.keymap.set({"n", "v"}, "<C-C>", "yy")
vim.keymap.set({"n", "v"}, "<C-v>", "p")
vim.keymap.set({"n", "v"}, "<C-V>", "P")

-- Undo and Redo
vim.keymap.set({"n", "v"}, "<C-z>", "u")
vim.keymap.set({"n", "v"}, "<C-y>", "<C-R>")

-- Save
vim.keymap.set({"n", "v"}, "<C-s>", "<cmd>w<cr>")

-- Move lines around. In normal, shift-N/E will move line under cursor up or down, in visual, the while block will move
vim.keymap.set("n", "N", "<cmd>move +1<cr>")
vim.keymap.set("n", "E", "<cmd>move -2<cr>")
vim.keymap.set("v", "N", ":move '>+1<cr>gv=gv")
vim.keymap.set("v", "E", ":move '<-2<cr>gv=gv")
vim.keymap.set("n", "<C-N>", "<cmd>copy.<cr>")
vim.keymap.set("v", "<C-N>", "<cmd>'<,'>copy '><cr>")

