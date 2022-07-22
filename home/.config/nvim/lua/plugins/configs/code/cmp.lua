require("luasnip/loaders/from_vscode").lazy_load()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_check, cmp = pcall(require, "cmp")
if not cmp_check then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local kind_icons = {
  Copilot = "",
  Namespace = "",
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "ﰠ ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞 ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = " ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = "",
}
local options = {
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"),
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      if _.source.name == "copilot" then
        vim_item.kind = " Copilot"
      end
      return vim_item
    end,
  },
  mapping = {
    ["<C-g>"] = cmp.mapping.complete(),
    ["<C-t>"] = cmp.mapping(function()
      cmp.close()
      cmp.abort()
    end),
    ["<CR>"] = cmp.mapping(function(confirm_selection)
      if cmp.visible() then
        cmp.confirm()
        cmp.close()
      else
        confirm_selection()
      end
    end),
    ["<C-p>"] = cmp.mapping(function(copilot)
      cmp.mapping.abort()
      local copilot_keys = vim.fn["copilot#Accept"]()
      if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
        copilot()
      end
    end),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = 'nvim_lua' },
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
vim.api.nvim_set_hl(0, "CmpBorder", {
  foreground = "#BD93F9",
  background = "#282a36",
})
vim.api.nvim_set_hl(0, "CmpItemAbbr", {
  foreground = "#f8f8f2",
  background = "#282a36",
})
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {
  foreground = "#f8f8f2",
  background = "#282a36",
})
cmp.setup(options)
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
    { name = "copilot" },
  }),
})
