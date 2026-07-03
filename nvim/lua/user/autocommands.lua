local api = vim.api

-- Dont make an undo file if you're editing /tmp/*
api.nvim_create_autocmd('BufWritePre', {
  pattern = '/tmp/*',
  callback = function()
    vim.cmd.setlocal('noundofile')
  end,
})

-- Disable spell checking in terminal buffers
-- local nospell_group = api.nvim_create_augroup('nospell', { clear = true })
-- api.nvim_create_autocmd('TermOpen', {
--   group = nospell_group,
--   callback = function()
--     vim.wo[0].spell = false
--   end,
-- })

local format_options_group = api.nvim_create_augroup('UserFormatOptions', {})
local function configure_format_options()
  vim.opt_local.formatoptions:remove { 't', 'c', 'o' }
end

-- Don't auto-wrap while typing or auto-continue comments from normal-mode o/O.
vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  group = format_options_group,
  callback = configure_format_options,
})

-- Nix's ftplugin does not enable insert-mode comment continuation by default.
-- Also disable smartindent so typing "#" does not jump to column 0.
vim.api.nvim_create_autocmd('FileType', {
  group = format_options_group,
  pattern = 'nix',
  callback = function()
    configure_format_options()
    vim.opt_local.formatoptions:append 'r'
    vim.opt_local.smartindent = false
    vim.opt_local.autoindent = true
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- wrap in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('Word wrap', {}),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- go to last location when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(event)
    local exclude_filetypes = { 'gitcommit', 'gitrebase', 'help', 'fugitive' }

    -- If the buffer's filetype is in our exclude list, do nothing
    if vim.tbl_contains(exclude_filetypes, vim.bo[event.buf].filetype) then
      return
    end

    -- Get the last cursor position for the current buffer (from the '"' mark)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)

    -- Check if the mark is valid (not 0, not beyond buffer end)
    -- and if we are not at the very beginning of the file (1,0) to avoid jumping unnecessarily
    if mark[1] > 1 and mark[1] <= line_count then
      -- Attempt to set the cursor. pcall prevents errors if window is invalid.
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      -- Center the cursor in the window
      vim.cmd('normal! zz')
    end
  end,
  desc = 'Go to last location in file after opening',
})

-- LSP stuff
local keymap = vim.keymap
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf

    local function desc(description)
      return { noremap = true, silent = true, buffer = bufnr, desc = description }
    end
    keymap.set('n', 'gd', vim.lsp.buf.definition, desc('lsp [g]o to [d]efinition'))
    keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('lsp [g]o to [i]mplementation'))
    keymap.set('n', 'gr', vim.lsp.buf.references, desc('lsp [g]et [r]eferences'))
    keymap.set('n', 'K', vim.lsp.buf.hover, desc('[lsp] hover'))
    keymap.set('n', '<space>r', vim.lsp.buf.rename, desc('lsp [r]ename'))
    keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, desc('[lsp] [c]ode [a]ction'))

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Remove syntax hilighting from the lsp
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
