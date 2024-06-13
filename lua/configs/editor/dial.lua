local augend = require("dial.augend")
local config = require("dial.config")

config.augends:register_group({
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "log", "warn", "error", "debug", "info" },
      word = true,
      cyclic = true,
    }),
    augend.constant.new({
      elements = { "on", "off" },
      word = true,
      cyclic = true,
    }),
    augend.semver.alias.semver,
  },
})
