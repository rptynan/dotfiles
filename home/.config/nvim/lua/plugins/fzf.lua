return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("fzf-lua").setup({
				keymap = {
					builtin = {
						["<C-h>"] = "toggle-preview",
					},
					fzf = {
						["ctrl-h"] = "toggle-preview",
					},
				},
			})

			-- \a for buffers
			vim.keymap.set("n", "<Leader>a", function()
				require("fzf-lua").buffers()
			end)
			-- File search for github files (good proxy for working set)
			vim.keymap.set("n", "<Leader>f", function()
				require("fzf-lua").git_files()
			end)
			-- Modified files in staging area
			vim.keymap.set("n", "<Leader>F", function()
				require("fzf-lua").git_status()
			end)
			-- Text search (ripgrep)
			vim.keymap.set("n", "<Leader>s", function()
				require("fzf-lua").live_grep()
			end)
			-- Search for word under cursor
			vim.keymap.set("n", "<Leader>S", function()
				require("fzf-lua").grep_cword()
			end)
			-- Search for already-selected region (visual selection)
			vim.keymap.set("v", "<Leader>S", function()
				require("fzf-lua").grep_visual()
			end)
		end,
	},
}
