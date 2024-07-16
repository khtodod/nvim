local nmappings  = {
  { mode = { 'n' },      lhs = 'W',                rhs = '<cmd>w<CR>',                                                                 opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'Q',                rhs = '<cmd>q<CR>',                                                                 opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'B',                rhs = '<cmd>bd<CR>',                                                                opts = { noremap = true } },
  { mode = { 'v' },      lhs = 'N',                rhs = ':normal ',                                                                   opts = { noremap = true } },
  { mode = { 'v' },      lhs = 'Y',                rhs = '"+y',                                                                        opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'ca',               rhs = '<cmd>silent %y+<CR>',                                                        opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>sc',       rhs = '<cmd>set spell!<CR>',                                                        opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>sw',       rhs = '<cmd>set wrap!<CR>',                                                         opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader><cr>',     rhs = '<cmd>noh<CR>',                                                               opts = { noremap = true } },
  { mode = { 't' },      lhs = '<C-N>',            rhs = '<C-\\><C-N>',                                                                opts = { noremap = true } },
  { mode = { 't' },      lhs = '<C-O>',            rhs = '<C-\\><C-N><C-O>',                                                           opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader><leader>', rhs = '/<++><CR>:noh<CR>"_c4l',                                                     opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'j',                rhs = 'gj',                                                                         opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'k',                rhs = 'gk',                                                                         opts = { noremap = true } },
  { mode = { 'n', 'v' }, lhs = 'H',                rhs = '^',                                                                          opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'J',                rhs = '<c-d>',                                                                      opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'K',                rhs = '<c-u>',                                                                      opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'L',                rhs = '$',                                                                          opts = { noremap = true } },
  { mode = { 'v' },      lhs = 'L',                rhs = '$h',                                                                         opts = { noremap = true } },
  { mode = { 'i' },      lhs = '<C-l>',            rhs = '<Right>',                                                                    opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>sh',       rhs = '<cmd>set nosplitright<CR>:vsplit<CR>',                                       opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>sj',       rhs = '<cmd>set splitbelow<CR>:split<CR>',                                          opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>sk',       rhs = '<cmd>set nosplitbelow<CR>:split<CR>',                                        opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>sl',       rhs = '<cmd>set splitright<CR>:vsplit<CR>',                                         opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>smv',      rhs = '<C-w>t<c-W>H',                                                               opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>smh',      rhs = '<C-w>t<c-W>K',                                                               opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>W',        rhs = '<c-w>w',                                                                     opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>vim',      rhs = '<cmd>edit ~/.config/nvim/init.lua<CR>',                                      opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'tn',               rhs = '<cmd>tabnext<CR>',                                                           opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'tp',               rhs = '<cmd>tabprevious<CR>',                                                       opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'tu',               rhs = '<cmd>tabnew<CR>',                                                            opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'tt',               rhs = '<cmd>silent 20 Lex<CR>',                                                     opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>cc',       rhs = 'gcc',                                                                        opts = { remap = true } },
  { mode = { 'v' },      lhs = '<leader>cc',       rhs = 'gc',                                                                         opts = { remap = true } },
  { mode = { 'n' },      lhs = ';rr',              rhs = '<cmd>CompetiTest run<CR>',                                                   opts = { noremap = true } },
  { mode = { 'n' },      lhs = ';ra',              rhs = '<cmd>CompetiTest add_testcase<CR>',                                          opts = { noremap = true } },
  { mode = { 'n' },      lhs = ';re',              rhs = '<cmd>CompetiTest edit_testcase<CR>',                                         opts = { noremap = true } },
  { mode = { 'n' },      lhs = ';ri',              rhs = '<cmd>CompetiTest receive testcases<CR>',                                     opts = { noremap = true } },
  { mode = { 'n' },      lhs = ';rd',              rhs = '<cmd>CompetiTest delete_testcase<CR>',                                       opts = { noremap = true } },
  { mode = { 'n' },      lhs = ';rm',              rhs = '<cmd>silent ! rm -f "./%<" && rm -f "./%<"_(in|out)put*.txt<CR>',            opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>ff',       rhs = '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>',    opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>fw',       rhs = '<cmd>Telescope live_grep<CR>',                                               opts = { noremap = true } },
  { mode = { 'n', 'v' }, lhs = ';f',               rhs = '<cmd>GuardFmt<CR>',                                                          opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>b',        rhs = '<cmd>FlyBuf<CR>',                                                            opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>pd',       rhs = '<cmd>Lspsaga peek_definition<CR>',                                           opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>pr',       rhs = '<cmd>Telescope lsp_references<CR>',                                          opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>K',        rhs = '<cmd>Lspsaga hover_doc<CR>',                                                 opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>wa',       rhs = vim.lsp.buf.add_workspace_folder,                                             opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>wr',       rhs = vim.lsp.buf.remove_workspace_folder,                                          opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>wl',       rhs = function() vim.notify(vim.inspect(vim.lsp.buf
                                                          .list_workspace_folders())) end,                                             opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>rn',       rhs = '<cmd>Lspsaga rename ++project<cr>',                                          opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>ca',       rhs = '<cmd>Lspsaga code_action<CR>',                                               opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>ot',       rhs = '<cmd>Lspsaga outline<CR>',                                                   opts = { noremap = true } },
  { mode = { 'n' },      lhs = '<leader>tt',       rhs = '<cmd>Lspsaga term_toggle<CR>',                                               opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'd[',               rhs = vim.diagnostic.goto_prev,                                                     opts = { noremap = true } },
  { mode = { 'n' },      lhs = 'd]',               rhs = vim.diagnostic.goto_next,                                                     opts = { noremap = true } },
}

local MdSnippets = {
  { lhs = '《',               rhs = '《》<Esc>i' },
  { lhs = '》',               rhs = '> ' },
  { lhs = '（',               rhs = '（）<Esc>i' },
  { lhs = '“',                rhs = '“”<Esc>i' },
  { lhs = '”',                rhs = '“”<Esc>i' },
  { lhs = '<leader><leader>', rhs = '<Esc>/<++><CR>:nohlsearch<CR>"_c4l' },
  { lhs = '·b',               rhs = '****<++><Esc>F*hi' },
  { lhs = '·s',               rhs = '~~~~<++><Esc>F~hi' },
  { lhs = '·h',               rhs = '====<++><Esc>F=hi' },
  { lhs = '·i',               rhs = '**<++><Esc>F*i' },
  { lhs = '·d',               rhs = '``<++><Esc>F`i' },
  { lhs = '·c',               rhs = '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA' },
  { lhs = '·m',               rhs = '- [ ] ' },
  { lhs = '·p',               rhs = '![](<++>)<++><Esc>F[a' },
  { lhs = '·a',               rhs = '[](<++>)<++><Esc>F[a' },
  { lhs = '·l',               rhs = '--- ' },
  { lhs = '·t',               rhs = '[toc]' },
  { lhs = '·1',               rhs = '#<Space><Enter><++><Esc>kA' },
  { lhs = '·2',               rhs = '##<Space><Enter><++><Esc>kA' },
  { lhs = '·3',               rhs = '###<Space><Enter><++><Esc>kA' },
  { lhs = '·4',               rhs = '####<Space><Enter><++><Esc>kA' },
  { lhs = '·5',               rhs = '#####<Space><Enter><++><Esc>kA' },
  { lhs = ',b',               rhs = '****<++><Esc>F*hi' },
  { lhs = ',s',               rhs = '~~~~<++><Esc>F~hi' },
  { lhs = ',h',               rhs = '====<++><Esc>F=hi' },
  { lhs = ',i',               rhs = '**<++><Esc>F*i' },
  { lhs = ',d',               rhs = '``<++><Esc>F`i' },
  { lhs = ',c',               rhs = '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA' },
  { lhs = ',m',               rhs = '- [ ] ' },
  { lhs = ',p',               rhs = '![](<++>)<++><Esc>F[a' },
  { lhs = ',a',               rhs = '[](<++>)<++><Esc>F[a' },
  { lhs = ',l',               rhs = '--- ' },
  { lhs = ',t',               rhs = '[toc]' },
  { lhs = ',1',               rhs = '#<Space><Enter><++><Esc>kA' },
  { lhs = ',2',               rhs = '##<Space><Enter><++><Esc>kA' },
  { lhs = ',3',               rhs = '###<Space><Enter><++><Esc>kA' },
  { lhs = ',4',               rhs = '####<Space><Enter><++><Esc>kA' },
  { lhs = ',5',               rhs = '#####<Space><Enter><++><Esc>kA' },
}


for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode, mapping.lhs, mapping.rhs, mapping.opts)
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.md',
  callback = function()
    for _, mapping in ipairs(MdSnippets) do
      vim.keymap.set('i', mapping.lhs, mapping.rhs, { noremap = true, buffer = true })
    end
  end
})
