vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Open file explorer" })
-- vim.keymap.set("n", "<leader>t", vim.cmd.terminal, { desc = "Open interactive terminal" })
vim.keymap.set("n", "<leader>ss", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>sq", ":wq<CR>", { desc = "Save and quit file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
