local wk = require("which-key")

wk.register({
  ["<Leader>"] = {
    C = {
      name = " □  Boxes",
      b = { "<Cmd>CBccbox<CR>", "Box Title" },
      t = { "<Cmd>CBllline<CR>", "Titled Line" },
      l = { "<Cmd>CBline<CR>", "Simple Line" },
      m = { "<Cmd>CBllbox14<CR>", "Marked" },
      -- d = { "<Cmd>CBd<CR>", "Remove a box" },
    },
  },
})
