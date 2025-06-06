if vim.g.did_load_yazi_plugin then
  return
end
vim.g.did_load_yazi_plugin = true

local yazi = require('yazi')
vim.keymap.set('n', '<leader>e', '<cmd>Yazi<cr>', { desc = 'Open Yazi' })
vim.keymap.set('n', '<leader>E', '<cmd>Yazi cwd<cr>', { desc = 'Open Yazi CWD' })
yazi.setup {
  open_for_directories = false,
}
