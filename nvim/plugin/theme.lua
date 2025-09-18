if vim.g.did_load_theme_plugin then
  return
end
vim.g.did_load_theme_plugin = true

local base16_yaml_file = vim.fn.expand('~/.config/theme.yaml')
local base16_palette = {}

if vim.fn.filereadable(base16_yaml_file) == 1 then
  local file_content = vim.fn.readfile(base16_yaml_file)
  local yaml_string = table.concat(file_content, '\n')
  local lyaml = require('lyaml')
  -- Parse the YAML content
  local success, parsed_data = pcall(lyaml.load, yaml_string)

  if success and type(parsed_data) == 'table' then
    base16_palette['base00'] = '#' .. tostring(parsed_data['base00'])
    base16_palette['base01'] = '#' .. tostring(parsed_data['base01'])
    base16_palette['base02'] = '#' .. tostring(parsed_data['base02'])
    base16_palette['base03'] = '#' .. tostring(parsed_data['base03'])
    base16_palette['base04'] = '#' .. tostring(parsed_data['base04'])
    base16_palette['base05'] = '#' .. tostring(parsed_data['base05'])
    base16_palette['base06'] = '#' .. tostring(parsed_data['base06'])
    base16_palette['base07'] = '#' .. tostring(parsed_data['base07'])
    base16_palette['base08'] = '#' .. tostring(parsed_data['base08'])
    base16_palette['base09'] = '#' .. tostring(parsed_data['base09'])
    base16_palette['base0A'] = '#' .. tostring(parsed_data['base0A'])
    base16_palette['base0B'] = '#' .. tostring(parsed_data['base0B'])
    base16_palette['base0C'] = '#' .. tostring(parsed_data['base0C'])
    base16_palette['base0D'] = '#' .. tostring(parsed_data['base0D'])
    base16_palette['base0E'] = '#' .. tostring(parsed_data['base0E'])
    base16_palette['base0F'] = '#' .. tostring(parsed_data['base0F'])

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
  else
    require('base16-colorscheme')
    vim.cmd('colorscheme base16-rose-pine')
  end
else
  require('base16-colorscheme')
  vim.cmd('colorscheme base16-rose-pine')
end
