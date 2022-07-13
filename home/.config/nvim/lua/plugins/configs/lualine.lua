local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local dracula = {}
local colors = require("dracula").colors()

local bg = ""
if vim.g.dracula_lualine_bg_color ~= nil then
	bg = vim.g.dracula_lualine_bg_color
else
	bg = colors.black
end

dracula.normal = {
	a = { fg = colors.black, bg = colors.purple, gui = "bold" },
	b = { fg = colors.purple, bg = bg },
	c = { fg = colors.white, bg = bg },
}

dracula.visual = {
	a = { fg = colors.black, bg = colors.pink, gui = "bold" },
	b = { fg = colors.pink, bg = bg },
}

dracula.inactive = {
	a = { fg = colors.white, bg = colors.gray, gui = "bold" },
	b = { fg = colors.black, bg = colors.white },
}

dracula.replace = {
	a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
	b = { fg = colors.yellow, bg = bg },
	c = { fg = colors.white, bg = bg },
}

dracula.insert = {
	a = { fg = colors.black, bg = colors.green, gui = "bold" },
	b = { fg = colors.green, bg = bg },
	c = { fg = colors.white, bg = bg },
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = true,
	always_visible = false,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

local location = {
	"location",
	padding = 0,
}

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "location" },
		lualine_c = { diagnostics },
		lualine_x = { diff, filetype, "fileformat" },
		lualine_y = { "filesize" },
		lualine_z = { "progress" },
	},
})

return dracula
