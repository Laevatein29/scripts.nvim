local set_local = {}

local function SetLocal()
  vim.g.is_local = not vim.g.is_local
  local is_local = vim.g.is_local
  local status = is_local and "on" or "off"

  local message = string.format("Config switcher is %s!", status)
  vim.notify_once(message)
end

set_local.setter = SetLocal

return set_local
