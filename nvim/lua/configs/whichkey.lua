return {
  'which-key.nvim',
  after = function()
    require('which-key').setup {
      preset = 'helix',
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = false,
      },
    }
  end,
}
