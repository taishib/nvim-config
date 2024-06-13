require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<C-j>",
      accept_word = false,
      accept_line = false,
    },
  },
  panel = {
    enabled = false,
  },
})
