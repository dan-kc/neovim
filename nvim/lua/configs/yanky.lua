return {
  'yanky.nvim',
  keys = {
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put after' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put before' },
    { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put after and leave cursor after' },
    { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put before and leave cursor after' },
    { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Previous yank entry' },
    { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Next yank entry' },
  },
  after = function()
    require('yanky').setup {
      ring = {
        history_length = 100,
        storage = 'shada',
        sync_with_numbered_registers = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
      },
    }
  end,
}
