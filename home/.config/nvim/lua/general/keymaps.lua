local M = {}
-- shorten function name
local map = vim.keymap.set
-- noremap and silent
local opts = { noremap = true, silent = true }
-- remap leader key
vim.g.mapleader = "`"
M.general = {
  change_mode = {
    map("x", "<ESC>", ":normal<CR>", opts),
    map("v", "<ESC>", ":normal<CR>", opts),
    map("", "<CR>", "O", opts),
  },
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
    map("", "<F9>", "<cmd>g/^$/d<CR>", opts), -- delete empty line
    map("i", "<F9>", "<cmd>g/^$/d<CR>", opts), -- delete empty line in insert mode
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
    map("c", "<up>", "<nop>"), -- disable up arrow
    map("c", "<down>", "<nop>"), -- disable down arrow
    map("c", "<left>", "<nop>"), -- disable left arrow
    map("c", "<right>", "<nop>"), -- disable right arrow
  },
  find = {
    map("", "<C-f>", "/"), -- find
    map("i", "<C-f>", "<ESC>/"), -- find in insert mode
    disable = {
      map("", "/", "<nop>"), -- disable default mapping
    },
    map("i", "<A-n>", "<ESC>na", opts), -- find next in insert mode
    map("i", "<A-N>", "<ESC>Na", opts), -- find previous in insert mode
  },
  move = {
    map("", "<C-a>", "0", opts), -- move to start of line
    map("i", "<A-k>", "<Up>", opts), -- move up in insert mode
    map("i", "<A-j>", "<Down>", opts), -- move down in insert mode
    map("i", "<A-h>", "<Left>", opts), -- move left in insert mode
    map("i", "<A-l>", "<Right>", opts), -- move right in insert mode
    map("c", "<A-k>", "<Up>"), -- move up in command mode
    map("c", "<A-j>", "<Down>"), -- move down in command mode
    map("c", "<A-h>", "<Left>"), -- move left in command mode
    map("c", "<A-l>", "<Right>"), -- move right in command mode
    map("", "<A-k>", "<Up>", opts), -- move up in normal mode
    map("", "<A-j>", "<Down>", opts), -- move down in normal mode
    map("", "<A-h>", "<Left>", opts), -- move left in normal mode
    map("", "<A-l>", "<Right>", opts), -- move right in normal mode
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
    map("", "<C-k>", "3<C-y>", opts), -- scroll up in normal mode
    map("", "<C-j>", "3<C-e>", opts), -- scroll down in normal mode
    map("i", "<C-k>", "<ESC>3<C-y>a", opts), -- scroll up in insert mode
    map("i", "<C-j>", "<ESC>3<C-e>a", opts), -- scroll down in insert mode
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
return M
