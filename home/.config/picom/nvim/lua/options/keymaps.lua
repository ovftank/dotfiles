local M = {}
-- shorten function name
local map = vim.keymap.set
-- noremap and silent
local opts = { noremap = true, silent = true }
-- remap leader key
vim.g.mapleader = "`"

M.general = {

	clear_highlight = {
		map("", "<ESC>", "<ESC><cmd>nohlsearch<CR>", opts), -- clear highlights
		map("i", "<ESC>", "<ESC><cmd>nohlsearch<CR>", opts), -- clear highlights in search -- for insert mode
	},

	delete = {
		map("n", "<BS>", "<C-h>", opts), -- delete on backspace (normal mode)
		map("v", "<BS>", "d", opts), -- delete on backspace (visual)
		map("i", "<BS>", "<C-h>", opts), -- delete on backspace in insert mode

		map("", "<C-u>", "dd", opts), -- delete one line
		map("i", "<C-u>", "<ESC>dda", opts), -- delete one line in insert mode
	},

	disable_arrow_keys = {
		map("", "<up>", "<nop>"), -- disable up arrow
		map("", "<down>", "<nop>"), -- disable down arrow
		map("", "<left>", "<nop>"), -- disable left arrow
		map("", "<right>", "<nop>"), -- disable right arrow

		map("i", "<up>", "<nop>"), -- disable up arrow
		map("i", "<down>", "<nop>"), -- disable down arrow
		map("i", "<left>", "<nop>"), -- disable left arrow
		map("i", "<right>", "<nop>"), -- disable right arrow
	},

	find = {
		map("", "<C-f>", "/"), -- find
		map("i", "<C-f>", "<ESC>/"), -- find in insert mode
	},

	move = {
		map("i", "<A-k>", "<Up>", opts), -- move up in insert mode
		map("i", "<A-j>", "<Down>", opts), -- move down in insert mode
		map("i", "<A-h>", "<Left>", opts), -- move left in insert mode
		map("i", "<A-l>", "<Right>", opts), -- move right in insert mode

		map("", "<C-q>", "^", opts), -- move to start of line in normal mode
		map("", "<C-e>", "$", opts), -- move to end of line in normal mode

		map("i", "<C-q>", "<ESC>^i", opts), -- move to start of line in insert mode
		map("i", "<C-e>", "<END>", opts), -- move to end of line in insert mode

		map("", "<C-l>", "w", opts), -- move to next word in normal mode
		map("", "<C-h>", "b", opts), -- move to previous word in normal mode

		map("i", "<C-l>", "<ESC>wa", opts), -- move to next word in insert mode
		map("i", "<C-h>", "<ESC>bi", opts), -- move to previous word in insert mode

		map("", "<A-q>", "<C-b>", opts), -- move to previous page in normal mode
		map("", "<A-e>", "<C-f>", opts), -- move to next page in normal mode

		map("", "<C-k>", "3<C-y>", opts), -- scoll up in normal mode
		map("", "<C-j>", "3<C-e>", opts), -- scroll down in normal mode

		map("i", "<C-k>", "<ESC>3<C-y>a", opts), -- scoll up in insert mode
		map("i", "<C-j>", "<ESC>3<C-e>a", opts), -- scroll down in insert mode

		map("", "g", "gg", opts), -- move to start of file
	},

	save = {
		map("", "<C-s>", ":w<CR>", opts), -- save
		map("i", "<C-s>", "<ESC>:w<CR>", opts), -- save in insert mode
	},

	select_copy_paste = {
		map("", "<C-a>", "ggVG", opts), -- select all
		map("i", "<C-a>", "<ESC>ggVG", opts), -- select all in insert mode

		map("", "<C-c>", "y", opts), -- copy
		map("n", "<C-v>", "P", opts), -- paste after cursor position (normal mode)
		map("i", "<C-v>", "<ESC>Pa", opts), -- paste after cursor position (insert mode)
		map("v", "<C-v>", "_dP", opts), -- better paste (visual)
	},

	undo_redo = {
		map("", "<C-z>", "u", opts), -- undo last change
		map("i", "<C-z>", "<ESC>u", opts), -- undo last change in insert mode

		map("", "<C-x>", "<CMD>redo<CR>", opts), -- redo
		map("i", "<C-x>", "<CMD>redo<CR>", opts), -- redo in insert mode
	},

	visual_stay_indent_mode = {
		map("v", "<", "<gv", opts), -- visual mode stay in indent mode
		map("v", ">", ">gv", opts), -- visual mode stay in indent mode
	},
}
M.plugins = {
	barbar = { -- buffer bar on the top
		map("", "<A-,>", "<CMD>BufferPrevious<CR>", opts), -- go to previous buffer
		map("", "<A-.>", "<CMD>BufferNext<CR>", opts), -- go to next buffer

		map("i", "<A-,>", "<CMD>BufferPrevious<CR>", opts), -- go to previous buffer in insert mode
		map("i", "<A-.>", "<CMD>BufferNext<CR>", opts), -- go to next buffer -- for insert mode

		close = {
			map("", "<C-w>", "<CMD>BufferClose<CR>", opts), -- close current buffer
			map("i", "<C-w>", "<CMD>BufferClose<CR>", opts), -- close current buffer in insert mode
		},
	},

	bracey = { -- live editing html, css, js,
		map("", "<F5>", ":Bracey<CR>", opts), -- open browser with Bracey
		map("i", "<F5>", "<ESC>:Bracey<CR>", opts), -- open browser with Bracey in insert mode

		map("", "<F17>", ":BraceyReload<CR>", opts), -- reload browser
		map("i", "<F17>", "<ESC>:BraceyReload<CR>", opts), -- reload browser
	},

	comment = { -- comment/uncomment
		map("", "<C-_>", "<CMD>lua require('Comment.api').toggle_current_linewise()<CR>", opts), -- toggle comment on current line
		map("i", "<C-_>", "<CMD>lua require('Comment.api').toggle_current_linewise()<CR>", opts), -- toggle comment on current line in insert mode
		map("x", "<C-_>", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"), -- toggle comment on current line in visual mode
	},

	copilot = { -- ai code completion
		map("", "<A-p>", "<CMD>Copilot<CR>", opts), -- open copilot
		map("i", "<A-p>", "<CMD>Copilot<CR>", opts), -- open copilot in insert mode

		map("i", "<A-q>", "<Plug>(copilot-previous)", opts), -- previous completion
		map("i", "<A-e>", "<Plug>(copilot-next)", opts), -- next completion
	},

	lsp = { -- code linting and code analysis (lsp)
		definition = { -- displays the definition of the symbol under the cursor
			map("", "<A-u>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts), -- definition
			map("i", "<A-u>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts), -- definition in insert mode
		},
		diagnostic = {
			map("", "<A-a>", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts), -- go to previous diagnostic
			map("", "<A-d>", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts), -- go to next diagnostic

			map("i", "<A-a>", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts), -- go to previous diagnostic in insert mode
			map("i", "<A-d>", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts), -- go to next diagnostic in insert mode
		},
		formatting = { -- format the current file
			map("", "<C-o>", "<CMD>lua vim.lsp.buf.formatting_sync()<CR>", opts),
			map("i", "<C-o>", "<CMD>lua vim.lsp.buf.formatting_sync()<CR>", opts),
		},
		hover = { -- displays hover information about the symbol under the cursor
			map("", "<A-i>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts),
			map("i", "<A-i>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts),
		},
		references = { -- displays references to the symbol under the cursor
			map("", "<A-o>", "<cmd>lua vim.lsp.buf.references()<CR>", opts),
			map("i", "<A-o>", "<cmd>lua vim.lsp.buf.references()<CR>", opts),
		},
		rename = { -- renames all references to the symbol under the cursor
			map("", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts),
			map("i", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts),
		},
	},

	nvim_tree = { -- file tree view
		map("", "<C-b>", "<CMD>NvimTreeToggle<CR>", opts), -- toggle tree view
		map("i", "<C-b>", "<CMD>NvimTreeToggle<CR>", opts), -- toggle tree view in insert mode
	},

	telescope = {
		map("i", "<F1>", "<cmd>Telescope find_files<CR>", opts), -- find files in telescope
		map("", "<F1>", ":Telescope find_files<CR>", opts), -- find files in telescope
		map("i", "<F13>", "<cmd>Telescope live_grep<CR>", opts), -- live grep in telescope
		map("", "<F13>", ":Telescope live_grep<CR>", opts), -- live grep in telescope

		map("", "<F3>", ":Telescope builtin<CR>", opts), -- builtin in telescope
		map("i", "<F3>", "<ESC>:Telescope builtin<CR>", opts), -- builtin in telescope
	},
}
return M
