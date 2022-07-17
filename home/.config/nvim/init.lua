-- plugins
-- require("plugins.packer")
require("plugins.plugins")
-- optional
require("options.general")
require("options.keymaps")
-- config plugins
require("plugins.configs.autopairs")
require("plugins.configs.cmp")
require("plugins.configs.comment")
require("plugins.configs.lsp")
require("plugins.configs.nvim-tree")
require("plugins.configs.telescope")
require("plugins.configs.treesitter")
require("plugins.configs.copilot")
-- configs interface plugins
require("plugins.configs.interface.barbar")
require("plugins.configs.interface.colorizer")
require("plugins.configs.interface.dracula")
require("plugins.configs.interface.indent-blankline")
require("plugins.configs.interface.lualine")
