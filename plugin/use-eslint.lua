if vim.g.use_eslint then return end
vim.g.use_eslint = true
local FixAll = require("use-eslint").fixer

vim.api.nvim_create_user_command(
  "FixAll", --
  FixAll, -- Lua
  { nargs = "?" } --
)
