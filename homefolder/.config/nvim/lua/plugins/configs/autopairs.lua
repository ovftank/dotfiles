-- Setup nvim-cmp.
local ok, npairs = pcall(require, "nvim-autopairs") -- luacheck: ignore 631 632 633 634
if not ok then
  return
end

npairs.setup {
  check_ts = true, -- treesitter integration
  disable_filetype = { "TelescopePrompt" }, -- disable autopairs for prompt
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp" -- lua-cmp integration for autopairs plugin
local cmp_ok, cmp = pcall(require, "cmp") 
if not cmp_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
