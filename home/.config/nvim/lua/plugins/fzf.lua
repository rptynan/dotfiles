return {
	{
		"ibhagwan/fzf-lua",
		config = function()
			require("fzf-lua").setup({
				winopts = {
					preview = {
						-- Use vertical layout only if we have more columns than this.
						flip_columns = 200,
					},
				},
				keymap = {
					builtin = {
						["<C-h>"] = "toggle-preview",
					},
					fzf = {
						["ctrl-h"] = "toggle-preview",
					},
				},
			})

			-- Utility function to get directory of current buffer.
			-- For regular file buffers, this is the directory they sit in. For netrw, it's the directory that is open.
			local function get_buffer_dir()
				if vim.bo.filetype == "netrw" then
					return vim.b.netrw_curdir
				else
					return vim.fn.expand("%:p:h")
				end
			end

			-- a for buffers
			vim.keymap.set("n", "<Leader>a", function()
				require("fzf-lua").buffers()
			end)
			-- A for global search
			vim.keymap.set("n", "<Leader>A", function()
				require("fzf-lua").global()
			end)
			-- File search for github files (good proxy for working set)
			vim.keymap.set("n", "<Leader>f", function()
				require("fzf-lua").git_files()
			end)
			-- Modified files in staging area
			vim.keymap.set("n", "<Leader>F", function()
				require("fzf-lua").git_status()
			end)
			-- Text search (ripgrep) with glob support
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
			-- Text search (ripgrep) with glob support, but scoped to current directory
			vim.keymap.set("n", "<Leader>sc", function()
				require("fzf-lua").live_grep({ cwd = get_buffer_dir() })
			end)
			-- Same but for word under cursor
			vim.keymap.set("n", "<Leader>Sc", function()
				require("fzf-lua").grep_cword({ cwd = get_buffer_dir() })
			end)
			-- Same but for already-selected region
			vim.keymap.set("v", "<Leader>Sc", function()
				require("fzf-lua").grep_visual({ cwd = get_buffer_dir() })
			end)
		end,
	},
}
