return {
  'nvim-surround',
  before = function()
    vim.g.nvim_surround_no_normal_mappings = true
  end,
  keys = {
    {
      'gs',
      '<Plug>(nvim-surround-normal)',
      desc = 'Add a surrounding pair around a motion',
    },
    {
      'gs',
      '<Plug>(nvim-surround-visual)',
      mode = 'x',
      desc = 'Add a surrounding pair around the visual selection',
    },
    {
      'gss',
      '<Plug>(nvim-surround-normal-cur)',
      desc = 'Add a surrounding pair around the current line',
    },
    {
      'gS',
      '<Plug>(nvim-surround-normal-line)',
      desc = 'Add a surrounding pair around a motion, on new lines',
    },
    {
      'gSS',
      '<Plug>(nvim-surround-normal-cur-line)',
      desc = 'Add a surrounding pair around the current line, on new lines',
    },
    {
      'ds',
      '<Plug>(nvim-surround-delete)',
      desc = 'Delete a surrounding pair',
    },
    {
      'cs',
      '<Plug>(nvim-surround-change)',
      desc = 'Change a surrounding pair',
    },
    {
      'cS',
      '<Plug>(nvim-surround-change-line)',
      desc = 'Change a surrounding pair, putting replacements on new lines',
    },
  },
  after = function()
    require('nvim-surround').setup()
  end,
}
