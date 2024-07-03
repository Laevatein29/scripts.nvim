local function FixAll()
  local eslint_exists = vim.fn.exists ":EslintFixAll"
  -- vim.notify("Hello from Lua!" .. eslint_exists, vim.log.levels.INFO)
  if eslint_exists > 0 then
    vim.notify("Eslint Fixed", vim.log.levels.INFO)
    vim.api.nvim_command ":EslintFixAll"
  else
    vim.notify("Eslint config is not found!", vim.log.levels.INFO)
  end
end
return FixAll
