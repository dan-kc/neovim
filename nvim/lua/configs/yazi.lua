return {
  'yazi.nvim',
  keys = {
    { '<leader>e', '<CMD>Yazi<CR>', desc = 'Open Yazi' },
  },
  after = function()
    require('yazi').setup {
      open_for_directories = false,
      floating_window_scaling_factor = 1,
    }
  end,
}
