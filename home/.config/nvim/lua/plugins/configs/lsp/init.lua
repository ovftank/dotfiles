local ok, _ = pcall(require, "lspconfig")
if not ok then
  return
end

require "plugins.configs.lsp.lsp-installer"
require("plugins.configs.lsp.handlers").setup()
require "plugins.configs.lsp.null-ls"
