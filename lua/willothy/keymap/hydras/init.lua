local set = vim.keymap.set

set("n", "<localleader>hb", function() -- buffers
  require("willothy.keymap.hydras.buffers"):activate()
end, { desc = "buffers" })

set({ "n", "x" }, "<localleader>hg", function() -- git
  require("willothy.keymap.hydras.git"):activate()
end, { desc = "git" })

set({ "n", "x" }, "<localleader>ho", function() -- options
  require("willothy.keymap.hydras.git"):activate()
end, { desc = "options" })

set({ "n", "x" }, "gs", function() -- swap
  require("willothy.keymap.hydras.swap"):activate()
end, { desc = "swap" })

set("n", "<localleader>ht", function() -- telescope
  require("willothy.keymap.hydras.telescope"):activate()
end, { desc = "telescope" })

set("n", "<C-w>w", function() -- telescope
  require("willothy.keymap.hydras.windows"):activate()
end, { desc = "hydra" })

-- set("n", "<localleader>hy", function() -- telescope
--   require("willothy.keymap.hydras.yanky"):activate()
-- end, { desc = "yanky" })
