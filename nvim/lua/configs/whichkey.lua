return {
  'which-key.nvim',
  after = function()
    require('which-key').setup {
      preset = 'helix',
    }
  end,
}
