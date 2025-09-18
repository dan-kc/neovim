return {
  'flash.nvim',
  keys = {
    -- Flash jump
    {
      '<leader><space>',
      function()
        require('flash').jump()
      end,
      mode = 'n',
      desc = 'Flash',
    },
    {
      '<leader><space>',
      function()
        require('flash').jump()
      end,
      mode = 'x',
      desc = 'Flash',
    },
    {
      '<leader><space>',
      function()
        require('flash').jump()
      end,
      mode = 'o',
      desc = 'Flash',
    },
    -- Flash treesitter
    {
      'H',
      function()
        require('flash').treesitter()
      end,
      mode = 'n',
      desc = 'Flash Treesitter',
    },
    {
      'H',
      function()
        require('flash').treesitter()
      end,
      mode = 'x',
      desc = 'Flash Treesitter',
    },
    {
      'H',
      function()
        require('flash').treesitter()
      end,
      mode = 'o',
      desc = 'Flash Treesitter',
    },
    -- Remote flash
    {
      'r',
      function()
        require('flash').remote()
      end,
      mode = 'o',
      desc = 'Remote Flash',
    },
    -- Treesitter search
    {
      'R',
      function()
        require('flash').treesitter_search()
      end,
      mode = 'o',
      desc = 'Treesitter Search',
    },
    {
      'R',
      function()
        require('flash').treesitter_search()
      end,
      mode = 'x',
      desc = 'Treesitter Search',
    },
  },
  after = function()
    require('flash').setup {
      label = {
        uppercase = false,
      },
    }
  end,
}
