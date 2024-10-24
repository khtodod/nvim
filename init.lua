-- Ensure Neovim is running
if not vim.fn.has("nvim") then
	error("This configuration is for Neovim only")
end

-- Set <leader> key and general options
local vim = vim
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
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.mouse = "a"
vim.keymap.set("i", "jj", "<Esc>")

vim.cmd([[set isfname+=@-@]])
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
Plug("behemothbucket/gruber-darker-theme.nvim")

vim.call("plug#end")

-- Colorscheme & Transparency
vim.o.background = "dark"
require("gruber-darker").setup()
vim.cmd("colorscheme gruber-darker")

require("transparent").setup()
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("TransparentEnable")
	end,
})

-- Mason & LSP Configuration
local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup({
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
require("mason-lspconfig").setup_handlers({
	function(server)
		lspconfig[server].setup({})
	end,
})

-- Treesitter Configuration
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
	highlight = { enable = true, additional_vim_regex_highlighting = false },
})

-- Conform (Formatting)
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
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
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

-- Neoscroll Setup
require("neoscroll").setup({ easing_function = "quadratic" })

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
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
	},
	watch_gitdir = { follow_files = true },
})

-- Comment Plugin
require("Comment").setup()

-- Mini Statusline
require("mini.statusline").setup({ use_icons = false })

-- Telescope Configuration
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify("Telescope not found!", vim.log.levels.ERROR)
	return
end

local builtin_status_ok, builtin = pcall(require, "telescope.builtin")
if not builtin_status_ok then
	vim.notify("Telescope built-in functions not available", vim.log.levels.ERROR)
	return
end

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git",
			"vendor",
			".cache",
			"dist",
			".nuxt",
			".next",
			"package%-lock%.json",
			"yarn%.lock",
		},
	},
	pickers = {
		find_files = { hidden = true },
		live_grep = {
			additional_args = function()
				return { "--hidden" }
			end,
		},
	},
})

-- Keymaps for Telescope
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope recent files" })

-- Autoclose Setup
require("autoclose").setup()

-- Split Navigation and Resize
vim.keymap.set("n", "<Leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<Leader>sh", ":split<CR>")
vim.keymap.set("n", "<Leader>h", "<C-w>h")
vim.keymap.set("n", "<Leader>j", "<C-w>j")
vim.keymap.set("n", "<Leader>k", "<C-w>k")
vim.keymap.set("n", "<Leader>l", "<C-w>l")
vim.keymap.set("n", "<Leader><Left>", "<C-w><")
vim.keymap.set("n", "<Leader><Right>", "<C-w>>")
vim.keymap.set("n", "<Leader><Up>", "<C-w>+")
vim.keymap.set("n", "<Leader><Down>", "<C-w>-")
