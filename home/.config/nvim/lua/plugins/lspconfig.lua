return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {},
	config = function()
		-- Create augroup for auto-formatting (used by both null-ls and ruff)
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- Reusable auto-format function
		local function setup_auto_format(client, bufnr, with_organize_imports)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- Optionally organize imports first (for ruff)
						if with_organize_imports and client.supports_method("textDocument/codeAction") then
							vim.lsp.buf.code_action({
								context = { only = { "source.organizeImports" } },
								apply = true,
							})
						end
						vim.lsp.buf.format({ async = false })
					end,
				})
			end
		end

		require("mason-lspconfig").setup({
			automatic_enable = true,
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"gopls",
				"ruff",
				"pyright",
				"yamlls",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"gofumpt",
				"stylua",
				"prettier",
			},
		})

		local lspconfig = require("lspconfig")

		local null_ls = require("null-ls")
		vim.lsp.config("null-ls", {})
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- Disabled this because it's formatting yaml (in a way I don't like)
				-- null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.clang_format.with({
					filetypes = { "proto" },
				}),
			},
			-- Use the reusable function
			on_attach = function(client, bufnr)
				setup_auto_format(client, bufnr, false) -- No import organizing for null-ls
			end,
		})

		-- Typescript
		vim.lsp.config("ts_ls", {
			settings = {
				typescript = {
					tsserver_max_memory = "4096",
					-- inlay hints here might be good
				},
			},
		})

		-- Lua
		vim.lsp.config("lua_ls", {})

		-- Python
		vim.lsp.config("ruff", {
			settings = {
				ruff = {
					-- Have not been able to get these to work, so ignoring some of them in pyright instead
					-- select = { "F", "E", "W", "I" },
					-- ignore = { "E501", "F821" },
				},
			},
			-- Use the reusable function with import organizing
			on_attach = function(client, bufnr)
				setup_auto_format(client, bufnr, true) -- Enable import organizing for ruff
			end,
		})
		vim.lsp.config("pyright", {
			settings = {
				pyright = {
					-- Using Ruff's import organizer
					disableOrganizeImports = true,
				},
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
						autoImportCompletion = true,
						diagnosticSeverityOverrides = {
							-- Disabling a bunch of these as they overlap with ruff, although this isn't all of them
							reportUnusedImport = "none",
							reportUnusedVariable = "none",
							reportUndefinedVariable = "none",
							reportUnboundVariable = "none",
							reportUnusedExpression = "none",
						},
					},
				},
			},
		})

		-- Go
		vim.lsp.config("gopls", {
			-- Run gopls with Go modules disabled only for wearedev.
			cmd = (function()
				local cwd = vim.fn.getcwd()
				if string.find(cwd, "wearedev") then
					return { "env", "GO111MODULE=off", "gopls", "-remote=auto" }
				end
				return { "gopls", "-remote=auto" }
			end)(),

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
				local root_markers = {
					--"main.go",
					"README.md",
					"go.mod",
					"LICENSE",
				} -- Add more as needed
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
