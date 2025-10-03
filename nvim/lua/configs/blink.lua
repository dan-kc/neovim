return {
  'blink.cmp',
  after = function()
    require('blink.cmp').setup {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },

        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-PageUp>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-PageDown>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      completion = {
        keyword = {
          range = 'full',
        },
        list = {
          selection = { preselect = true, auto_insert = false },
        },
        documentation = { auto_show = false },
        menu = {
          draw = {
            columns = {
              { 'label', 'label_description', gap = 2 },
              { 'kind_icon', 'kind' },
            },
          },
        },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { 'lsp', 'path', 'buffer' },
      },
      fuzzy = { implementation = 'rust' },
    }
  end,
}
