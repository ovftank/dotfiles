local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettier.with({
    filetypes = { "html", "json", "yaml", "markdown" },
  }),
  b.diagnostics.write_good,
  b.code_actions.gitsigns.with({
    filetypes = { "yaml" },
  }),

  -- eslint stuff
  b.formatting.eslint.with({
    filetypes = { "js", "jsx", "ts", "tsx" },
    formatter = "codeframe",
  }),

  -- CPP
  b.formatting.clang_format.with({
    filetypes = { "c", "cpp", "h" },
  }),
  b.diagnostics.cppcheck.with({
    filetypes = { "c", "cpp", "h" },
  }),

  -- Lua
  b.formatting.stylua.with({
    filetypes = { "lua" },
  }),

  -- Shell
  b.formatting.shfmt.with({
    extra_args = { "-i", "2", "-ci" },
  }),
  b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
}

null_ls.setup({
  debug = true,
  sources = sources,
})
