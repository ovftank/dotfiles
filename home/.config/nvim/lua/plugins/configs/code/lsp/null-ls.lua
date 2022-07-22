require("luasnip.loaders.from_vscode").lazy_load()
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.codespell,
    require("null-ls").builtins.diagnostics.stylelint,
    require("null-ls").builtins.formatting.codespell,
    require("null-ls").builtins.formatting.stylelint,
    require("null-ls").builtins.formatting.shellharden,
  },
})
