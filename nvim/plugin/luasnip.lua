if vim.g.did_load_luasnip_plugin then
  return
end
vim.g.did_load_luasnip_plugin = true

local ls = require('luasnip')
local i = ls.insert_node
local t = ls.text_node
local s = ls.snippet
vim.keymap.set({ 'i' }, '<C-L>', function()
  ls.expand()
end, { silent = true })
ls.add_snippets('all', {
  s('ternary', {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, 'cond'),
    t(' ? '),
    i(2, 'then'),
    t(' : '),
    i(3, 'else'),
  }),
})
