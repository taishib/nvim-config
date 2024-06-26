local keymap = willothy.map
local bind, modes = keymap.bind, keymap.modes

local legendary = function(filter)
  return function()
    local f = require("legendary.filters")
    require("legendary").find({ filters = { f[filter]() } })
  end
end

local cody

local telescope = willothy.fn.telescope

local wk = require("which-key")

wk.register({
  name = "+view",
  q = bind("trouble", "open", "quickfix"):with_desc("trouble: quickfix"),
  l = bind("trouble", "open", "loclist"):with_desc("trouble: loclist"),
  d = bind("dapui", "toggle"):with_desc("dap-ui"),
  o = { telescope.oldfiles, "oldfiles" },
  z = { "<cmd>ZenMode<CR>", "zen mode" },
  p = {
    function()
      willothy.player.toggle()
    end,
    "player",
  },
  r = {
    telescope.registers,
    "registers",
  },
  s = {
    telescope.lsp_document_symbols,
    "document symbols",
  },
  c = {
    function()
      if not cody then
        local CodySplit = require("sg.components.layout.split")
        cody = CodySplit.init({
          name = "main",
        })
      end
      cody:toggle()
    end,
    "cody chat",
  },
  u = { vim.cmd.UndotreeToggle, "undotree" },
  L = {
    name = "legendary",
    k = {
      legendary("keymaps"),
      "keymaps",
    },
    a = {
      legendary("autocmds"),
      "autocmds",
    },
    c = {
      legendary("commands"),
      "commands",
    },
    f = {
      legendary("funcs"),
      "functions",
    },
  },
}, { mode = modes.non_editing, prefix = "<leader>v" })
