if vim.g.did_load_conform_plugin then
  return
end
vim.g.did_load_conform_plugin = true

require('conform').setup {
  formatters_by_ft = {
    -- Configured
    lua = { 'stylua' },
    nix = { 'nixfmt' },
    rust = { 'rustfmt' },
    go = { 'gofumpt' },
    terraform = { 'tfmt' },
    tf = { 'tfmt' },
    hcl = { 'tfmt' },
    python = { 'black' },
    c = { 'clang_format' },
    html = { 'djlint' },
    typescript = { 'prettier' },
    javascript = { 'prettier' },
    tsx = { 'prettier' },
    jsx = { 'prettier' },
    css = { 'prettier' },
    scss = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    graphql = { 'prettier' },
    handlebars = { 'prettier' },

    -- To be configured
    toml = { 'taplo' },

    -- Go toml, docker,
    -- proto = { 'buf' },
  },
  -- ft_parsers = {
  --   html = 'html',
  -- },
  formatters = {
    tfmt = {
      command = 'tofu',
      args = { 'fmt', '-' },
      stdin = true,
    },
  },
}

opts = {
  async = true,
  lsp_fallback = false,
}

vim.keymap.set('n', '<leader>.', function()
  require('conform').format(opts)
end, { noremap = true, silent = true, desc = 'Format buffer' })
