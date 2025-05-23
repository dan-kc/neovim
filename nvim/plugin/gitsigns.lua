if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = true,
    signs = {
      current_line_blame_opts = {
        ignore_whitespace = true,
      },
    },
  }
end)
