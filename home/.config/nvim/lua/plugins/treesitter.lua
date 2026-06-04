return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})

      local installed = require("nvim-treesitter").get_installed()
      local wanted = {
        "lua",
        "javascript",
        "typescript",
        "terraform",
        "go",
        "yaml",
        "markdown",
        "markdown_inline",
      }
      local missing = vim.tbl_filter(function(lang)
        return not vim.list_contains(installed, lang)
      end, wanted)
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select_textobject = function(query)
        return function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end
      end

      local select_maps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["as"] = "@scope.outer",
        ["is"] = "@scope.inner",
        ["at"] = "@parameter.outer",
        ["it"] = "@parameter.inner",
      }

      for key, query in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, select_textobject(query))
      end

      local move = require("nvim-treesitter-textobjects.move")
      local move_maps = {
        ["]m"] = { move.goto_next_start, "@function.outer" },
        ["]]"] = { move.goto_next_start, "@class.outer" },
        ["]M"] = { move.goto_next_end, "@function.outer" },
        ["]["] = { move.goto_next_end, "@class.outer" },
        ["[m"] = { move.goto_previous_start, "@function.outer" },
        ["[["] = { move.goto_previous_start, "@class.outer" },
        ["[M"] = { move.goto_previous_end, "@function.outer" },
        ["[]"] = { move.goto_previous_end, "@class.outer" },
      }

      for key, mapping in pairs(move_maps) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          mapping[1](mapping[2], "textobjects")
        end)
      end
    end,
  },
}
