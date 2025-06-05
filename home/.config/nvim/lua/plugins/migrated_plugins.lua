return {
	-- Maybe move to   {"ibhagwan/fzf-lua"} or nvim-telescope/telescope.nvim
	{ "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
	-- Used for above git fzfs
	{ "tpope/vim-fugitive" },
	-- Allows moving vim buffers like tmux panes.
	{ "christoomey/vim-tmux-navigator" },
	-- https://github.com/olimorris/codecompanion.nvim instead maybe
	{ "madox2/vim-ai" },
	-- cs'", cs({, ysiw", etc
	{ "tpope/vim-surround" },
	-- gc for easy comment/uncommenting.
	{ "tpope/vim-commentary" },
	-- Provides :Delete, :Move, :Rename, etc.
	{ "tpope/vim-eunuch" },
	-- For %S for smart search+replace and crs, crm, crc, cru for coercing to cases.
	{ "tpope/vim-abolish" },
	-- Git commands, mostly used by fzf git features.
	{ "tpope/vim-fugitive" },
	-- User <leader><motion> to navigate camel-case/etc better
	{ "chaoren/vim-wordmotion" },
}
