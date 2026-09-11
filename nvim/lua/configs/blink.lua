local pending_menu_visibility
local toggle_generation = 0

local function toggle_completion_menu(cmp)
  local menu = require('blink.cmp.completion.windows.menu')
  local is_visible = cmp.is_menu_visible()

  if pending_menu_visibility ~= nil then
    is_visible = pending_menu_visibility
  end

  pending_menu_visibility = not is_visible
  toggle_generation = toggle_generation + 1
  local generation = toggle_generation

  vim.schedule(function()
    if generation ~= toggle_generation then
      return
    end

    local should_open = pending_menu_visibility
    pending_menu_visibility = nil

    if not should_open then
      menu.close()
    elseif cmp.is_active() and #cmp.get_items() > 0 then
      menu.open()
      menu.update_position()
    else
      cmp.show()
    end
  end)

  return true
end

return {
  'blink.cmp',
  after = function()
    require('blink.cmp').setup {
      keymap = {
        preset = 'none',
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-e>'] = { toggle_completion_menu },
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
              { 'label' },
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
            treesitter = { 'lsp' },
          },
        },
        ghost_text = { enabled = false },
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
