--:: options
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.undofile = true
opt.swapfile = false

--::keymaps
vim.g.mapleader = " "
local keymap = vim.keymap.set
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>e", ":Ex<CR>", { desc = "Explorer" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>x", ":bdelete<CR>", { desc = "Quit" })
keymap("i", "jk", "<Esc>", { desc = "Quit" })
keymap("n", "<Tab>", ":bnext<CR>")
keymap("n", "<S-Tab>", ":bprevious<CR>")
keymap("v", "<leader>c", "gc", { remap = true })
keymap("n", "<leader>h", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")

--:: auto command
--::disable auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
--:: hightlight cursor
vim.api.nvim_set_hl(0, "SearchMatch", { bg = "#3e4452", fg = "NONE", underline = true })
local highlight_group = vim.api.nvim_create_augroup("BufferHighlight", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = highlight_group,
	callback = function()
		if vim.w.current_match_id then
			pcall(vim.fn.matchdelete, vim.w.current_match_id)
			vim.w.current_match_id = nil
		end
		local word = vim.fn.expand("<cword>")
		if word ~= "" and word:match("^[a-zA-Z0-9_]+$") then
			-- Gunakan pola regex agar hanya kata yang pas yang kena highlight
			local pattern = [[\<]] .. word .. [[\>]]
			-- Terapkan highlight ke seluruh buffer
			vim.w.current_match_id = vim.fn.matchadd("SearchMatch", pattern, -1)
		end
	end,
})
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	group = highlight_group,
	callback = function()
		if vim.w.current_match_id then
			pcall(vim.fn.matchdelete, vim.w.current_match_id)
			vim.w.current_match_id = nil
		end
	end,
})

--=============Custom==============
-- color scheme
vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
})
vim.cmd("colorscheme rose-pine")

-- formater,completion,snippet
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.5.0" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
})
require("blink.cmp").setup({
	keymap = { preset = "default" },
	completion = {
		menu = {
			draw = {
				-- Kita tambahkan 'source_name' di kolom paling kanan
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "source_name", gap = 1 },
				},
			},
		},
	},
	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "snippets", "buffer", "path", "lsp" },
		providers = {
			buffer = {
				score_offset = 100, -- Naikkan angka ini agar buffer lebih diprioritaskan
				min_keyword_length = 2, -- Mulai muncul setelah ketik 2 karakter
			},
		},
	},
})
require("mason").setup()

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
--:lsp
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
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
vim.lsp.config("nixd", {
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "nixfmt" },
			},
			options = {
				nixos = {
					expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.nixos.options",
				},
				home_manager = {
					expr = '(builtins.getFlake (toString ./.)).homeConfigurations."row@nixos".options',
				},
			},
		},
	},
})
vim.lsp.config("slint", {
	cmd = "slint-lsp",
})

vim.lsp.enable("lua_ls")
--vim.lsp.enable("rust_analyzer")
vim.lsp.enable("bashls")
vim.lsp.enable("nixd")
vim.lsp.enable("slint")

--: diagnostic custom
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
vim.diagnostic.config({
	virtual_text = false, -- Matikan teks di samping agar tidak berantakan
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.HINT] = signs.Hint,
			[vim.diagnostic.severity.INFO] = signs.Info,
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focused = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
			border = "rounded", -- Kotak rounded agar estetik
			source = "always", -- Menampilkan sumber error (misal: rust-analyzer)
			prefix = " ",
		})
	end,
})
vim.opt.updatetime = 300

--: telescope
vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

--: treesitter
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
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
vim.pack.add({
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
})
require("ibl").setup()

vim.pack.add({
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
})
require("fidget").setup({})
require("nvim-autopairs").setup({})
