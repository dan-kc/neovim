if vim.g.did_load_treesitter_plugin then
  return
end
vim.g.did_load_treesitter_plugin = true

vim.g.skip_ts_context_comment_string_module = true

-- Disable treesitter highlighting for large files
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local max_filesize = 100 * 1024 -- 100 KiB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      vim.treesitter.stop(args.buf)
    end
  end,
})

-- Textobjects configuration (nvim-treesitter-textobjects)
require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
  },
}

-- Textobject keymaps
local select_keymaps = {
  ['af'] = '@function.outer',
  ['if'] = '@function.inner',
  ['ac'] = '@class.outer',
  ['ic'] = '@class.inner',
  ['aC'] = '@call.outer',
  ['iC'] = '@call.inner',
  ['a#'] = '@comment.outer',
  ['i#'] = '@comment.outer',
  ['ai'] = '@conditional.outer',
  ['ii'] = '@conditional.outer',
  ['al'] = '@loop.outer',
  ['il'] = '@loop.inner',
  ['aP'] = '@parameter.outer',
  ['iP'] = '@parameter.inner',
}

for keymap, query in pairs(select_keymaps) do
  vim.keymap.set({ 'x', 'o' }, keymap, function()
    require('nvim-treesitter-textobjects.select').select_textobject(query)
  end)
end

-- Swap keymaps
vim.keymap.set('n', '<leader>a', function()
  require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
end)
vim.keymap.set('n', '<leader>A', function()
  require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
end)

-- Move keymaps
local move = require('nvim-treesitter-textobjects.move')
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']P', function() move.goto_next_start('@parameter.outer') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[P', function() move.goto_previous_start('@parameter.outer') end)

require('ts_context_commentstring').setup()

-- Tree-sitter based folding (now built into Neovim)
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
