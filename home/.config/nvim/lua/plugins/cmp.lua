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
			performance = {
				-- Can be quite distracting to have completions firing up constantly, so trying to turn them down a bit.
				debounce = 300,
				throttle = 300,
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
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				-- C-n and C-p work for selecting options. Scroll in docs window.
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-space>"] = cmp.mapping.confirm({ select = true }),
			}),
		})

		local autopairs = require("nvim-autopairs")
		autopairs.setup({})
	end,
}
