local M = {}

local closing_for = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
  ['<'] = '>',
  ['|'] = '|',
  ["'"] = "'",
  ['"'] = '"',
  ['`'] = '`',
}

local opening_for = {
  [')'] = '(',
  [']'] = '[',
  ['}'] = '{',
  ['>'] = '<',
}

local quotes = {
  ["'"] = true,
  ['"'] = true,
  ['`'] = true,
}

local function is_escaped(text, index)
  local backslashes = 0
  index = index - 1

  while index > 0 and text:sub(index, index) == '\\' do
    backslashes = backslashes + 1
    index = index - 1
  end

  return backslashes % 2 == 1
end

function M.missing_closers(text)
  local stack = {}
  local quote

  for index = 1, #text do
    local char = text:sub(index, index)

    if quote then
      if char == quote and not is_escaped(text, index) then
        table.remove(stack)
        quote = nil
      end
    elseif not is_escaped(text, index) then
      if quotes[char] then
        stack[#stack + 1] = char
        quote = char
      elseif char == '|' then
        if stack[#stack] == char then
          table.remove(stack)
        else
          stack[#stack + 1] = char
        end
      elseif closing_for[char] then
        stack[#stack + 1] = char
      elseif opening_for[char] == stack[#stack] then
        table.remove(stack)
      end
    end
  end

  local closers = {}
  for index = #stack, 1, -1 do
    closers[#closers + 1] = closing_for[stack[index]]
  end

  return table.concat(closers)
end

local function indent_at(width)
  if vim.bo.expandtab then
    return string.rep(' ', width)
  end

  local tabstop = vim.bo.tabstop
  return string.rep('\t', math.floor(width / tabstop)) .. string.rep(' ', width % tabstop)
end

function M.expand()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, column = cursor[1], cursor[2]
  local line = vim.api.nvim_get_current_line()
  local before_cursor = line:sub(1, column)
  local after_cursor = line:sub(column + 1)
  local closers = M.missing_closers(before_cursor)

  if closers == '' then
    return
  end

  local existing_closers = 0
  while existing_closers < #closers do
    local index = existing_closers + 1
    if after_cursor:sub(index, index) ~= closers:sub(index, index) then
      break
    end
    existing_closers = index
  end

  local base_indent = vim.fn.indent(row)
  local inner_indent = indent_at(base_indent + vim.fn.shiftwidth())
  local closing_indent = indent_at(base_indent)
  local remainder = after_cursor:sub(existing_closers + 1)
  local inner_line = inner_indent
  local closing_line = closing_indent .. closers

  if existing_closers == 0 then
    inner_line = inner_line .. remainder
  else
    closing_line = closing_line .. remainder
  end

  vim.api.nvim_buf_set_lines(0, row - 1, row, false, {
    before_cursor,
    inner_line,
    closing_line,
  })
  vim.api.nvim_win_set_cursor(0, { row + 1, #inner_indent })
end

return M
