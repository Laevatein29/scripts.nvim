if vim.g.use_local then return end
vim.g.use_local = true

local SetLocal = require("set-local").setter

vim.is_local = false

vim.api.nvim_create_user_command(
  "SetLocal", --
  SetLocal, --
  {
    nargs = "?",
  }
)
