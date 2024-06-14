local ok_hydra, Hydra = pcall(require, "hydra")
if not ok_hydra then
  vim.notify("hydra not installed...", vim.log.ERROR)
  return
end

local M = {}

local venn_hint_utf = [[
 Arrow^^^^^^  Select region with <C-v>^^^^^^
 ^ ^ _K_ ^ ^  _f_: Surround with box ^ ^ ^ ^
 _H_ ^ ^ _L_  _<C-h>_: ◄, _<C-j>_: ▼
 ^ ^ _J_ ^ ^  _<C-k>_: ▲, _<C-l>_: ► _<Esc>_
]]

-- :setlocal ve=all
-- :setlocal ve=none
M.venn_hydra = Hydra({
  name = "Draw Diagram",
  hint = venn_hint_utf,
  config = {
    color = "pink",
    invoke_on_body = true,
    on_enter = function()
      vim.wo.virtualedit = "all"
    end,
    hint = {
      border = "single",
      position = "bottom-left",
    },
  },
  mode = "n",
  body = "<localleader>hv",
  heads = {
    { "<C-h>", "xi<C-v>u25c4<Esc>" }, -- mode = 'v' somehow breaks
    { "<C-j>", "xi<C-v>u25bc<Esc>" },
    { "<C-k>", "xi<C-v>u25b2<Esc>" },
    { "<C-l>", "xi<C-v>u25ba<Esc>" },
    { "H", "<C-v>h:VBox<CR>" },
    { "J", "<C-v>j:VBox<CR>" },
    { "K", "<C-v>k:VBox<CR>" },
    { "L", "<C-v>l:VBox<CR>" },
    { "f", ":VBox<CR>", { mode = "v" } },
    { "<Esc>", nil, { exit = true } },
  },
})

return M
