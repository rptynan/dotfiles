return {
	"tpope/vim-fugitive",
	dependencies = {
		-- For :GBrowse to open the current file on GitHub/GitLab/Bitbucket
		{ "tpope/vim-rhubarb" },
	},
	init = function()
		-- Make the fugitive status window a reasonable size.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function()
				vim.cmd("resize 20")
			end,
		})

		-- Workaround for vim-fugitive issue:
		-- https://github.com/tpope/vim-fugitive/issues/2441
		vim.api.nvim_create_user_command("Browse", function(opts)
			vim.fn.system({ "open", opts.fargs[1] })
		end, { nargs = 1 })
	end,
}
