local win = require("user.tool.FloatWin").Create

local function split()
  win({
    width = 0.3,
    height = 0.9,
    buflisted = true,
    pos = { pos = 'cr' }
  })
end

local function Run()
  vim.cmd('w')
  local filename = vim.api.nvim_buf_get_name(0)
  filename = vim.fn.pathshorten(vim.fn.fnamemodify(filename, ':p:~:t'))
  local runfile = filename:match("([^.]+)")

  if (vim.bo.filetype == 'c') then
    split()
    if (vim.fn.filereadable('Makefile') == 1) then
      vim.cmd('term make && ./Main')
    else
      local opt = 'term gcc ' ..
          filename .. ' -o ' .. runfile .. ' && ./' .. runfile .. ' && rm -f ' .. runfile
      vim.cmd(opt)
    end
  elseif (vim.bo.filetype == 'cpp') then
    split()
    if (vim.fn.filereadable('Makefile') == 1) then
      vim.cmd('term make && ./Main')
    else
      local opt = 'term g++ ' ..
          filename .. ' -std=c++17 -O2 -g -Wall -o ' .. runfile .. ' && ./' .. runfile .. ' && rm -rf ' .. runfile
      vim.cmd(opt)
    end
  elseif (vim.bo.filetype == 'python') then
    split()
    vim.cmd('term python3 ' .. filename)
  elseif (vim.bo.filetype == 'lua') then
    split()
    vim.cmd('term lua  ' .. filename)
  elseif (vim.bo.filetype == 'markdown') then
    vim.cmd('MarkdownPreview')
  elseif (vim.bo.filetype == 'sh') then
    split()
    vim.cmd('term bash  ' .. filename)
  elseif (vim.bo.filetype == 'html') then
    vim.cmd("tabe")
    vim.cmd("term live-server --browser=" .. vim.g.browser)
    vim.cmd("tabclose")
    vim.api.nvim_input('<ESC>')
  end
end

vim.keymap.set('n', '<F5>', Run, {})
