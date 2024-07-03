local FixAll = require("use-eslint").fixer

vim.api.nvim_create_user_command(
  "FixAll", --
  FixAll, -- Lua
  { nargs = "?" } --
)
