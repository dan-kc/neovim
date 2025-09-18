return {
  'conform.nvim',
  keys = {
    {
      '<leader>.',
      function()
        require('conform').format {
          async = true,
          lsp_fallback = false,
        }
      end,
      desc = 'Format buffer',
    },
  },
  after = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'nixfmt' },
        rust = { 'rustfmt' },
        go = { 'gofumpt' },
        terraform = { 'tfmt' },
        tf = { 'tfmt' },
        hcl = { 'tfmt' },
        python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
        c = { 'clang_format' },
        html = { 'prettier' },
        typescript = { 'prettier' },
        javascript = { 'prettier' },
        typescriptreact = { 'prettier' },
        javascriptreact = { 'prettier' },
        tsx = { 'prettier' },
        jsx = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
        handlebars = { 'prettier' },
        liquid = { 'prettier' },
        toml = { 'taplo' },
        astro = { 'prettier' },
      },
      formatters = {
        tfmt = {
          command = 'tofu',
          args = { 'fmt', '-' },
          stdin = true,
        },
      },
    }
  end,
}
