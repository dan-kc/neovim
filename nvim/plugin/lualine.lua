if vim.g.did_load_lualine_plugin then
  return
end
vim.g.did_load_lualine_plugin = true
local icons = require('user.icons')

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

local auto = require('lualine.themes.auto')
auto.normal.c.bg = '#00000000'
auto.insert.c.bg = '#00000000'
auto.visual.c.bg = '#00000000'
auto.replace.c.bg = '#00000000'
auto.command.c.bg = '#00000000'

auto.normal.b.bg = '#00000000'
auto.insert.b.bg = '#00000000'
auto.visual.b.bg = '#00000000'
auto.replace.b.bg = '#00000000'
auto.command.b.bg = '#00000000'

require('lualine').setup {
  options = {
    theme = auto,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'location', { show_macro_recording } },
    lualine_c = {
      {
        'diagnostics',
        sections = { 'error', 'warn', 'info', 'hint' },
        sources = { 'nvim_diagnostic' },
        symbols = {
          error = string.format('%s%s', icons.more.error, ' '),
          warn = string.format('%s%s', icons.more.warningCircle, ' '),
          info = string.format('%s%s', icons.more.info, ' '),
        },
      },
    },
    lualine_x = {
      'lsp_progress',
    },
    lualine_y = { { 'filename', path = 0 } },
    lualine_z = { { 'branch', icon = icons.git.symbol } },
  },
  extensions = { 'fugitive', 'fzf', 'toggleterm', 'quickfix' },
}
