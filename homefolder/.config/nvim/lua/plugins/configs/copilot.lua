local M = {}

M.config = function()
  vim.g.copilot_no_tab_map = false
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_tab_fallback = ""
end

return M
