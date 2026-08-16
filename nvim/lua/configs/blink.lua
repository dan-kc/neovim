return {
  'blink.cmp',
  after = function()
    require('blink.cmp').setup {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = false,
        ['<C-CR>'] = { 'select_and_accept', 'fallback' },
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
          max_height = 5,
          draw = {
            columns = {
              { 'label', 'label_description', gap = 2 },
              { 'kind_icon', 'kind' },
              { 'source' },
            },
            components = {
              source = {
                width = { max = 20 },
                text = function(ctx)
                  return ctx.item.client_name or ctx.source_name
                end,
                highlight = 'BlinkCmpSource',
              },
            },
          },
        },
        ghost_text = { enabled = false },
      },
      sources = {
        default = { 'lsp', 'path', 'buffer' },
        providers = {
          lsp = {
            transform_items = function(_, items)
              return vim.tbl_filter(function(item)
                return item.client_name ~= 'markdown_oxide'
              end, items)
            end,
          },
        },
      },
      fuzzy = { implementation = 'rust' },
    }
  end,
}
