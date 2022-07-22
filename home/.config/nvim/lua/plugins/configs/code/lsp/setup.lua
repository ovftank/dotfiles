local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
require 'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
require 'lspconfig'.html.setup {
  autostart = true,
  capabilities = capabilities,
}
require 'lspconfig'.bashls.setup {
  autostart = true,
}
require 'lspconfig'.diagnosticls.setup {
  autostart = true,
}
require 'lspconfig'.tailwindcss.setup {
  autostart = true,
}
require 'lspconfig'.cssls.setup {
  autostart = true,
  capabilities = capabilities,
}
require 'lspconfig'.stylelint_lsp.setup {
  autostart = true,
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
    }
  }
}
