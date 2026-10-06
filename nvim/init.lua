-- Nord-themed Neovim config (uses the built-in vim.pack plugin manager, nvim 0.12+)

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.pack.add({ "https://github.com/gbprod/nord.nvim" })

require("nord").setup({
	transparent = true,
	borders = true,
	italic = true,
})

vim.cmd.colorscheme("nord")
