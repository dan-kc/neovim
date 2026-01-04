if vim.g.did_load_yanky_plugin then
  return
end
vim.g.did_load_yanky_plugin = true

require('yanky').setup {
  ring = {
    history_length = 100,
    storage = 'shada',
    sync_with_numbered_registers = true,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 200,
  },
}

vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')
