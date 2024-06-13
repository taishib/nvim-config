local M = {}

M.sidebar = {
  side = "left",
  -- open = vim.o.columns >= 150, --vim.fn.argc() ~= 0,
  open = false,
  section_separator = { " ", " " },
  sections = {
    -- "git",
    "datetime",
    "files",
    -- "symbols",
    -- "diagnostics",
    "todos",
    "containers",
  },
}

M.neotree = {
  source_selector = {
    winbar = false,
  },
  sources = {
    "filesystem",
    "buffers",
    "git_status",
    "diagnostics",
  },
  open_files_do_not_replace_types = {
    "terminal",
    "Trouble",
    "trouble",
    "qf",
    "Outline",
    "edgy",
  },
  filesystem = {
    bind_to_cwd = true,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    hijack_netrw_behavior = "disabled",
  },
  window = {
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
      ["<space>"] = "none",
      ["Y"] = {
        function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.setreg("+", path, "c")
        end,
        desc = "Copy Path to Clipboard",
      },
      ["O"] = {
        function(state)
          require("lazy.util").open(
            state.tree:get_node().path,
            { system = true }
          )
        end,
        desc = "Open with System Application",
      },
      ["P"] = { "toggle_preview", config = { use_float = false } },
    },
  },
  default_component_configs = {
    indent = {
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    git_status = {
      symbols = {
        unstaged = "󰄱",
        staged = "󰱒",
      },
    },
  },
}

M.aerial = {
  layout = {
    default_direction = "left",
    placement = "edge",
  },
  attach_mode = "global",
}

return M
