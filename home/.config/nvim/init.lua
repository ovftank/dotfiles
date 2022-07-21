-- plugins
-- require("plugins.packer")
require("plugins.plugins")
-- optional
require("options.general")
require("options.keymaps")
-- config code
require("plugins.configs.code.autopairs")
require("plugins.configs.code.cmp")
require("plugins.configs.code.comment")
require("plugins.configs.code.copilot")
-- code.lsp
require("plugins.configs.lsp")
-- other
require("plugins.configs.nvim-tree")
require("plugins.configs.telescope")
require("plugins.configs.treesitter")
-- configs interface plugins
require("plugins.configs.interface.barbar")
require("plugins.configs.interface.colorizer")
require("plugins.configs.interface.dracula")
require("plugins.configs.interface.indent-blankline")
require("plugins.configs.interface.lualine")
