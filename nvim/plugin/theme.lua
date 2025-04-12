if vim.g.did_load_theme_plugin then
  return
end
vim.g.did_load_theme_plugin = true

require('base16-colorscheme')
-- vim.cmd("colorscheme base16-rose-pine")
-- vim.cmd("colorscheme base16-rose-pine-moon")
-- vim.cmd("colorscheme base16-snazzy")
vim.cmd("colorscheme base16-chalk")
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
-- vim.cmd("colorscheme base16-monokai")
-- vim.cmd("colorscheme base16-porple")
-- vim.cmd("colorscheme base16-rebecca")
-- vim.cmd("colorscheme base16-twilight")
-- vim.cmd("colorscheme base16-brewer")
-- vim.cmd("colorscheme base16-harmonic16-dark")
-- vim.cmd("colorscheme base16-danqing")
-- vim.cmd("colorscheme base16-eighties")
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

    -- Barbecue
    'barbecue_normal',

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
  },
}
