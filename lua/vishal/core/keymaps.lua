vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk character sequence" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make window splits equal sized" })
keymap.set("n", "<leader>wx", ":close<CR>", { desc = "Close current split window" })

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", ":tabnew %<CR>", { desc = "Open current buffer in new tab" })
