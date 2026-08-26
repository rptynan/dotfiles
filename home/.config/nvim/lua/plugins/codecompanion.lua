return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"github/copilot.vim",
	},
	init = function()
		require("plugins.codecompanion.copilot"):init()
	end,
	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					window = {
						layout = "vertical",
						-- If there are horizontal splits, follow their height.
						full_height = false,
					},
				},
			},
			interactions = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
				},
			},
			adapters = {
				http = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							opts = {},
							schema = {
								model = {
									-- default = "claude-sonnet-4.6",
									-- Trying this out as I mostly use this for quick queries now
									default = "claude-haiku-4.5",
								},
							},
						})
					end,
					openai = function()
						return require("codecompanion.adapters").extend("openai", {
							opts = {
								stream = true,
							},
							env = {
								api_key = "cmd: cat ~/.config/openai.token",
							},
							schema = {
								model = {
									default = function()
										return "gpt-4.1"
									end,
								},
							},
						})
					end,
				},
			},
		})

		-- Open existing chat, or new one if none exist
		vim.keymap.set("n", "<leader>c", ":CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })
		-- Add selected content to the chat window
		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
