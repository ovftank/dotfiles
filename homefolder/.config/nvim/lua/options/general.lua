-- using a variable, shorten options
local g = vim.g
local opt = vim.opt

-- general configuration
g.did_load_filetypes = 0 -- disable load filetype.vim on startup (for performance) (default: 1)
g.do_filetype_lua = 1 -- enable load filetype.lua
opt.backup = false -- disable autobackup in nvim (default: true)
opt.clipboard = "unnamed,unnamedplus" -- sync the clipboard between nvim and system clipboard (default: "unnamed")
opt.completeopt = { "menuone", "noselect" } -- disable automatic selection in autocomplete
opt.cul = true -- displays a cursor line 
opt.expandtab = true -- spaces instead of tabs 
opt.fileencoding = "utf-8" -- set file encoding as: utf-8 
opt.fillchars.eob = " " -- convert the character at the end of the buffer to a space 
opt.guifont = "monospace:h17" -- set nvim's font to monospace
opt.hlsearch = true -- highlight the search option
opt.ignorecase = false -- is case sensitive
opt.mouse = "a" -- make the mouse usable
opt.number = true -- at the start of each line, display number
opt.numberwidth = 2 -- gap between the numbers and the margin
opt.pumheight = 10 -- set a height for the complete menu
opt.shiftwidth = 2 -- length of one tab
opt.shortmess:append("c") -- don't give ins-completion-menu messages
opt.showcmd = false -- in the final line of the screen, disable the show (partial) command
opt.showmode = false -- disable show mode (normal,insert,visual)
opt.signcolumn = "yes" -- remove the sign column
opt.smartcase = true -- smartcase search
opt.smartindent = true -- automatic indentation based on syntax
opt.swapfile = false -- disable swap file
opt.termguicolors = true -- using terminal colors as a background
opt.title = true -- displaying the file's title
opt.undofile = true -- infinite undo
opt.updatetime = 250 -- show complete menu faster
opt.writebackup = false -- do not write backup

-- do not automatically comment on new lines.
vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        command = "set fo-=c fo-=r fo-=o",
})

-- highlight copy text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
        callback = function()
                vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
        end,
})

-- use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
        callback = function()
                vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
        end,
})

vim.cmd([[colorscheme dracula]]) -- set the color scheme to "Dracula."
