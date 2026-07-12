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

local function executable(name)
  return vim.fn.executable(name) == 1
end

local function ra_mux_running()
  if not executable('ra-status') or not executable('ra-client') then
    return false
  end

  local output = vim.fn.system { 'ra-status', '--json' }
  if vim.v.shell_error ~= 0 then
    return false
  end

  local ok, status = pcall(vim.json.decode, output)
  return ok and status.running == true
end

if executable('ra-client') and executable('ra-status') then
  vim.lsp.config('rust_analyzer', {
    cmd = { 'ra-client' },
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
  if ra_mux_running() then
    vim.lsp.enable('rust_analyzer')
  end
end

vim.lsp.config('terraform-ls', {
  cmd = { 'terraform-ls', 'serve' },
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
