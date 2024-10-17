if not vim.fn.has("nvim") then
    error("This configuration is for Neovim only")
end

local vim = vim
local Plug = vim.fn["plug#"]

-- General Neovim Settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
-- vim.opt.winbar = "%=%m %f"

-- Unbind arrow keys in normal, insert, and visual modes
vim.keymap.set("", "<Up>", "<NOP>", { noremap = true, silent = true })
vim.keymap.set("", "<Down>", "<NOP>", { noremap = true, silent = true })
vim.keymap.set("", "<Left>", "<NOP>", { noremap = true, silent = true })
vim.keymap.set("", "<Right>", "<NOP>", { noremap = true, silent = true })

-- Enable mouse support in all modes
vim.opt.mouse = "a"

vim.call("plug#begin")

Plug("karb94/neoscroll.nvim")
Plug("https://github.com/junegunn/vim-easy-align.git")
Plug("fatih/vim-go", { ["tag"] = "*" })
Plug("neoclide/coc.nvim", { ["branch"] = "release" })
Plug("nsf/gocode", { ["rtp"] = "vim" })
Plug("tpope/vim-fireplace", { ["for"] = "clojure" })
Plug("gantoreno/nvim-gabriel")
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")
Plug("m4xshen/autoclose.nvim")
Plug("akinsho/toggleterm.nvim", { ["tag"] = "*" })
Plug("stevearc/conform.nvim")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-lualine/lualine.nvim")
Plug("numToStr/Comment.nvim")
Plug("lewis6991/gitsigns.nvim")

vim.call("plug#end")

-- colorscheme
vim.o.background = "dark"
vim.cmd.colorscheme("gabriel")

-- Lualine setup
require("lualine").setup({
    options = {
        icons_enabled = false,
    },
})

-- Mason
local lspconfig = require("lspconfig")

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer", "intelephense" },
})

require("mason-lspconfig").setup_handlers({
    function(server)
        lspconfig[server].setup({})
    end,
})

-- Comment
require('Comment').setup()

-- Git
require('gitsigns').setup {
    signs                        = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged                 = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signs_staged_enable          = true,
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
}

-- Neoscroll setup
require("neoscroll").setup({ easing_function = "quadratic" })

-- Telescope setup
local telescope = require('telescope')
local builtin = require("telescope.builtin")

telescope.setup({
    defaults = {
        -- Ignore patterns for files and directories
        file_ignore_patterns = {
            "node_modules",        -- Ignore NPM dependencies
            ".git",                -- Ignore Git folders
            "vendor",              -- Laravel vendor folder
            ".cache",              -- Nuxt/Next.js cache
            "dist",                -- Build artifacts
            ".nuxt",               -- Nuxt.js build files
            ".next",               -- Next.js build files
            "package%-lock%.json", -- Ignore package-lock.json
            "yarn%.lock",          -- Ignore yarn.lock
            "storage"
        },
    },
    pickers = {
        find_files = {
            hidden = true, -- Show hidden files (if needed)
        },
        live_grep = {
            additional_args = function()
                return { "--hidden" } -- Include hidden files in search
            end,
        },
    },
})

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Autoclose setup
require("autoclose").setup()

-- Terminal setup
require("toggleterm").setup({
    size = 20,                -- Size of the terminal
    open_mapping = [[<c-\>]], -- Default keymap to open/close the terminal
    hide_numbers = true,      -- Hide line numbers in the terminal buffer
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,     -- Darken the terminal background
    start_in_insert = true, -- Start in insert mode
    persist_size = true,    -- Persist the terminal size
    direction = "float",    -- Options: 'vertical', 'horizontal', 'tab', 'float'
    close_on_exit = true,   -- Close the terminal when the process exits
    shell = vim.o.shell,    -- Use the default shell
    float_opts = {
        border = "curved",  -- Border style: 'single', 'double', 'shadow', 'curved'
    },
})

-- Toggle a terminal with Ctrl-\
vim.keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { noremap = true, silent = true })

-- Open a terminal in a floating window with <Leader>tf
vim.keymap.set("n", "<Leader>t", function()
    require("toggleterm").toggle(1) -- First terminal instance
end, { noremap = true, silent = true })

-- Open a vertical split terminal with <Leader>tv
vim.keymap.set("n", "<Leader>tv", ":ToggleTerm direction=vertical<CR>", { noremap = true, silent = true })

-- Open a horizontal split terminal with <Leader>th
vim.keymap.set("n", "<Leader>th", ":ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })

-- Lazily close all terminals with <Leader>tx
vim.keymap.set("n", "<Leader>tx", ":ToggleTermToggleAll<CR>", { noremap = true, silent = true })

-- Use <Esc> to switch from terminal mode to normal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>y", ":%y +<CR>", { noremap = true, silent = true })

-- Split keymaps
-- Vertical split with <Leader>sv
vim.keymap.set("n", "<Leader>sv", ":vsplit<CR>", { noremap = true, silent = true })

-- Horizontal split with <Leader>sh
vim.keymap.set("n", "<Leader>sh", ":split<CR>", { noremap = true, silent = true })

-- Quickly navigate between splits using <Leader>h, <Leader>j, <Leader>k, <Leader>l
vim.keymap.set("n", "<Leader>h", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>j", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>k", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>l", "<C-w>l", { noremap = true, silent = true })

-- Resize splits more easily with arrow keys
vim.keymap.set("n", "<Leader><Left>", "<C-w><", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader><Right>", "<C-w>>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader><Up>", "<C-w>+", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader><Down>", "<C-w>-", { noremap = true, silent = true })

-- Exit & save
vim.keymap.set("n", "<Leader>q", ":q<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>qa", ":qa!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>wq", ":wq<CR>", { noremap = true, silent = true })

-- Move to the end of the line with Shift + L
vim.keymap.set("n", "L", "$", { noremap = true, silent = true })

-- Move to the beginning of the line with Shift + H
vim.keymap.set("n", "H", "^", { noremap = true, silent = true })

-- Conform setup
require("conform").setup({
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        go = { "gofmt" },
        php = { "phpcbf" },
    },
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = "Re-enable autoformat-on-save",
})

-- Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "vue",
        "php",
        "go",
        "rust",
        "javascript",
    },
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
