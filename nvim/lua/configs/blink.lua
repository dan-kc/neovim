return {
  'blink.cmp',
  after = function()
    require('blink.cmp').setup {
      keymap = {
        preset = 'none',
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-e>'] = { 'cancel', 'fallback' },
      },
      completion = {
        keyword = {
          range = 'full',
        },
        list = {
          selection = { preselect = true, auto_insert = false },
        },
        menu = {
          max_height = 5,
          draw = {
            columns = {
              { 'label', 'label_description', gap = 2 },
              { 'kind_icon', 'source', gap = 2 },
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
        ghost_text = { enabled = true },
        documentation = { auto_show = false },
      },
      sources = {
        default = { 'lsp', 'path', 'buffer' },
        providers = {
          lsp = {
            transform_items = function(_, items)
              return vim.tbl_filter(function(item)
                return item.client_name ~= 'marksman'
              end, items)
            end,
          },
        },
      },
      fuzzy = { implementation = 'rust' },
    }
  end,
}
