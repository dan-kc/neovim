if vim.g.did_load_theme_plugin then
  return
end
vim.g.did_load_theme_plugin = true

local base16_yaml_file = vim.fn.expand('~/.local/share/flavours/base16/schemes/generated/generated.yaml')
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

-- require('base16-colorscheme')

-- vim.cmd("colorscheme base16-rose-pine")
-- vim.cmd("colorscheme base16-rose-pine-moon")
-- vim.cmd('colorscheme base16-snazzy')
-- vim.cmd("colorscheme base16-chalk")
-- vim.cmd("colorscheme base16-circus") -- boring
-- vim.cmd("colorscheme base16-solarflare")
-- vim.cmd("colorscheme base16-qualia")
-- vim.cmd("colorscheme base16-materia")
-- vim.cmd("colorscheme base16-material-darker")
-- vim.cmd("colorscheme base16-gigavolt")
-- vim.cmd("colorscheme base16-darkmoss")
-- vim.cmd("colorscheme base16-oceanicnext")
-- vim.cmd("colorscheme base16-ashes")
-- vim.cmd('colorscheme base16-framer')
-- vim.cmd('colorscheme base16-monokai')
-- vim.cmd("colorscheme base16-porple")
-- vim.cmd("colorscheme base16-rebecca")
-- vim.cmd("colorscheme base16-twilight")
-- vim.cmd("colorscheme base16-harmonic16-dark")
-- vim.cmd("colorscheme base16-danqing")
-- vim.cmd('colorscheme base16-eighties')
-- vim.cmd("colorscheme base16-gruvbox-dark-pale")
-- vim.cmd("colorscheme base16-kimber")
-- vim.cmd("set notermguicolors t_Co=16")

require('transparent').setup {
  groups = {
    -- "Must haves"
    'Pmenu',
    'Normal',
    'NormalNC',
    'SignColumn',
    'LspPreviewBorder',
    'NormalFloat',
    'FloatBorder',

    'VertSplit',
    'StatusLine',
    'Comment',
    'Constant',
    'Special',
    'Identifier',
    'Statement',
    'PreProc',
    'Type',
    'Title',
    'Underlined',
    'Todo',
    'String',
    'Function',
    'FloatTitle',
    'FloatShadow',
    'FloatShadowThrough',
    'Conditional',
    'Repeat',
    'Operator',
    'Structure',
    'LineNr',
    'NonText',
    'CursorLineNr',
    'CursorLineFold',
    'FoldColumn',
    'EndOfBuffer',
    'MsgSeparator',
    'cErrInBracket',
  },

  extra_groups = {
    -- Telescope
    'TelescopeNormal',
    -- "TelescopeMatching",
    -- "TelescopeSelection",
    -- "TelescopeSelectionCaret",
    'TelescopePromptNormal',
    'TelescopePromptBorder',
    'TelescopePromptTitle',
    'TelescopePromptPrefix',
    'TelescopeResultsBorder',
    'TelescopeResultsNormal',
    'TelescopeResultsTitle',
    'TelescopePreviewBorder',
    'TelescopePreviewNormal',
    'TelescopePreviewTitle',
    -- "TelescopeResultsDiffChange",
    -- "TelescopeResultsDiffAdd",
    -- "TelescopeResultsDiffDelete",

    -- GitSigns
    'GitSignsChange',
    'GitSignsAdd',
    'GitSignsDelete',
    'GitSignsAddLine',

    -- Diagnostics
    'DiagnosticSignError',
    'DiagnosticSignWarn',
    'DiagnosticSignHint',
    'DiagnosticSignInfo',

    -- NeoTree
    'NeoTreeBufferNumber',
    'NeoTreeCursorLine',
    'NeoTreeDimText',
    'NeoTreeDirectoryIcon',
    'NeoTreeDirectoryName',
    'NeoTreeDotfile',
    'NeoTreeFadeText1',
    'NeoTreeFadeText2',
    'NeoTreeFileIcon',
    'NeoTreeFileName',
    'NeoTreeFileNameOpened',
    'NeoTreeFileStats',
    'NeoTreeFileStatsHeader',
    'NeoTreeFilterTerm',
    'NeoTreeFloatBorder',
    'NeoTreeFloatNormal',
    'NeoTreeFloatTitle',
    'NeoTreeGitAdded',
    'NeoTreeGitConflict',
    'NeoTreeGitDeleted',
    'NeoTreeGitIgnored',
    'NeoTreeGitModified',
    'NeoTreeGitRenamed',
    'NeoTreeGitStaged',
    'NeoTreeGitUntracked',
    'NeoTreeGitUnstaged',
    'NeoTreeHiddenByName',
    'NeoTreeIndentMarker',
    'NeoTreeMessage',
    'NeoTreeModified',
    'NeoTreeNormal',
    'NeoTreeNormalNC',
    'NeoTreeSignColumn',
    'NeoTreeStatusLine',
    'NeoTreeStatusLineNC',
    'NeoTreeTabActive',
    'NeoTreeTabInactive',
    'NeoTreeTabSeparatorActive',
    'NeoTreeTabSeparatorInactive',
    'NeoTreeVertSplit',
    'NeoTreeWinSeparator',
    'NeoTreeEndOfBuffer',
    'NeoTreeRootName',
    'NeoTreeSymbolicLinkTarget',
    'NeoTreeTitleBar',
    'NeoTreeIndentMarker',
    'NeoTreeExpander',
    'NeoTreeWindowsHidden',
    'NeoTreePreview',

    -- Bqf
    -- "BqfPreviewFloat", -- Doesn't work?
    -- "BqfPreviewBorder",
    -- "BqfPreviewTitle",
    -- "BqfPreviewThumb",
    -- "BqfPreviewSbar",
    -- "BqfPreviewCursor",
    -- "BqfPreviewCursorLine",
    -- "BqfPreviewRange",
    -- "BqfPreviewBufLabel",

    -- Lualine
    'lualine_b_insert',
    'lualine_b_normal',
    'lualine_b_replace',
    'lualine_b_command',
    'lualine_b_terminal',
    'lualine_b_inactive',
    'lualine_b_visual',
    'lualine_c_insert',
    'lualine_c_normal',
    'lualine_c_replace',
    'lualine_c_command',
    'lualine_c_terminal',
    'lualine_c_inactive',
    'lualine_c_visual',
    'lualine_c_diagnostics_warn_insert',
    'lualine_c_diagnostics_warn_normal',
    'lualine_c_diagnostics_warn_replace',
    'lualine_c_diagnostics_warn_command',
    'lualine_c_diagnostics_warn_terminal',
    'lualine_c_diagnostics_warn_inactive',
    'lualine_c_diagnostics_warn_visual',
    'lualine_c_diagnostics_info_insert',
    'lualine_c_diagnostics_info_normal',
    'lualine_c_diagnostics_info_replace',
    'lualine_c_diagnostics_info_command',
    'lualine_c_diagnostics_info_terminal',
    'lualine_c_diagnostics_info_inactive',
    'lualine_c_diagnostics_info_visual',
    'lualine_c_diagnostics_error_insert',
    'lualine_c_diagnostics_error_normal',
    'lualine_c_diagnostics_error_replace',
    'lualine_c_diagnostics_error_command',
    'lualine_c_diagnostics_error_terminal',
    'lualine_c_diagnostics_error_inactive',
    'lualine_c_diagnostics_error_visual',
    'lualine_c_diagnostics_hint_insert',
    'lualine_c_diagnostics_hint_normal',
    'lualine_c_diagnostics_hint_replace',
    'lualine_c_diagnostics_hint_command',
    'lualine_c_diagnostics_hint_terminal',
    'lualine_c_diagnostics_hint_inactive',
    'lualine_c_diagnostics_hint_visual',

    -- Cmp
    'CmpItemAbbr',
    'CmpItemKind',
    'CmpItemMenu',
    'CmpGhostText',
    'CmpItemKindEnum',
    'CmpItemKindFile',
    'CmpItemKindText',
    'CmpItemKindUnit',
    'CmpDocumentation',
    'CmpItemAbbrMatch',
    'CmpItemKindClass',
    'CmpItemKindColor',
    'CmpItemKindEvent',
    'CmpItemKindField',
    'CmpItemKindValue',
    'CmpItemKindFolder',
    'CmpItemKindMethod',
    'CmpItemKindModule',
    'CmpItemKindStruct',
    'CmpItemAbbrDefault',
    'CmpItemKindDefault',
    'CmpItemKindKeyword',
    'CmpItemKindSnippet',
    'CmpItemMenuDefault',
    'CmpItemKindConstant',
    'CmpItemKindFunction',
    'CmpItemKindOperator',
    'CmpItemKindProperty',
    'CmpItemKindVariable',
    'CmpItemKindInterface',
    'CmpItemKindReference',
    'CmpItemAbbrDeprecated',
    'CmpItemAbbrMatchFuzzy',
    'CmpItemKindEnumMember',
    'CmpDocumentationBorder',
    'CmpItemKindConstructor',
    'CmpItemKindEnumDefault',
    'CmpItemKindFileDefault',
    'CmpItemKindTextDefault',
    'CmpItemKindUnitDefault',
    'CmpItemAbbrMatchDefault',
    'CmpItemKindClassDefault',
    'CmpItemKindColorDefault',
    'CmpItemKindEventDefault',
    'CmpItemKindFieldDefault',
    'CmpItemKindValueDefault',
    'CmpItemKindFolderDefault',
    'CmpItemKindMethodDefault',
    'CmpItemKindModuleDefault',
    'CmpItemKindStructDefault',
    'CmpItemKindTypeParameter',
    'CmpItemKindKeywordDefault',
    'CmpItemKindSnippetDefault',
    'CmpItemKindConstantDefault',
    'CmpItemKindFunctionDefault',
    'CmpItemKindOperatorDefault',
    'CmpItemKindPropertyDefault',
    'CmpItemKindVariableDefault',
    'CmpItemKindInterfaceDefault',
    'CmpItemKindReferenceDefault',
    'CmpItemAbbrDeprecatedDefault',
    'CmpItemAbbrMatchFuzzyDefault',
    'CmpItemKindEnumMemberDefault',
    'CmpItemKindConstructorDefault',
    'CmpItemKindTypeParameterDefault',

    -- Lazy.nvim
    'LazyButton',
    'LazyButtonActive',
    'LazyDimmed',

    -- Barbecue
    'barbecue_context_property',
    'barbecue_context_field',
    'barbecue_context_constructor',
    'barbecue_context_module',
    'barbecue_context_enum',
    'barbecue_context_namespace',
    'barbecue_context_interface',
    'barbecue_context_package',
    'barbecue_context_function',
    'barbecue_context_class',
    'barbecue_dirname',
    'barbecue_basename',
    'barbecue_context',
    'barbecue_modified',
    'barbecue_context_boolean',
    'barbecue_normal',
    'barbecue_context_array',
    'barbecue_context_object',
    'barbecue_ellipsis',
    'barbecue_context_key',
    'barbecue_separator',
    'barbecue_context_null',
    'barbecue_context_enum_member',
    'barbecue_context_struct',
    'barbecue_context_event',
    'barbecue_context_operator',
    'barbecue_context_type_parameter',
    'barbecue_context',
    'barbecue_context_file',
    'barbecue_context_number',
    'barbecue_context_variable',
    'barbecue_context_method',
    'barbecue_context_constant',
  },
}
