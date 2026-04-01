vim.o.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.tabstop = 4 -- Lebar visual dari sebuah karakter tab
vim.opt.softtabstop = 4 -- Jumlah spasi yang dimasukkan saat menekan <Tab>
vim.opt.shiftwidth = 4 -- Jumlah spasi untuk indentasi otomatis (>> atau <<)
vim.opt.expandtab = true -- Mengubah karakter tab menjadi spasi
vim.opt.ignorecase = true
-- Jika kamu mengetik huruf besar secara sengaja, baru dia jadi case sensitive
vim.opt.smartcase = true
-- Mengatur perilaku menu popup (pum)
---- Konfigurasi popup menu yang lebih cerdas dan tidak mengganggu
vim.opt.completeopt = { "menuone", "noselect", "fuzzy", "nosort" }
vim.opt.pumheight = 16 -- Maksimal 10 baris yang muncul di menu popup

vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
map("i", "jk", "<Esc>", { noremap = true })
map("n", "<leader>w", ":w<CR>", { noremap = true })
map("n", "<leader>q", ":q<CR>", { noremap = true })
map("n", "<leader>x", ":bdel<CR>", { noremap = true })
map("n", "<leader>ff", ":Pick files<CR>", { noremap = true })

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
	{ src = "https://github.com/marko-cerovac/material.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.cmd("colorscheme material-darker")

local status_fidget, fidget = pcall(require, "fidget")
if status_fidget then
	fidget.setup({})
end
require("ibl").setup()
require("mini.basics").setup()
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

vim.api.nvim_create_autocmd("BufWrite", {
	callback = function()
		-- Mencoba menjalankan treesitter, jika gagal/tidak support dilewati saja
		pcall(vim.treesitter.start)
	end,
})
--auto install tree siter
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		local ftype = vim.bo.filetype
		if ftype == "" or vim.bo.buftype ~= "" then
			return
		end

		-- 1. Gunakan mapping internal Neovim (dosini otomatis jadi ini)
		local lang = vim.treesitter.language.get_lang(ftype) or ftype

		-- 2. Cek fisik: Apakah parser sudah ada di disk?
		-- Jika sudah ada, jangan panggil install agar tidak muncul error override
		local parser_exists = #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) > 0

		if not parser_exists then
			-- 3. Jalankan asinkron agar tidak mengunci buffer saat :w
			vim.schedule(function()
				pcall(function()
					-- Gunakan 'silent!' agar tidak ada popup yang mengganggu
					vim.cmd("silent! TSInstall " .. lang)
				end)
			end)
		end
	end,
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
