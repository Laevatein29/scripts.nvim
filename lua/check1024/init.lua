local check1024 = {}

local function create_pixel_text(text)
  local pixel_text = string.upper(text):gsub(".", "%1 ")
  return pixel_text
end

local function show_celebration_window(showEx)
  local width = 120
  local height = 20
  local row = (vim.o.lines - height) / 2
  local col = (vim.o.columns - width) / 2

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "single",
  })

  local lines = {
    "  _,-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-",
    " / _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ \\",
    ">|  H A P P Y   P R O G R A M M E R ' S   D A Y !  <|",
    " \\_/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ _/ /",
    " `-'`-'`-'`-'`-'`-'`-'`-'`-'`-'`-'`-'`-'`-'`-'`-'`-'",
    "",
  }

  if showEx then table.insert(lines, create_pixel_text "Stack Overflow! emmm, but, anyway,") end

  table.insert(lines, create_pixel_text "Happy Programmer's Day!")

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.api.nvim_buf_add_highlight(buf, -1, "Title", 2, 0, -1)
  vim.api.nvim_buf_add_highlight(buf, -1, "Comment", 6, 0, -1)

  vim.cmd [[
    hi default Title guifg=#00ff00 guibg=#000000 gui=bold
    hi default Comment guifg=#008080 guibg=#000000
  ]]

  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<CR>", { noremap = true, silent = true })
end

local function check_date()
  local current_month = os.date "%m"
  local current_day = os.date "%d"

  if current_month == "10" then
    if tonumber(current_day) == 24 then
      show_celebration_window()
    elseif tonumber(current_day) > 24 then
      show_celebration_window(true)
    end
  end
end

vim.api.nvim_create_user_command("Check1024", check_date, {})

check1024.checker = check_date

return check1024
