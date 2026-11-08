if vim.g.did_load_lspconfig_plugin then
  return
end
vim.g.did_load_lspconfig_plugin = true

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable('nil_ls')
vim.lsp.enable('gopls')
vim.lsp.config('basedpyright', {
  root_markers = {
    'pyrightconfig.json',
  },
})
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')
vim.lsp.enable('elixirls')
vim.lsp.enable('shopify_theme_ls')

vim.lsp.config('marksman', {
  root_markers = { '.obsidian', '.git' },
})

vim.lsp.enable('marksman')

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global, etc.
      globals = {
        'vim',
        'describe',
        'it',
        'assert',
        'stub',
      },
      disable = {
        'duplicate-set-field',
      },
    },
    workspace = {
      checkThirdParty = false,
    },
    telemetry = {
      enable = false,
    },
  },
})
vim.lsp.enable('lua_ls')

vim.lsp.config('ts_ls', {
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})
vim.lsp.enable('ts_ls')

vim.lsp.config('rust_analyzer', {
  root_markers = {
    'Cargo.toml',
    'rust-project.json',
    '.git',
  },
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})
vim.lsp.enable('rust_analyzer')

vim.lsp.enable('taplo')
vim.lsp.enable('tailwindcss')

vim.lsp.config('terraform-ls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars', 'hcl' },
  root_markers = {
    '.terraform.lock.hcl',
  },
  init_options = {
    ignoreSingleFileWarning = true,
  },
})
vim.lsp.enable('terraform-ls')

vim.lsp.config('astro', {
  init_options = {
    typescript = {
      tsdk = './node_modules/typescript/lib',
    },
  },
})
vim.lsp.enable('astro')
