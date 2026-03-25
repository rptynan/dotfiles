-- Adds support for more LSP capabilities.
return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"windwp/nvim-autopairs",
		"hrsh7th/cmp-buffer",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			completion = {
				-- Only show completions when manually triggered (C-n).
				autocomplete = false,
			},
			preselect = cmp.PreselectMode.None,
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{
					name = "buffer",
					-- Use all open buffers as sources.
					option = {
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end,
					},
				},
			}),
			window = {
				completion = {
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
				},
				documentation = {
					border = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			mapping = cmp.mapping.preset.insert({
				-- C-n and C-p work for selecting options. Scroll in docs window.
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-space>"] = cmp.mapping.confirm({ select = true }),
			}),
		})

		cmp.setup.filetype("codecompanion", {
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}),
		})

		local autopairs = require("nvim-autopairs")
		autopairs.setup({})
	end,
}
