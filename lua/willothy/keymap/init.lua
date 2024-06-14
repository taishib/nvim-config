local map = vim.keymap.set

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map(
  "n",
  "n",
  "'Nn'[v:searchforward].'zv'",
  { expr = true, desc = "Next Search Result" }
)
map(
  "x",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
map(
  "o",
  "n",
  "'Nn'[v:searchforward]",
  { expr = true, desc = "Next Search Result" }
)
map(
  "n",
  "N",
  "'nN'[v:searchforward].'zv'",
  { expr = true, desc = "Prev Search Result" }
)
map(
  "x",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)
map(
  "o",
  "N",
  "'nN'[v:searchforward]",
  { expr = true, desc = "Prev Search Result" }
)

-- lazy
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<C-w>n", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- remove all mouse mappings
local disable = {
  -- "<2-LeftMouse>",
  -- "<LeftDrag>",
  -- "<LeftRelease>",
  "<3-LeftMouse>",
  "<4-LeftMouse>",
  "<RightMouse>",
  "<2-RightMouse>",
  "<3-RightMouse>",
  "<4-RightMouse>",
}

-- TODO: rewrite all of the keymaps
--
-- this section of config is incredibly messy

return {
  setup = function()
    for _, v in ipairs(disable) do
      vim.keymap.set(
        { "n", "v", "i" },
        v,
        function() end,
        { expr = true, desc = "which_key_ignore" }
      )
    end

    local bind = willothy.map.bind

    require("which-key").register({
      ["<leader>n"] = {
        nil,
        "neorg",
        group = true,
      },
      ["<leader>nn"] = "note",
      ["<leader>nl"] = "list",
      ["<leader>ni"] = "insert",
      ["<leader>nt"] = "task",
      ["<leader>nm"] = "mode",
      ["<leader>o"] = {
        function() end,
        "options",
        group = true,
        _ = "which_key_ignore",
      },
      ["<leader>"] = {
        t = {
          name = "terminal",
          t = bind(willothy.terminal.main, "toggle", willothy.terminal.main):with_desc(
            "main"
          ),
          v = bind(
            willothy.terminal.vertical,
            "toggle",
            willothy.terminal.vertical
          ):with_desc("vertical"),
          f = bind(willothy.terminal.float, "toggle", willothy.terminal.float):with_desc(
            "float"
          ),
          x = bind(willothy.terminal.xplr, "toggle", willothy.terminal.xplr):with_desc(
            "xplr"
          ),
          y = bind(willothy.terminal.yazi, "toggle", willothy.terminal.yazi):with_desc(
            "yazi"
          ),
          b = bind(willothy.terminal.btm, "toggle", willothy.terminal.btm):with_desc(
            "btm"
          ),
          s = bind(willothy.terminal, "send_to_main"):with_desc("send"),
          o = { "<cmd>OverseerFloat<cr>", "overseer: show" },
          r = {
            function()
              require("overseer").run_template()
            end,
            "overseer: run",
          },
          p = {
            function()
              willothy.terminal.py:toggle()
            end,
            "python",
          },
          l = {
            function()
              willothy.terminal.lua:toggle()
            end,
            "lua",
          },
        },
      },
    })

    require("willothy.keymap.editor")
    require("willothy.keymap.terminal")
    require("willothy.keymap.cycle")
    require("willothy.keymap.view")
    require("willothy.keymap.find")
    require("willothy.keymap.git")
    require("willothy.keymap.buffer")
    require("willothy.keymap.projects")
    require("willothy.keymap.lsp")
    require("willothy.keymap.jump")
    require("willothy.keymap.window")
    require("willothy.keymap.hydras")
  end,
}
