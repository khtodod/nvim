-- Ensure Neovim is running
if not vim.fn.has("nvim") then
	error("This configuration is for Neovim only")
end

-- Set <leader> key and general options
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.wrap = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 10
opt.signcolumn = "yes"
opt.updatetime = 50
opt.colorcolumn = "80"
opt.mouse = "a"
opt.showmode = false -- Disable default mode text since we're using a statusline

vim.cmd([[set isfname+=@-@]]) -- Allow @ character in filenames

-- Unbind arrow keys in all modes
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
	vim.keymap.set("", key, "<NOP>", { noremap = true, silent = true })
end

-- Plugin Manager (vim-plug) setup
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- Plugins
Plug("karb94/neoscroll.nvim")
Plug("neoclide/coc.nvim", { branch = "release" })
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.x" })
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("neovim/nvim-lspconfig")
Plug("m4xshen/autoclose.nvim")
Plug("akinsho/toggleterm.nvim", { tag = "*" })
Plug("stevearc/conform.nvim")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("numToStr/Comment.nvim")
Plug("lewis6991/gitsigns.nvim")
Plug("echasnovski/mini.nvim")
Plug("Iron-E/nvim-highlite")
Plug("xiyaowong/transparent.nvim")
Plug("HoNamDuong/hybrid.nvim")
Plug("nvim-tree/nvim-tree.lua")

vim.call("plug#end")

-- Colorscheme & Transparency
vim.o.background = "dark"
vim.cmd("colorscheme hybrid")
require("transparent").setup({ enable = true })

-- Keymaps Configuration
local function set_keymaps()
	local keymap = vim.keymap.set
	-- General Keymaps
	keymap("i", "jj", "<Esc>")
	keymap("n", "<leader>sv", ":vsplit<CR>")
	keymap("n", "<leader>sh", ":split<CR>")
	keymap("n", "<leader>h", "<C-w>h")
	keymap("n", "<leader>j", "<C-w>j")
	keymap("n", "<leader>k", "<C-w>k")
	keymap("n", "<leader>l", "<C-w>l")
	keymap("n", "<leader><Left>", "<C-w><")
	keymap("n", "<leader><Right>", "<C-w>>")
	keymap("n", "<leader><Up>", "<C-w>+")
	keymap("n", "<leader><Down>", "<C-w>-")
	keymap("n", "<C-h>", "^", { noremap = true, silent = true })
	keymap("n", "<C-l>", "g_", { noremap = true, silent = true })
	keymap("v", "<C-h>", "^", { noremap = true, silent = true })
	keymap("v", "<C-l>", "g_", { noremap = true, silent = true })

	-- Telescope Keymaps
	local builtin = require("telescope.builtin")
	keymap("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
	keymap("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
	keymap("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
	keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope recent files" })

	-- ToggleTerm Keymap
	keymap("n", "<C-\\>", ":ToggleTerm<CR>", { noremap = true, silent = true })
	keymap("t", "<C-\\>", [[<C-\><C-n>:ToggleTerm<CR>]], { noremap = true, silent = true })

	-- Toggle NvimTree
	keymap("n", "<Leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
end
set_keymaps()

-- Mason & LSP Configuration
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

require("mason").setup()
mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"intelephense",
		"css_variables",
		"sqlls",
		"eslint",
		"volar",
		"lemminx",
		"gopls",
		"tailwindcss",
		"html",
		"jsonls",
	},
})
mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,
})

-- Treesitter Configuration
vim.defer_fn(function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"lua",
			"vim",
			"markdown",
			"vue",
			"php",
			"go",
			"rust",
			"javascript",
			"c",
			"query",
			"markdown_inline",
		},
		highlight = { enable = true, additional_vim_regex_highlighting = false },
	})
end, 0)

-- Conform (Auto-formatting)
require("conform").setup({
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		javascript = { "prettierd" },
		go = { "gofmt" },
		php = { "phpcbf" },
		json = { "fixjson" },
	},
})
vim.api.nvim_create_user_command("FormatDisable", function(args)
	vim.b.disable_autoformat = args.bang or false
	vim.g.disable_autoformat = not args.bang
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat, vim.g.disable_autoformat = false, false
end, { desc = "Enable autoformat-on-save" })

-- Gitsigns Setup
require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	current_line_blame = true,
	current_line_blame_opts = { virt_text = true, virt_text_pos = "eol", delay = 1000 },
	watch_gitdir = { follow_files = true },
})

-- Comment Plugin Setup
require("Comment").setup()

-- Mini Statusline Setup
require("mini.statusline").setup({ use_icons = false })

-- Neoscroll Setup
vim.defer_fn(function()
	require("neoscroll").setup({ easing_function = "quadratic" })
end, 0)

-- Autoclose Setup
vim.defer_fn(function()
	require("autoclose").setup()
end, 0)

-- ToggleTerm Setup
require("toggleterm").setup({})

-- NvimTree
require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		icons = {
			show = {
				file = false,
				folder = false,
				git = false,
			},
		},
	},
	filters = {
		dotfiles = true,
	},
})
