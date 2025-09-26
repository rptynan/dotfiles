return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
		"nvimtools/none-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {},
	config = function()
		-- require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_enable = true,
			ensure_installed = { "ts_ls", "lua_ls", "gopls" },
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"gofumpt",
				"stylua",
				"prettier",
				"black",
			},
		})

		local lspconfig = require("lspconfig")

		local null_ls = require("null-ls")
		vim.lsp.config("null-ls", {})
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.clang_format.with({
					filetypes = { "proto" },
				}),
			},
			-- auto-format on save
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		vim.lsp.config("ts_ls", {
			settings = {
				typescript = {
					tsserver_max_memory = "4096",
					-- inlay hints here might be good
				},
			},
		})

		vim.lsp.config("lua_ls", {})

		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
						autoImportCompletion = true,
					},
				},
			},
		})

		vim.lsp.config("gopls", {
			-- Run gopls with Go modules disabled.
			cmd = { "env", "GO111MODULE=off", "gopls", "-remote=auto" },

			settings = {
				gopls = {
					analyses = {
						-- These are the only analyzers that are disabled by default in gopls.
						nilness = true,
						shadow = true,
						unusedparams = true,
						unusedwrite = true,
					},
					buildFlags = { "-tags=integration" }, -- for LSP support in integration tests
					staticcheck = true,
					expandWorkspaceToModule = false,
					-- Organize imports. Groups imports by Monzo versus not-Monzo.
					-- Equivalent to local flag with goimports
					["local"] = "github.com/monzo/wearedev",
				},
			},

			-- Special root dir finding function for wearedev
			root_dir = function(bufnr, cb)
				local buffer_filepath = vim.api.nvim_buf_get_name(bufnr)
				local root_markers = { "main.go", "README.md", "go.mod", "LICENSE" } -- Add more as needed
				local root_directory = lspconfig.util.root_pattern(root_markers)(buffer_filepath)
				cb(root_directory)
			end,
			-- Doubly make sure we don't use root of repo as root dir
			ignoredRootPaths = { "$HOME/src/github.com/monzo/wearedev/" },

			-- Collect less information about packages without open files.
			memoryMode = "DegradeClosed",

			flags = {
				-- gopls is a particularly slow language server, especially in wearedev.
				-- Debounce text changes so that we don't send loads of updates.
				-- Note: This was messing with autocomplete (which does debouncing already I believe), so
				-- disabled it.
				-- debounce_text_changes = 500,
			},

			init_options = {
				codelenses = {
					generate = true,
					gc_details = true,
					test = true,
					tidy = true,
				},
			},
		})

		-- Have not got this to work yet
		-- vim.lsp.config("protols", {
		-- 	cmd = { "protols" },
		-- 	filetypes = { "proto" },
		-- 	root_markers = { ".git" },
		-- }) -- protobuf

		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- gi for goto implemenation
		vim.keymap.set("n", "gI", vim.lsp.buf.type_definition, bufopts) -- gt for goto type
		vim.keymap.set("n", "<leader>o", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>u", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, bufopts) -- search references
		vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, bufopts) -- see all diags
		vim.keymap.set("n", "D", vim.diagnostic.open_float, bufopts) -- hover current diag
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- hover general
		vim.keymap.set("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", bufopts)
		vim.keymap.set("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>", bufopts)

		-- This triggers the lsp setup on startup. Without this I need to do :e on a file to start the
		-- relevant lsp.
		vim.api.nvim_exec_autocmds("FileType", {})
	end,
}
