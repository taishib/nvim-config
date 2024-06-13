local mapping = require("yanky.telescope.mapping")
local utils = require("yanky.utils")

require("yanky").setup({
  ring = {
    storage = "sqlite",
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  picker = {
    telescope = {
      mappings = {
        default = mapping.put("p"),
        i = {
          ["<c-g>"] = mapping.put("p"),
          ["<c-k>"] = mapping.put("P"),
          ["<c-x>"] = mapping.delete(),
          ["<c-r>"] = mapping.set_register(utils.get_default_register()),
        },
        n = {
          p = mapping.put("p"),
          P = mapping.put("P"),
          d = mapping.delete(),
          r = mapping.set_register(utils.get_default_register()),
        },
      },
    },
  },
})
