vim.g.nvim_ghost_autostart = 0

return {
  {
    "willothy/strat-hero.nvim",
    config = true,
    cmd = "StratHero",
  },
  {
    "jbyuki/venn.nvim",
    cmd = "VBox",
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
  {
    "rafcamlet/nvim-luapad",
    config = true,
    cmd = "Luapad",
  },
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow" },
  },
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    config = function()
      require("configs.editor.neocomposer")
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    opts = { auto_cmd = true },
    event = "VeryLazy",
  },
  {
    "kawre/leetcode.nvim",
    config = function()
      require("configs.editor.leetcode")
    end,
    cmd = "Leet",
  },
  {
    "AckslD/nvim-neoclip.lua",
    opts = {
      enable_persistent_history = true,
      continuous_sync = true,
    },
    event = "VeryLazy",
  },
  {
    "rawnly/gist.nvim",
    config = true,
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
  },
  {
    "Saecki/crates.nvim",
    config = function()
      require("configs.editor.crates")
    end,
    event = "BufRead Cargo.toml",
  },
  {
    "tomiis4/Hypersonic.nvim",
    cmd = "Hypersonic",
    config = function()
      require("configs.editor.hypersonic")
    end,
  },
  {
    "bennypowers/nvim-regexplainer",
    config = function()
      require("regexplainer").setup({
        mappings = {
          toggle = "gR",
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "tzachar/highlight-undo.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "neph-iap/easycolor.nvim",
    opts = { ui = { border = "solid" } },
    cmd = "EasyColor",
  },
  {
    "krady21/compiler-explorer.nvim",
    config = true,
    cmd = {
      "CECompile",
      "CECompileLive",
    },
  },
  {
    "Tyler-Barham/floating-help.nvim",
    config = function()
      require("configs.editor.floating-help")
    end,
    cmd = "FloatingHelp",
  },
  {
    "jokajak/keyseer.nvim",
    config = true,
    cmd = "KeySeer",
  },
  {
    "chrisgrieser/nvim-scissors",
    opts = {
      editSnippetPopup = {
        border = "solid",
      },
      jsonFormatter = "jq",
    },
  },
  {
    "pwntester/octo.nvim",
    config = true,
    cmd = "Octo",
  },
  -- TODO: re-enable this
  -- {
  --   "subnut/nvim-ghost.nvim",
  --   event = "VeryLazy",
  -- },
  {
    "mong8se/actually.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "gbprod/stay-in-place.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", "<Plug>(dial-increment)", mode = { "n", "x" } },
      { "g<C-a>", "g<Plug>(dial-increment)", mode = { "x" } },
      { "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "x" } },
      { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "x" } },
    },
    config = function()
      require("configs.editor.dial")
    end,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
      {
        "<leader>cN",
        function()
          require("neogen").generate()
        end,
        desc = "Generate Annotations (Neogen)",
      },
    },
    opts = function(_, opts)
      if opts.snippet_engine ~= nil then
        return
      end

      local map = {
        ["LuaSnip"] = "luasnip",
        ["nvim-snippy"] = "snippy",
        ["vim-vsnip"] = "vsnip",
      }

      for plugin, engine in pairs(map) do
        if LazyVim.has(plugin) then
          opts.snippet_engine = engine
          return
        end
      end

      if vim.snippet then
        opts.snippet_engine = "nvim"
      end
    end,
  },
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "2kabhishek/nerdy.nvim",
    cmd = "Nerdy",
    keys = {
      { "<leader>ui", "<cmd>Nerdy<cr>", desc = "Pick Icon" },
    },
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
}
