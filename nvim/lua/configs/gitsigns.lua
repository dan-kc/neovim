return {
  'gitsigns.nvim',
  after = function()
    require('gitsigns').setup {
      current_line_blame = false,
    }
  end,
}
