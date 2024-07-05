local use_eslint = {}

local function FixAll()
  -- callback = function() vim.b.autoformat = false end,
  if vim.b.autoformat then
    vim.notify("Fixed By Default", vim.log.levels.INFO)
  else
    local eslint_exists = vim.fn.exists ":EslintFixAll"
    -- vim.notify("Hello from Lua!" .. eslint_exists, vim.log.levels.INFO)
    if eslint_exists > 0 then
      vim.notify("Eslint Fixed", vim.log.levels.INFO)
      vim.api.nvim_command ":EslintFixAll"
    else
      vim.notify("Eslint config is not found!", vim.log.levels.INFO)
    end
  end
end

use_eslint.fixer = FixAll

return use_eslint
