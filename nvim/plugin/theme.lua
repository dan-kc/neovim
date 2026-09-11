if vim.g.did_load_theme_plugin then
  return
end
vim.g.did_load_theme_plugin = true

local base16_yaml_file = vim.fn.expand('~/.config/theme.yaml')

local function use_fallback_theme()
  require('base16-colorscheme')
  vim.cmd('colorscheme base16-rose-pine')
end

if vim.fn.filereadable(base16_yaml_file) == 1 then
  local file_content = vim.fn.readfile(base16_yaml_file)
  local yaml_string = table.concat(file_content, '\n')
  local lyaml = require('lyaml')
  local success, parsed_data = pcall(lyaml.load, yaml_string)

  if success and type(parsed_data) == 'table' then
    local base16_palette = {}
    local missing_colors = {}

    for index = 0, 15 do
      local name = string.format('base%02X', index)
      local value = parsed_data[name]

      if value == nil or tostring(value) == '' then
        table.insert(missing_colors, name)
      else
        local color = tostring(value)
        base16_palette[name] = color:sub(1, 1) == '#' and color or '#' .. color
      end
    end

    if #missing_colors > 0 then
      vim.notify(
        'Ignoring incomplete Base16 palette; missing: ' .. table.concat(missing_colors, ', '),
        vim.log.levels.WARN
      )
      use_fallback_theme()
      return
    end

    require('base16-colorscheme').setup(base16_palette, {
      telescope = true,
      telescope_borders = false,
      indentblankline = true,
      notify = true,
      ts_rainbow = true,
      cmp = true,
      illuminate = true,
      lsp_semantic = true,
      mini_completion = true,
      dapui = true,
    })

    -- setup() does not emit ColorScheme like :colorscheme does.  Mark this as
    -- a Base16 theme and notify plugins such as lualine so they can rebuild
    -- highlights from the palette that has just been applied.
    vim.g.colors_name = 'base16-custom'
    vim.api.nvim_exec_autocmds('ColorScheme', { pattern = vim.g.colors_name })
  else
    use_fallback_theme()
  end
else
  use_fallback_theme()
end
