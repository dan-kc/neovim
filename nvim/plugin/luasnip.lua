if vim.g.did_load_luasnip_plugin then
  return
end
vim.g.did_load_luasnip_plugin = true

local ls = require('luasnip')
local i = ls.insert_node
local t = ls.text_node
local s = ls.snippet
local f = ls.function_node

vim.keymap.set({ 'i' }, '<C-L>', function()
  -- Multi-bracket closing logic
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before_cursor = line:sub(1, col)

  local bracket_map = { ['('] = ')', ['['] = ']', ['<'] = '>', ['{'] = '}' }
  local reverse_map = { [')'] = '(', [']'] = '[', ['>'] = '<', ['}'] = '{' }
  local stack = {}

  -- Find unclosed brackets
  for char in before_cursor:gmatch('.') do
    if bracket_map[char] then
      table.insert(stack, char)
    elseif reverse_map[char] and #stack > 0 and stack[#stack] == reverse_map[char] then
      table.remove(stack)
    end
  end

  if #stack > 1 then
    -- Multiple unclosed brackets - close them all
    local indent = before_cursor:match('^%s*') or ''
    local lines = {}
    table.insert(lines, indent .. string.rep(' ', vim.o.shiftwidth))

    -- Close brackets in reverse order all on one line
    local closing = ''
    for i = #stack, 1, -1 do
      closing = closing .. bracket_map[stack[i]]
    end
    table.insert(lines, indent .. closing)

    -- Insert the lines
    vim.api.nvim_put(lines, 'l', true, true)
    -- Move cursor to the indented line
    vim.api.nvim_win_set_cursor(0, { vim.fn.line('.') - 1, #indent + vim.o.shiftwidth + 1 })
  elseif #stack == 1 and ls.expandable() then
    -- Single bracket with expandable snippet - use snippet
    ls.expand()
  end
end, { silent = true })

local function get_indent()
  return vim.fn.indent(vim.fn.line('.'))
end

local closing_brackets = {
  ['('] = ')',
  ['['] = ']',
  ['<'] = '>',
  ['{'] = '}',
}
local bracket_snippets = {}
for open, close in pairs(closing_brackets) do
  table.insert(
    bracket_snippets,
    s({
      trig = open,
      wordTrig = false,
    }, {
      t { open, '' },
      f(function(_, snip)
        local indent = string.match(snip.env.TM_CURRENT_LINE, '^%s*') or ''
        return indent .. string.rep(' ', vim.o.shiftwidth)
      end),
      i(1),
      t { '', '' },
      f(function(_, snip)
        local indent = string.match(snip.env.TM_CURRENT_LINE, '^%s*') or ''
        return indent
      end),
      t(close),
    })
  )
end

ls.add_snippets('all', bracket_snippets)
