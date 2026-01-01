if vim.g.did_load_lspconfig_plugin then
  return
end
vim.g.did_load_lspconfig_plugin = true

local icons = require('user.icons')
local lspconfig = require('lspconfig')

-- Defaults are not working for some reason.
lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
  diagnostics = {
    underline = false,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = 'if_many',
      prefix = '●',
      -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      -- prefix = "icons",
    },
    severity_sort = true,
  },
  inlay_hints = {
    enabled = false,
  },
  format = {
    formatting_options = nil,
    timeout_ms = nil,
  },
})

local border = {
  { icons.border.rounded[1], 'LspPreviewBorder' },
  { icons.border.rounded[2], 'LspPreviewBorder' },
  { icons.border.rounded[3], 'LspPreviewBorder' },
  { icons.border.rounded[4], 'LspPreviewBorder' },
  { icons.border.rounded[5], 'LspPreviewBorder' },
  { icons.border.rounded[6], 'LspPreviewBorder' },
  { icons.border.rounded[7], 'LspPreviewBorder' },
  { icons.border.rounded[8], 'LspPreviewBorder' },
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

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
  settings = {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  },
})
vim.lsp.enable('ts_ls')

local ra_multiplex_port = os.getenv('LSPMUX_PORT')

if ra_multiplex_port ~= nil then
  vim.lsp.config('rust_analyzer', {
    cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(ra_multiplex_port)),
    settings = {
      ['rust-analyzer'] = {
        lspMux = {
          version = '1',
          method = 'connect',
          server = 'rust-analyzer',
        },
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
end

vim.lsp.config('terraform-ls', {
  cmd = { 'terraform-ls', 'serve' },
  root_markers = {
    '.terraform.lock.hcl',
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

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindcss = {
      filetypes_exclude = { 'markdown' },
    },
  },
})
vim.lsp.enable('tailwindcss')
