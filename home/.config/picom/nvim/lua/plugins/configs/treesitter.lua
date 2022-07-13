local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

require("nvim-treesitter.install").prefer_git = true

configs.setup({
	ensure_installed = { "lua", "vim", "html", "bash", "javascript", "scheme", "php", "comment" }, -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		use_languagetree = true,
		disable = {}, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
	indent_style = { enable = true, disable = { "python", "css" } },
})
