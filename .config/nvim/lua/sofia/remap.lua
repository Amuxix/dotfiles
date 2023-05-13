-- Leader key is a key you start custom keybinds with. This gives you another layer. Remeber, these are vim keybinds, so it's ordered. "<leader>cd" means you have to press space *then* c *then* d

-- set leader to space
vim.g.mapleader = " "

-- set vim's internal file manager to "space-c-d"
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Make vim center the screen (zz) when going to insert mode. It'll be disorientating at first, but it's great.
vim.keymap.set("n", "i", "zzi")
vim.keymap.set("n", "I", "zzI")
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

-- Move lines around. In normal, shift-k/J will move line under cursor up or down, in visual, the while block will move
vim.keymap.set("n", "K", ":m -2<cr>")
vim.keymap.set("n", "J", ":m +1<cr>")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Better movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Cancel search with Control-C
vim.keymap.set("n", "<C-c>", ":noh<CR>")

vim.keymap.set("n", "QQ", ":q!")
