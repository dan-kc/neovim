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
    liquid = { 'prettier' },

    -- To be configured
    toml = { 'taplo' },

    -- proto = { 'buf' },
  },
  -- ft_parsers = {
  --   html = 'html',
  -- },
  formatters = {
    shopify_liquid_formatter = {
      command = 'shopify',
      args = { 'theme', 'format', '--path', '$FILENAME', '--output', '$TEMP', '--json' },
      -- This is crucial for handling the output of the shopify command
      -- The shopify theme format --json outputs a JSON object with a "content" key
      -- containing the formatted code. We need to extract that.
      stdout = function(args)
        -- Use jq to parse the JSON output and extract the "content" field
        -- If jq is not available, you might need a more complex shell command
        -- to parse the JSON.
        local handle = io.popen("echo '" .. args.stdout:gsub("'", "'\\''") .. "' | jq -r '.content'")
        local output = handle:read('*a')
        handle:close()
        return output
      end,
      -- Optional: Configure stderr or other options if needed
    },
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
