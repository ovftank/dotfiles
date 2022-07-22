local g = vim.g -- vim global variable
local opt = vim.opt -- vim option variable
-- general config --
g.do_filetype_lua = true -- enable lua filetype detection
opt.backup = false -- disable backup files
opt.clipboard = "unnamedplus" -- allow neovim to use system clipboard
opt.completeopt = "menuone,noinsert,noselect" -- set completion options
opt.cursorline = true -- highlight current line
opt.expandtab = true -- expand tabs to spaces
opt.fileencoding = "utf-8" -- set file encoding to utf-8
opt.fillchars.eol = " " -- set end of line character to space
opt.guifont = "monospace:h20" -- set font for gui (default: Monospace:h14)
opt.hidden = true -- hide hidden files in file explorer
opt.ignorecase = true -- ignore case in file explorer
opt.mouse = "a" -- enable mouse support
opt.number = true -- show line numbers
opt.numberwidth = 2 -- set line number width to 4 characters
opt.scrolloff = 8 -- set scroll offset to 8 characters
opt.shiftwidth = 2 -- set shiftwidth to 2 characters
opt.shortmess:append("c") -- disable status line messages
opt.shortmess:append("I") -- disable incremental
opt.showmode = false -- disable show mode in status bar
opt.showtabline = 1 -- show tabline in status bar
opt.sidescrolloff = 8 -- set sidescroll offset to 8 characters
opt.signcolumn = "yes"
opt.smartcase = true -- ignore case in file explorer when searching for files and directories
opt.smartindent = true -- enable smart indentation
opt.swapfile = false -- disable swap file
opt.tabstop = 2 -- set tabstop to 2 characters
opt.termguicolors = true -- enable terminal colors
opt.timeoutlen = 100 -- set timeout length to 100 milliseconds
opt.title = true -- show title in status bar
opt.undofile = true -- enable undo file support
opt.updatetime = 250 -- set update time to 250 milliseconds
opt.whichwrap = "h,l,<,>,[,]" -- set cursor movement wrap around lines
opt.writebackup = false -- disable write backup files to disk on exit
-- disable auto comment on new line
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	command = "set fo-=c fo-=r fo-=o",
})
-- ESC quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> <ESC> :close<CR>
      set nobuflisted
    ]])
	end,
})
-- auto delete trailing space
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> <F8> :%s/\s\+$//<CR>$
      inoremap <silent> <buffer> <F8> <ESC>:%s/\s\+$//<CR>$a
    ]])
	end,
})
