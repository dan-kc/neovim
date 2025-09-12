if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = false,
  }
end)

vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame <CR>', { desc = 'Git blame line' })
