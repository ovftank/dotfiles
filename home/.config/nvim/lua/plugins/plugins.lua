local fn = vim.fn
-- packer clone:
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_CLONE = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end
-- auto reload neovim when files change:
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])
-- don't error out on first use
local ok, packer = pcall(require, "packer")
if not ok then
  return
end
-- create a popup for packer to use:
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" }) -- rounded border for popup window
    end, -- function to open popup window
  },
})
local M = {}
packer.startup(function(use)
  M.userinterface = {
    use("romgrk/barbar.nvim"), -- buffer line on the top of the screen
    use("Mofiqul/dracula.nvim"), -- Dracula theme
    use("lukas-reineke/indent-blankline.nvim"), -- blank line after indentation
    use("nvim-lualine/lualine.nvim"), -- status bar
    use("norcalli/nvim-colorizer.lua"), -- color code highlighting
    use("kyazdani42/nvim-web-devicons"), -- show icons for web languages in the gutter (html, css, js, etc)
    use("RRethy/vim-illuminate"), -- highlight current line
    use("nvim-treesitter/nvim-treesitter"), -- syntax highlighting
    use("JoosepAlviste/nvim-ts-context-commentstring"), -- context comment string highlighting (for ts)
  }
  M.code_complete = {
    use("github/copilot.vim"), -- ai code suggestion
    -- cmp
    use("hrsh7th/nvim-cmp"), -- code completion
    use("hrsh7th/cmp-buffer"), -- code completion for buffer
    use("hrsh7th/cmp-cmdline"), -- command line completion
    use("hrsh7th/cmp-copilot"), -- cmp for copilot plugin
    use("hrsh7th/cmp-nvim-lsp"), -- lsp completion for cmp
    use("hrsh7th/cmp-nvim-lua"), -- lua completion for cmp
    use("hrsh7th/cmp-path"), -- path completion
    use("saadparwaiz1/cmp_luasnip"), -- lua snippet
    -- lsp
    use("jose-elias-alvarez/null-ls.nvim"), -- language server
    use("neovim/nvim-lspconfig"), -- lsp config for nvim
    use("williamboman/nvim-lsp-installer"), -- lsp installer
    -- snippets
    use("rafamadriz/friendly-snippets"), -- vscode friendly snippets
    use("L3MON4D3/LuaSnip"), -- lua snippets
  }
  M.other = {
    use("windwp/nvim-autopairs"), -- auto clode tags
    use({ "turbio/bracey.vim", run = "npm install --prefix server" }), -- live edit html, css, js with bracey
    use("numToStr/Comment.nvim"), -- comment plugin
    use("brymer-meneses/grammar-guard.nvim"),
    use("nvim-lua/plenary.nvim"), -- plenary plugin
    use("nvim-telescope/telescope.nvim"), -- telescope
    use("kyazdani42/nvim-tree.lua"), -- file tree
    use("windwp/nvim-ts-autotag"), -- auto tag for ts
    use("wbthomason/packer.nvim"), -- packer main plugin
    use("wakatime/vim-wakatime"), -- wakatime tracking
  }
  if PACKER_CLONE then
    require("packer").sync()
  end -- sync packer with plugins.lua
  return M
end)
