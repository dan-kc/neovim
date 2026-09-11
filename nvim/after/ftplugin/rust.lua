local bufname = vim.api.nvim_buf_get_name(0)
local search_path = bufname ~= '' and vim.fs.dirname(bufname) or vim.uv.cwd()
local rustfmt_config = vim.fs.find({ 'rustfmt.toml', '.rustfmt.toml' }, {
  upward = true,
  path = search_path,
})[1]

local textwidth = 100

if rustfmt_config then
  for _, line in ipairs(vim.fn.readfile(rustfmt_config)) do
    local max_width = line:match('^%s*max_width%s*=%s*(%d+)')
    if max_width then
      textwidth = tonumber(max_width)
      break
    end
  end
end

vim.opt_local.textwidth = textwidth
