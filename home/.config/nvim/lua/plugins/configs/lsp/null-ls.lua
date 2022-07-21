require("luasnip.loaders.from_vscode").lazy_load()
require("null-ls").setup({
	debug = true,
	sources = {
		require("null-ls").builtins.diagnostics.shellcheck,
		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.completion.tags,
		require("null-ls").builtins.diagnostics.codespell,
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.diagnostics.stylelint,
		require("null-ls").builtins.formatting.beautysh,
		require("null-ls").builtins.formatting.codespell,
		require("null-ls").builtins.formatting.eslint,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.stylelint,
		require("null-ls").builtins.formatting.stylua,
	},
})
