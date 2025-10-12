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
  ls.expand()
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
