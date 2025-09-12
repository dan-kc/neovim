if vim.g.did_load_fzf_plugin then
  return
end
vim.g.did_load_fzf_plugin = true

local fzf = require('fzf-lua')
fzf.setup {
  winopts = {
    height = 1,
    width = 1,
    preview = {
      vertical = 'up',
    },
  },
  keymap = {
    fzf = {
      true,
      ['ctrl-q'] = 'select-all+accept',
    },
  },
}

vim.keymap.set('n', '<leader>f', function()
  fzf.files {}
end, { desc = 'Find files' })

vim.keymap.set('n', '<leader>F', function()
  fzf.files { hidden = true, no_ignore = true }
end, { desc = 'Find files' })

vim.keymap.set('n', "<leader>'", function()
  fzf.resume {}
end, { desc = 'Resume search' })

vim.keymap.set('n', '<leader>/', function()
  fzf.oldfiles { cwd = vim.loop.cwd(), include_current_session = true }
end, { desc = 'Old files' })

vim.keymap.set('n', '<leader>sg', function()
  fzf.live_grep {
    glob_pattern = { '!.git/', '!node_modules/' },
    additional_args = { '--hidden' },
    multiprocess = true,
  }
end, { desc = 'Live grep' })
