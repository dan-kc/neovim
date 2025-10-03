return {
  'treesj',
  keys = {
    {
      '<leader>m',
      function()
        require('treesj').toggle()
      end,
      desc = 'Toggle Tree',
    },
  },
  after = function()
    require('treesj').setup {}
  end,
}
