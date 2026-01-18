return {
  'telescope.nvim',
  keys = {
    {
      '<leader>p',
      function()
        require('telescope').extensions.yank_history.yank_history()
      end,
      mode = { 'n', 'x' },
      desc = 'Open Yank History',
    },
    {
      '<leader>/',
      function()
        require('telescope.builtin').oldfiles {
          cwd_only = true,
          tiebreak = function(current_entry, existing_entry, _)
            -- This ensures that when you are filtering, it's also sorted by last opened time.
            -- https://github.com/nvim-telescope/telescope.nvim/issues/2539#issuecomment-1562510095
            return current_entry.index < existing_entry.index
          end,
        }
      end,
      desc = 'Find recent files in CWD',
    },
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files { hidden = true }
      end,
      desc = '[t]elescope find files',
    },
    {
      '<leader>sg',
      function()
        require('telescope.builtin').live_grep {
          glob_pattern = { '!.git/', '!node_modules/' },
          additional_args = { '--hidden' },
        }
      end,
      desc = '[telescope] live grep',
    },
    {
      "<leader>'",
      require('telescope.builtin').resume,
      desc = '[telescope] resume',
    },
    {
      '<leader>sr',
      require('telescope.builtin').registers,
      desc = '[telescope] search registers',
    },
    {
      '<leader>sq',
      require('telescope.builtin').quickfix,
      desc = '[telescope] live locations',
    },
    {
      '<leader>fg',
      function()
        require('telescope.builtin').git_status({
          layout_config = { preview_cutoff = 0 },
        })
      end,
      desc = '[F]ind [G]it changes',
    },
  },
  after = function()
    local telescope = require('telescope')
    local layout_config = {
      vertical = {
        width = function(_, max_columns)
          return math.floor(max_columns * 0.99)
        end,
        height = function(_, _, max_lines)
          return math.floor(max_lines * 0.99)
        end,
        prompt_position = 'bottom',
        preview_cutoff = 99999,
      },
    }

    telescope.setup {
      defaults = {
        path_display = {
          'truncate',
        },
        layout_strategy = 'vertical',
        layout_config = layout_config,
        preview = {
          treesitter = true,
        },
        history = {
          path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
          limit = 1000,
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
        },
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' },
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        vimgrep_arguments = {
          'rg',
          '-L',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
      },
    }
    telescope.load_extension('fzy_native')
    telescope.load_extension('yank_history')
  end,
}
