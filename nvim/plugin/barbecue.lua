if vim.g.did_load_barbecue_plugin then
  return
end
vim.g.did_load_barbecue_plugin = true

require('barbecue').setup {}
