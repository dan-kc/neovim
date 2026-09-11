local api = vim.api

local general_group = api.nvim_create_augroup('UserAutocommands', { clear = true })

-- Don't make an undo file if you're editing /tmp/*.
api.nvim_create_autocmd('BufWritePre', {
  group = general_group,
  pattern = '/tmp/*',
  callback = function()
    vim.cmd.setlocal('noundofile')
  end,
})

local format_options_group = api.nvim_create_augroup('UserFormatOptions', { clear = true })

-- Don't auto-wrap while typing or auto-continue comments from normal-mode o/O.
api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  group = format_options_group,
  callback = function()
    vim.opt_local.formatoptions:remove { 't', 'c', 'o' }
  end,
})

local filetype_settings_group = api.nvim_create_augroup('UserFiletypeSettings', { clear = true })

-- Keep hyphens as their own motion unit, even in filetypes (such as Nix) that
-- add them to 'iskeyword'. This makes `foo-bar` three words for w/e motions.
api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  group = filetype_settings_group,
  callback = function()
    vim.opt_local.iskeyword:remove('-')
  end,
})

-- Highlight on yank.
api.nvim_create_autocmd('TextYankPost', {
  group = general_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Wrap Git commit messages. Other filetype-local settings live in
-- after/ftplugin so that they run after Neovim's built-in ftplugins.
local word_wrap_group = api.nvim_create_augroup('UserWordWrap', { clear = true })
api.nvim_create_autocmd('FileType', {
  group = word_wrap_group,
  pattern = 'gitcommit',
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Resize splits when the editor is resized.
api.nvim_create_autocmd('VimResized', {
  group = general_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Go to the last location when opening a buffer.
api.nvim_create_autocmd('BufReadPost', {
  group = general_group,
  callback = function(event)
    local exclude_filetypes = { 'gitcommit', 'gitrebase', 'help', 'fugitive' }

    if vim.tbl_contains(exclude_filetypes, vim.bo[event.buf].filetype) then
      return
    end

    local mark = api.nvim_buf_get_mark(event.buf, '"')
    local line_count = api.nvim_buf_line_count(event.buf)

    if mark[1] > 1 and mark[1] <= line_count then
      pcall(api.nvim_win_set_cursor, 0, mark)
      vim.cmd('normal! zz')
    end
  end,
  desc = 'Go to last location in file after opening',
})

local keymap = vim.keymap
local lsp_group = api.nvim_create_augroup('UserLspConfig', { clear = true })

api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(event)
    local bufnr = event.buf

    local function desc(description)
      return { noremap = true, silent = true, buffer = bufnr, desc = description }
    end

    keymap.set('n', 'gd', vim.lsp.buf.definition, desc('lsp [g]o to [d]efinition'))
    keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('lsp [g]o to [i]mplementation'))
    keymap.set('n', 'gr', vim.lsp.buf.references, desc('lsp [g]et [r]eferences'))
    keymap.set('n', 'K', vim.lsp.buf.hover, desc('[lsp] hover'))
    keymap.set('n', '<space>r', vim.lsp.buf.rename, desc('lsp [r]ename'))
    keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, desc('[lsp] [c]ode [a]ction'))

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- Disable LSP semantic highlighting in favor of Treesitter highlighting.
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
