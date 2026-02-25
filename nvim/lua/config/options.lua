vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.completeopt = "menuone,noinsert,noselect"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.signcolumn = "yes" -- stable gutter, no layout shift
vim.opt.splitright = true  -- vertical splits open to the right
vim.opt.splitbelow = true  -- horizontal splits open below
vim.opt.updatetime = 250   -- faster CursorHold (LSP hover, gitsigns)

vim.opt.fillchars = { eob = " " }
