local fn = vim.fn

-- Packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_TGBIZTANK = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer ...")
  vim.cmd([[packadd packer.nvim]])
end

local ok, packer = pcall(require, "packer")
if not ok then
  return
end

-- install packer.nvim
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]) -- install packer.nvim if not installed yet and then load it automatically on VimEnter

-- create a popup window for packer to use
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" }) -- rounded border for prettier look and feel :)
    end, -- function to open a new window for packer to use
  },
})

-- plugins
packer.startup(function(use)
  -- use.add("wbthomason/packer.nvim") -- use packer.nvim as a plugin (packer.nvim is a plugin)

  -- user interface
  use("romgrk/barbar.nvim") -- bar
  use("Mofiqul/dracula.nvim") -- dracula theme for vim
  use("lukas-reineke/indent-blankline.nvim") -- indent blank line after a function definition (e.g. function foo()) { ... } { ... } -> function foo() { ... }
  use("nvim-lualine/lualine.nvim") -- show lua line bar on the bottom of the screen
  use("onsails/lspkind.nvim") -- lsp kind
  use("norcalli/nvim-colorizer.lua") -- syntax highlight color
  use("kyazdani42/nvim-web-devicons") -- show icons for web languages in the gutter (html, css, js, etc)
  use("RRethy/vim-illuminate") -- highlight matching parens and current line in vim and tmux

  -- code completion and tools for vim
  use("github/copilot.vim") -- copilot
  use("hrsh7th/cmp-copilot") -- copilot (code completion)
  use({ "turbio/bracey.vim", run = "npm install --prefix server" }) -- live edit html, css, and javascript

  -- cmp
  use("hrsh7th/nvim-cmp") -- cmp plugin
  use("hrsh7th/cmp-buffer") -- show buffer name and line number in the completion popup
  use("hrsh7th/cmp-cmdline") -- show cmdline
  use("hrsh7th/cmp-nvim-lsp") -- lsp completion (works with lsp-mode)
  use("hrsh7th/cmp-path") -- show path in the cmdline (e.g. /home/user/project/file.lua:1)
  use("saadparwaiz1/cmp_luasnip") -- luasnip cmp

  -- lsp
  use("jose-elias-alvarez/null-ls.nvim") -- lsp server for lua and javascript language server
  use("neovim/nvim-lspconfig") -- lsp config
  use("williamboman/nvim-lsp-installer") -- install lsp
  -- snip
  use("rafamadriz/friendly-snippets") -- snippet
  use("L3MON4D3/LuaSnip") -- lua snippets

  -- autopairs,comment,and format tools for code
  use("windwp/nvim-autopairs") -- auto pair for lua and html tags and etc. (like <,>,{,},[,],(,),) etc.)
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
        }) -- comment plugin
  use("wesleimp/stylua.nvim") -- syntax for lua script file

  -- text editor tools and utilities (not lsp)
  use("nvim-treesitter/nvim-treesitter") -- syntax tree plugin
  use("JoosepAlviste/nvim-ts-context-commentstring") -- comment string for ts context menu plugin

  -- telescope
  use("nvim-lua/plenary.nvim") -- plenary plugin for vim
  use("nvim-telescope/telescope.nvim") -- telescope plugin for vim

  -- others
  use("kyazdani42/nvim-tree.lua") -- tree view
  use("wbthomason/packer.nvim") -- packer plugin for vim plugin manager
  use("nvim-lua/popup.nvim") -- popup plugin for vim
  use("wakatime/vim-wakatime") -- wakatime

  -- it will automatically set up your config after cloning packer.nvim
  if PACKER_TGBIZTANK then
    require("packer").sync()
  end
end)
