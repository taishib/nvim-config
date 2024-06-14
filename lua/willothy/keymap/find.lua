local keymap = willothy.map
local modes = keymap.modes

local telescope = willothy.fn.telescope

local wk = require("which-key")

wk.register({
  name = "+find",
  f = {
    function()
      require("telescope").extensions.frecency.frecency({
        sorter = require("telescope").extensions.fzf.native_fzf_sorter(),
      })
    end,
    "files",
  },
  s = {
    telescope.live_grep,
    "live grep",
  },
  g = {
    telescope.git_files,
    "git files",
  },
  p = {
    telescope.projects,
    "projects",
  },
  u = {
    function()
      vim.cmd.UndotreeToggle()
    end,
    "undo history",
  },
  P = {
    telescope.builtin,
    "telescope pickers",
  },
  y = {
    telescope.yank_history,
    "yank history",
  },
  v = {
    function()
      local buf = vim.api.nvim_get_current_buf()
      local dir
      if vim.bo[buf].buftype == "" then
        dir = vim.fs.dirname(vim.api.nvim_buf_get_name(buf))
      else
        dir = vim.fn.getcwd()
      end
      willothy.fs.browse(dir)
    end,
    "File Browser",
  },
  V = {
    "<cmd>BrowserSwitch<cr>",
    "Switch Browser",
  },
}, { mode = modes.non_editing, prefix = "<leader>f" })
