local M = {}

function M.setup()
  if vim.fn.has('macunix') == 0 or not vim.env.SSH_TTY then
    return
  end

  if vim.fn.executable('pbcopy') == 0 or vim.fn.executable('pbpaste') == 0 then
    return
  end

  -- Copy still goes through the SSH-aware pbcopy wrapper, and cache_enabled
  -- keeps the last yank available for put commands inside the same Neovim session.
  vim.g.clipboard = {
    name = 'ssh-pbcopy',
    copy = {
      ['+'] = { 'pbcopy' },
      ['*'] = { 'pbcopy' },
    },
    paste = {
      ['+'] = { 'pbpaste' },
      ['*'] = { 'pbpaste' },
    },
    cache_enabled = 1,
  }
end

return M
