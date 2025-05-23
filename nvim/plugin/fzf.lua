if vim.g.did_load_fzf_plugin then
  return
end
vim.g.did_load_fzf_plugin = true

local fzf = require('fzf-lua')
fzf.setup {}

vim.keymap.set('n', '<leader>f', function()
  fzf.files { hidden = true }
end, { desc = 'Find files' })

vim.keymap.set('n', "<leader>'", function()
  fzf.resume {}
end, { desc = 'Resume search' })

vim.keymap.set('n', '<leader>/', function()
  fzf.oldfiles { cwd = vim.loop.cwd() }
end, { desc = 'Old files' })

vim.keymap.set('n', '<leader>sg', function()
  fzf.live_grep {
    glob_pattern = { '!.git/', '!node_modules/' },
    additional_args = { '--hidden' },
  }
end, { desc = 'Live grep' })
