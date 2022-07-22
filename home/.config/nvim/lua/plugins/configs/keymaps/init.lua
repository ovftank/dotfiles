local M = {}
-- shorten function name
local map = vim.keymap.set
-- noremap and silent
local opts = { noremap = true, silent = true }
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
  },
  lsp = { -- code linting and code analysis (lsp)
    action = {
      map("", "<A-y>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts), -- open lsp action
    },
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
    map("i", "<C-b>", "<ESC>:NvimTreeToggle<CR>", opts), -- toggle tree view in insert mode
  },
  telescope = {
    map("i", "<F1>", "<cmd>Telescope find_files<CR>", opts), -- find files in telescope
    map("", "<F1>", ":Telescope find_files<CR>", opts), -- find files in telescope
    map("i", "<F13>", "<cmd>Telescope live_grep<CR>", opts), -- live grep in telescope
    map("", "<F13>", ":Telescope live_grep<CR>", opts), -- live grep in telescope
    map("", "<F3>", ":Telescope builtin<CR>", opts), -- builtin in telescope
    map("i", "<F3>", "<ESC>:Telescope builtin<CR>", opts), -- builtin in telescope
    -- Alt+j to move to the next file in the tree view
    -- Alt+k to move to the previous file in the tree view
  },
}
return M
