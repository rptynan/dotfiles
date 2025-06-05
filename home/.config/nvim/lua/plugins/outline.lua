-- Commands for outline window:
-- <CR> moves to location and focuses there.
-- o moves to location but stays in outline window (aka peek).
-- C-j and C-k to move down the list + peek.
-- C-g moves cursor back to location that is in the code.
-- h to fold, l to unfold, <Tab> to toggle fold.
-- W to fold everything, E for unfold everything, R to reset.
-- lsp type stuff: K to hover, a to action and r rename.
return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>O", "<cmd>Outline<CR>", desc = "Toggle outline" },
	},
	opts = {
		symbol_folding = {
			auto_unfold = {},
		},
	},
}
