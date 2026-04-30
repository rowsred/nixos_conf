-- File name: init.lua
-- Author: rowsred
-- Date created: 2026-04-27 00:55:25
-- Date modified: 2026-04-27 00:55:59
-- ------
vim.env.CC = "clang"
vim.api.nvim_create_user_command("E", function()
	vim.cmd("edit $MYVIMRC")
end, { desc = "Buka konfigurasi Neovim" })
--: OPTIONS
local o = vim.opt
o.clipboard = "unnamedplus"
o.termguicolors = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.ignorecase = true
o.smartcase = true
o.colorcolumn = "80"
o.completeopt = { "menuone", "noselect", "fuzzy", "nosort", "noinsert" }
o.pumheight = 16
--: STATUSLINE
vim.cmd([[
  highlight StatusNormal guibg=#98be65 guifg=#000000 gui=bold
  highlight StatusInsert guibg=#ecbe7b guifg=#000000 gui=bold
  highlight StatusVisual guibg=#ff6c6b guifg=#000000 gui=bold
]])
local function lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return "enable lsp: " .. table.concat(names, ", ")
end
function MyStatus()
	local m = vim.api.nvim_get_mode().mode
	local mode_char = string.upper(m:sub(1, 1))
	local hl_map = {
		n = "%#StatusNormal#",
		i = "%#StatusInsert#",
		v = "%#StatusVisual#",
		V = "%#StatusVisual#",
		[""] = "%#StatusVisual#",
	}
	local hl = hl_map[m] or "%#StatusNormal#"
	return table.concat({
		hl,
		" ",
		mode_char,
		" ",
		"%#StatusLine# | ",
		"%F %m",
		"%=",
		lsp_status(),
		" | %l:%c ",
	})
end
o.statusline = "%!v:lua.MyStatus()"

--: KEYMAP
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
map("i", "jk", "<Esc>", { noremap = true })
map("n", "<leader>w", ":w<CR>", { noremap = true })
map("n", "<leader>e", ":Ex<CR>", { noremap = true })
map("n", "<leader>nh", ":nohl<CR>", { noremap = true })
map("n", "<leader>q", ":q<CR>", { noremap = true })
map("n", "<leader>c", ":bdel<CR>", { noremap = true })
map("n", "<leader>x", ":bp<CR>", { noremap = true })
map("n", "<leader>ff", ":Pick files<CR>", { noremap = true })
--:CUSTOM HEADER
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"nix",
		"python",
		"sh",
		"bash",
		"toml",
		"yaml",
		"dockerfile",
		"php",
		"conf",
	},
	callback = function()
		vim.keymap.set("n", "<leader>hh", function()
			local filename = vim.fn.expand("%:t")
			local date = os.date("%Y-%m-%d")
			local header = {
				"# File: " .. filename,
				"# Author: rowsred",
				"# Date: " .. date,
				"# Descriptions: ", -- Kursor akan mendarat di sini
				"",
			}
			-- Memasukkan baris di paling atas
			vim.api.nvim_buf_set_lines(0, 0, 0, false, header)

			-- Pindahkan kursor ke baris ke-4 (setelah 'Descriptions: ')
			-- Angka 16 adalah posisi kolom setelah spasi terakhir
			vim.api.nvim_win_set_cursor(0, { 4, 16 })
		end, { buffer = true, desc = "Insert Hash Header" })
	end,
}) -- Perhatikan di sini: tadinya Anda punya kelebihan '}'
--: COLORSCHEME
vim.pack.add({
	{ src = "https://github.com/marko-cerovac/material.nvim" },
})
vim.cmd("colorscheme material-darker")

--: FIDGET
vim.pack.add({
	{ src = "https://github.com/j-hui/fidget.nvim" },
})
local status_fidget, fidget = pcall(require, "fidget")
if status_fidget then
	fidget.setup({})
end

--: CODE LINE
vim.pack.add({
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
})
require("ibl").setup()
--: MINI
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
})
require("mini.basics").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.completion").setup({
	lsp_completion = {
		source_func = "completefunc",
		auto_setup = true,
		-- Ini adalah kuncinya:
		snippet_insert = nil,
	},
	delay = {
		completion = 50, -- Dipercepat agar langsung muncul saat mengetik
		info = 100,
		signature = 50,
	},
})
require("mini.snippets").setup()
require("mini.pick").setup()

--: FORMATTER
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		c = { "clang-format" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		jsonc = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

--: LSP CONFIG
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Neovim menggunakan LuaJIT
			},
			diagnostics = {
				globals = { "vim" }, -- Menghilangkan error "undefined global vim"
			},
			workspace = {
				-- Mengambil semua library Neovim & plugin secara otomatis
				library = vim.env.VIMRUNTIME,
				--library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
vim.lsp.config("nngjslint", {
	cmd = { "slint-lsp" },
})
vim.lsp.enable("slint")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "slint",
	callback = function()
		vim.cmd([[lsp enable]])
	end,
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("clangd")

-- Menampilkan error di popup window saat kursor tertahan (hold)
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		local opts = {
			focusable = false,
			close_events = { "CursorMoved", "CursorMovedI", "BufLeave" },
			border = "rounded",
			source = "always",
			prefix = " ",
			scope = "cursor",
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})
-- Mengatur durasi "hold" (defaultnya 4000ms/4 detik, kita percepat jadi 300ms)
vim.o.updatetime = 300
vim.api.nvim_create_autocmd("InsertCharPre", {
	pattern = "*",
	callback = function()
		-- Jika karakter yang baru diketik adalah '/'
		if vim.v.char == "/" then
			-- Gunakan schedule agar karakter '/' terinput dulu, baru pemicu dijalankan
			vim.schedule(function()
				-- Cek apakah kita masih di Insert Mode (menghindari error saat cepat keluar mode)
				if vim.api.nvim_get_mode().mode == "i" then
					-- Simulasi menekan CTRL-X lalu CTRL-F
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-x><C-f>", true, false, true), "n", true)
				end
			end)
		end
	end,
})

vim.pack.add({ { src = "https://github.com/attilarepka/header.nvim" } })
require("header").setup({
	allow_autocmds = true,
	file_name = true,
	author = "rowsred",
	date_created = true,
	date_created_fmt = "%Y-%m-%d %H:%M:%S",
	date_modified = true,
	date_modified_fmt = "%Y-%m-%d %H:%M:%S",
	line_separator = "------",
	use_block_header = false,
	license_from_file = false,
	author_from_git = false,
})
--: RUST
vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
})
-- TREESTITER
vim.pack.add({
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
})
require("tree-sitter-manager").setup({
	-- Default Options
	-- ensure_installed = {}, -- list of parsers to install at the start of a neovim session
	border = rounded, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
	auto_install = true, -- if enabled, install missing parsers when editing a new file
	highlight = true, -- treesitter highlighting is enabled by default
	-- languages = {}, -- override or add new parser sources
	-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
	-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
})
