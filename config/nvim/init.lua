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
vim.opt.completeopt = { "menuone", "noselect", "fuzzy", "nosort", "noinsert" }
vim.opt.pumheight = 16 -- Maksimal 10 baris yang muncul di menu popup
-- 1. Definisikan Warna (Warna Material Theme)
--
-- 1. Warna Background (Hijau, Kuning, Merah) dengan Teks Hitam
vim.cmd([[
  highlight StatusNormal guibg=#98be65 guifg=#000000 gui=bold
  highlight StatusInsert guibg=#ecbe7b guifg=#000000 gui=bold
  highlight StatusVisual guibg=#ff6c6b guifg=#000000 gui=bold
]])
-- 2. Fungsi LSP (Jangan sampai hilang!)
--
local function lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end

	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end

	-- Menghasilkan output: "enable lsp: nngjslint, rust-analyzer"
	return "enable lsp: " .. table.concat(names, ", ")
end
-- 3. Fungsi Utama Statusline
function MyStatus()
	local m = vim.api.nvim_get_mode().mode
	local mode_char = string.upper(m:sub(1, 1))

	-- Map highlight berdasarkan mode
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
		" ", -- Kotak warna background & teks hitam
		"%#StatusLine# | ", -- Kembali ke warna standar & pemisah
		"%F %m", -- Nama File & [+]
		"%=", -- Dorong ke kanan
		lsp_status(), -- Panggil fungsi LSP di sini
		" | %l:%c ", -- Lokasi Baris:Kolom
	})
end

vim.opt.statusline = "%!v:lua.MyStatus()"
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
map("i", "jk", "<Esc>", { noremap = true })
map("n", "<leader>w", ":w<CR>", { noremap = true })
map("n", "<leader>e", ":Ex<CR>", { noremap = true })
map("n", "<leader>nh", ":nohl<CR>", { noremap = true })
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

-- Keybinding: <leader>nh (Nix Header)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	callback = function()
		vim.keymap.set("n", "<leader>hh", function()
			local filename = vim.fn.expand("%:t")
			local date = os.date("%Y-%m-%d")
			local header = {
				"# File: " .. filename,
				"# Author: rowsred",
				"# Date: " .. date,
				"# Description: ", -- Dikosongkan agar kursor mendarat di sini
				"",
			}

			-- Memasukkan baris di paling atas
			vim.api.nvim_buf_set_lines(0, 0, 0, false, header)

			-- Pindahkan kursor ke baris ke-4, kolom ke-15 (setelah 'Description: ')
			vim.api.nvim_win_set_cursor(0, { 4, 15 })
		end, { buffer = true, desc = "Insert Nix file header" })
	end,
})
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
