local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end
require("nvim-treesitter.install").prefer_git = true
configs.setup({
  ensure_installed = { "lua", "html", "bash", "javascript", "scheme", "comment" },
  ignore_install = { "" },
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = {},
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  indent_style = { enable = true, disable = { "python", "css" } },
})
require('nvim-ts-autotag').setup()
local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
npairs.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'},
    java = false,
  }
})
local ts_conds = require('nvim-autopairs.ts-conds')
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})
