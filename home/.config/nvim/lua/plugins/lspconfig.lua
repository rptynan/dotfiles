return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"nvimtools/none-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
		"pmizio/typescript-tools.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local null_ls = require("null-ls")

		-- TypeScript (ts_ls)
		require("typescript-tools").setup({
			settings = {
				typescript = {
					-- inlay hints here might be good
				},
			},
			on_attach = function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- gi for goto implemenation
				vim.keymap.set("n", "gI", vim.lsp.buf.type_definition, bufopts) -- gt for goto type
				vim.keymap.set("n", "<leader>o", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<leader>u", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>i", "<cmd>TSToolsOrganizeImports<CR>", bufopts)
				vim.keymap.set("n", "<leader>I", "<cmd>TSToolsAddMissingImports<CR>", bufopts)
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, bufopts) -- search references
				vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, bufopts) -- see all diags
				vim.keymap.set("n", "D", vim.diagnostic.open_float, bufopts) -- hover current diag
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- hover general
				vim.keymap.set("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", bufopts)
				vim.keymap.set("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>", bufopts)
			end,
			commands = {},
		})

		-- null-ls setup
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.formatting.prettier,
			},
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
	end,
}
