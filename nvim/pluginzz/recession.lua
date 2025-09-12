if vim.g.did_load_recession_plugin then
  return
end
vim.g.did_load_recession_plugin = true

local resession = require('resession')
resession.setup {}
