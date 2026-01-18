return {
  'gitsigns.nvim',
  after = function()
    require('gitsigns').setup {
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']g', function()
          if vim.wo.diff then
            return ']g'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[g', function()
          if vim.wo.diff then
            return '[g'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map({ 'n', 'v' }, '<leader>gh', ':Gitsigns preview_hunk<CR>', { desc = 'Preview Hunk' })
        map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage Hunk' })
        map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset Hunk' })

        -- If you're on a line with a change, you can stage/reset that single line:
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select Hunk' })
      end,
    }
  end,
}
