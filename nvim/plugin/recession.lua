if vim.g.did_load_recession_plugin then
  return
end
vim.g.did_load_recession_plugin = true

local resession = require('resession')
resession.setup {}

-- Resession does NOTHING automagically, so we have to set up some keymaps
vim.keymap.set('n', '<leader>ss', resession.save)
vim.keymap.set('n', '<leader>sl', resession.load)
vim.keymap.set('n', '<leader>sd', resession.delete)
