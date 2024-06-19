return {
  {
    -- "folke/neoconf.nvim",
    "willothy/neoconf.nvim",
    branch = "0.10-deprecations",
    config = true,
    -- event = "VimEnter",
  },
  {
    -- "anuvyklack/hydra.nvim" -- original author
    "nvimtools/hydra.nvim", -- active fork
    -- "willothy/hydra.nvim",
    -- dir = "~/projects/lua/hydra.nvim/",
  },
  -- COMMANDS --
  {
    "smjonas/live-command.nvim",
    config = function()
      require("configs.editor.live_cmd")
    end,
    cmd = "Norm",
  },
  {
    "mrjones2014/legendary.nvim",
    cmd = "Legendary",
    config = function()
      require("configs.editor.legendary")
    end,
  },
  -- EDITING --
  {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("configs.editor.comment")
    end,
    event = "VeryLazy",
  },
  {
    "LudoPinelli/comment-box.nvim",
    config = function()
      require("configs.editor.comment-box")
    end,
    event = "VeryLazy",
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {
      is_block_ui_break = true,
      open_cmd = "noswapfile vnew",
    },
  },
  {
    "willothy/moveline.nvim",
    -- branch = "oxi",
    event = "VeryLazy",
    build = "make build",
    enabled = false,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    config = function()
      require("mini.move").setup()
    end,
  },
  {
    "gbprod/substitute.nvim",
    opts = {
      yank_substituted_text = true,
    },
    event = "VeryLazy",
    keys = {
      { "U", "<cmd>lua require('substitute').operator()<cr>", mode = "n" },
      { "U", "<cmd>lua require('substitute').visual()<cr>", mode = "x" },
      { "UU", "<cmd>lua require('substitute').line()<cr>", mode = "n" },
      { "cX", "<cmd>lua require('substitute').eol()<cr>", mode = "n" },
      {
        "cx",
        "<cmd>lua require('substitute.exchange').operator()<CR>",
        mode = "n",
        { noremap = true },
      },
      {
        "cxx",
        "<cmd>lua require('substitute.exchange').line()<CR>",
        mode = "n",
        { noremap = true },
      },
      {
        "X",
        "<cmd>lua require('substitute.exchange').visual()<CR>",
        mode = "x",
        { noremap = true },
      },
      {
        "cxc",
        "<cmd>lua require('substitute.exchange').cancel()<CR>",
        mode = "n",
        { noremap = true },
      },
    },
  },
  -- TREESITTER --
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "IndianBoy42/tree-sitter-just",
      "chrisgrieser/nvim-various-textobjs",
      "windwp/nvim-ts-autotag", -- Automatically add closing tags for HTML and JSX
      "RRethy/nvim-treesitter-endwise",
      "yioneko/nvim-yati",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = function()
      require("configs.editor.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = { mode = "cursor", max_lines = 3 },
    keys = {
      {
        "<leader>ut",
        function()
          local tsc = require("treesitter-context")
          tsc.toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    ft = "markdown",
    config = function()
      require("configs.editor.headlines")
    end,
  },
  {
    "jmbuhr/otter.nvim",
    ft = "markdown",
    config = function()
      require("configs.editor.otter")
    end,
  },
  {
    "folke/todo-comments.nvim",
    config = true,
    event = "VeryLazy",
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      {
        "<leader>xt",
        "<cmd>Trouble todo toggle<cr>",
        desc = "Todo (Trouble)",
      },
      {
        "<leader>xT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      {
        "<leader>fT",
        "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
        desc = "Todo/Fix/Fixme",
      },
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = function()
      require("luarocks-nvim").setup({
        rocks = {
          "magick",
        },
      })
    end,
    event = "VeryLazy",
  },
  {
    "nvim-neorg/neorg",
    dependencies = {
      "pysan3/pathlib.nvim",
      "nvim-lua/plenary.nvim",
      "vhyrro/luarocks.nvim",
      "nvim-neorg/lua-utils.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "Neorg",
    ft = "norg",
    config = function()
      require("configs.editor.neorg")
    end,
  },
  -- DEFAULT FEATURE EXTENSIONS --
  {
    "gbprod/yanky.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
    },
    -- commit = "590a713b0372485f595eea36e7e3ab2069946794",
    event = "VeryLazy",
    config = function()
      require("configs.editor.yanky")
    end,
  },
  {
    "willothy/marks.nvim",
    event = "VeryLazy",
    opts = {
      refresh_interval = 1000,
    },
  },
  {
    "nacro90/numb.nvim",
    config = true,
    event = "CmdlineEnter",
  },
  {
    "utilyre/sentiment.nvim",
    event = "VeryLazy",
    opts = {
      delay = 30,
      pairs = {
        { "(", ")" },
        { "{", "}" },
        { "[", "]" },
      },
    },
  },
  -- FILE MANAGERS & FUZZY FINDERS --
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("configs.editor.telescope")
    end,
    -- event = "VeryLazy",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "dhruvmanila/browser-bookmarks.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      --"nvim-telescope/telescope-smart-history.nvim", -- cool but causes sqlite error atm
      "polirritmico/telescope-lazy-plugins.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "File Browser",
      },
      {
        "<leader>fb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader>f:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
      },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      {
        "<leader>sa",
        "<cmd>Telescope autocommands<cr>",
        desc = "Auto Commands",
      },
      {
        "<leader>sb",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Buffer",
      },
      {
        "<leader>sc",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
      },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      {
        "<leader>sd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document Diagnostics",
      },
      {
        "<leader>sD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace Diagnostics",
      },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      {
        "<leader>uc",
        "<cmd>Telescope colorscheme<cr>",
        desc = "Change Colorscheme",
      },
      -- Show help actions with telescope
      {
        "<leader>ad",
        function()
          local actions = require("CopilotChat.actions")
          local help = actions.help_actions()
          require("CopilotChat.integrations.telescope").pick(help)
        end,
        desc = "Diagnostic Help (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(
            actions.prompt_actions()
          )
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension("smart_open")
      require("telescope").extensions.smart_open.smart_open({
        cwd_only = false,
        filename_first = true,
      })
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope").extensions.smart_open.smart_open()
        end,
        desc = "Files",
        mode = { "n" },
      },
    },
    enabled = false,
  },
  {
    "stevearc/oil.nvim",
    -- "willothy/oil.nvim",
    -- branch = "feat-select-win",
    -- dir = "~/projects/lua/oil.nvim/",
    config = function()
      require("configs.editor.oil")
    end,
    cmd = "Oil",
  },
  {
    "echasnovski/mini.files",
    -- "willothy/mini.files",
    config = function()
      require("configs.editor.mini-files")
    end,
    cmd = "MiniFiles",
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
  {
    "echasnovski/mini.pick",
    dependencies = {
      { "echasnovski/mini.extra", opts = {} },
      { "echasnovski/mini.visits", opts = {} },
      { "echasnovski/mini.fuzzy", opts = {} },
    },
    cmd = "Pick",
    keys = { "<localleader>p" },
    config = function()
      require("configs.editor.mini-pick")
    end,
  },
  -- SESSIONS / PROJECTS --
  {
    "stevearc/resession.nvim",
    -- dir = "~/projects/lua/resession.nvim/",
    dependencies = {
      "tiagovla/scope.nvim",
      "stevearc/oil.nvim",
    },
    config = function()
      require("configs.projects.resession")
    end,
    event = "UiEnter",
  },
  {
    -- "ahmedkhalf/project.nvim",
    "LennyPhoenix/project.nvim",
    branch = "fix-get_clients",
    name = "project_nvim",
    event = "VeryLazy",
    config = function()
      require("configs.projects.project")
    end,
  },
  {
    "tiagovla/scope.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "willothy/savior.nvim",
    config = true,
    event = { "InsertEnter", "TextChanged" },
  },
  -- TERMINAL --
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    -- dir = "~/projects/lua/toggleterm.nvim/",
    config = function()
      require("configs.terminal.toggleterm")
    end,
  },
  {
    "willothy/flatten.nvim",
    branch = "guest-data",
    -- dir = "~/projects/lua/flatten/",
    -- cond = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("configs.terminal.flatten")
    end,
  },
  {
    "willothy/wezterm.nvim",
    -- dir = "~/projects/lua/wezterm.nvim/",
    config = function()
      require("configs.editor.wezterm")
    end,
    cmd = { "Wezterm" },
  },
  {
    "stevearc/overseer.nvim",
    config = function()
      require("configs.editor.overseer")
    end,
    cmd = {
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerRunOpen",
      "OverseerRunToggle",
    },
  },
  -- NAVIGATION --
  -- {
  --   "LeonHeidelbach/trailblazer.nvim",
  --   config = function()
  --     require("configs.navigation.trailblazer")
  --   end,
  --   event = "VeryLazy",
  -- },
  {
    "folke/flash.nvim",
    config = function()
      require("configs.navigation.flash")
    end,
    keys = {
      { "f", desc = "flash" },
      { "F", desc = "flash" },
      { "t", desc = "flash" },
      { "T", desc = "flash" },
    },
    -- event = "VeryLazy",
  },
  {
    "ThePrimeagen/harpoon",
    commit = "a38be6e0dd4c6db66997deab71fc4453ace97f9c",
    branch = "harpoon2",
    -- "willothy/harpoon",
    -- dir = "~/projects/lua/harpoon/",
    config = function()
      require("configs.navigation.harpoon")
    end,
  },
  {
    "cbochs/portal.nvim",
    config = function()
      require("configs.navigation.portal")
    end,
    cmd = "Portal",
  },
  {
    "chrisgrieser/nvim-spider",
    config = true,
  },
  {
    "haya14busa/vim-edgemotion",
    keys = {
      { "ej", "<Plug>(edgemotion-j)", mode = "n" },
      { "ek", "<Plug>(edgemotion-k)", mode = "n" },
    },
  },
  {
    "toppair/reach.nvim",
    config = function()
      require("configs.editor.reach")
    end,
    cmd = "ReachOpen",
  },
  {
    "abecodes/tabout.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {
      tabkey = "",
      backwards_tabkey = "",
      act_as_tab = true,
      ignore_beginning = true,
      act_as_shift_tab = false,
      default_tab = "",
      default_shift_tab = "",
    },
  },
  -- GIT --
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.git.gitsigns")
    end,
    event = "VeryLazy",
  },
  {
    "sindrets/diffview.nvim",
    config = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("configs.git.git-conflict")
    end,
    event = "VeryLazy",
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    config = function()
      require("configs.git.neogit")
    end,
  },
  {
    "linrongbin16/gitlinker.nvim",
    opts = {
      message = true,
    },
    cmd = "GitLink",
  },
  -- MISC --
  {
    "echasnovski/mini.trailspace",
    config = true,
    event = { "TextChanged", "TextChangedI" },
  },
  {
    "chomosuke/term-edit.nvim",
    opts = {
      prompt_end = "-> ",
    },
    event = "TermEnter",
  },
  {
    "LhKipp/nvim-nu",
    config = true,
    ft = "nu",
  },
  {
    "tris203/hawtkeys.nvim",
    -- dir = "~/projects/lua/hawtkeys.nvim/",
    config = function()
      require("configs.editor.hawtkeys")
    end,
    cmd = "Hawtkeys",
  },
  {
    "tris203/precognition.nvim",
    opts = {
      startVisible = false,
      showBlankVirtLine = false,
    },
    event = "VeryLazy",
    -- dir = "~/projects/lua/precognition.nvim/",
  },
  {
    "johmsalas/text-case.nvim",
    opts = {
      default_keymappings_enabled = false,
    },
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },
  {
    "gabrielpoca/replacer.nvim",
    opts = { rename_files = false },
    keys = {
      {
        "<leader>rh",
        function()
          require("replacer").run()
        end,
        desc = "run replacer.nvim",
      },
    },
  },
}
