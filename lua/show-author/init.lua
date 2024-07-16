local Show_author = {}

Show_author.generate = function()
  local co_authors = vim.fn.systemlist 'git log --format="%aN <%aE>"'
  local unique_co_authors = {}
  for _, author in ipairs(co_authors) do
    if not unique_co_authors[author] then
      unique_co_authors[author] = true
      unique_co_authors[#unique_co_authors + 1] = author
    end
  end
  return unique_co_authors
end

Show_author.list = function()
  local authors = Show_author.generate()
  local items = {}
  for _, author in ipairs(authors) do
    items[#items + 1] = author
  end
  if #authors > 0 then
    vim.ui.select(items, { prompt = "Select Show-Author" }, function(item, _)
      if item ~= nil then
        local filename = vim.fn.expand "%:t"
        local date = os.date "%Y-%m-%d"
        local current_line = vim.fn.line "."
        local filetype = vim.bo.filetype

        -- 根据文件类型选择注释格式
        local comment_start, comment_end
        if filetype == "lua" or filetype == "sh" then
          comment_start, comment_end = "--", ""
        elseif filetype == "python" then
          comment_start, comment_end = "#", ""
        elseif filetype == "c" or filetype == "cpp" or filetype == "java" then
          comment_start, comment_end = "/*", "*/"
        else
          comment_start, comment_end = "//", ""
        end

        -- 插入注释
        vim.fn.append(current_line, string.format("%s", comment_start))
        vim.fn.append(current_line + 1, string.format("%s @filename - %s %s", comment_start, filename, comment_end))
        vim.fn.append(current_line + 2, string.format("%s @authored-by - %s %s", comment_start, item, comment_end))
        vim.fn.append(current_line + 3, string.format("%s @date - %s %s", comment_start, date, comment_end))
        vim.fn.append(current_line + 4, string.format("%s", comment_start))
      end
    end)
  end
end

Show_author.todo = function()
  local items = {}
  vim.ui.select(items, { prompt = "Select Show-Author" }, function(item, _)
    -- 获取当前文件名、日期、当前行号和文件类型
    local filename = vim.fn.expand "%:t"
    local date = os.date "%Y-%m-%d"
    local current_line = vim.fn.line "."
    local filetype = vim.bo.filetype

    -- 根据文件类型选择注释格式
    local comment_start, comment_end
    if filetype == "lua" or filetype == "sh" then
      comment_start, comment_end = "--", ""
    elseif filetype == "python" then
      comment_start, comment_end = "#", ""
    elseif filetype == "c" or filetype == "cpp" or filetype == "java" then
      comment_start, comment_end = "/*", "*/"
    elseif filetype == "vue" then
      comment_start, comment_end = "<!--", "-->"
    else
      comment_start, comment_end = "//", ""
    end

    -- 定义注释内容
    local comments = {
      "generated by Laevatein29/scripts.nvim show-author",
      "PERF: fully optimised - ",
      "HACK: hmmm, this looks a bit funky- ",
      "TODO: What else?- ",
      "NOTE: adding a note- ",
      "FIX: this needs fixing- ",
      "WARNING: ???- ",
      "@filename - " .. filename,
      "@authored-by - Laevatein29",
      "@date - " .. date,
    }

    -- 插入注释
    vim.fn.append(current_line, string.format("%s", comment_start))
    for i, comment in ipairs(comments) do
      vim.fn.append(current_line + i, string.format("%s %s %s", comment_start, comment, comment_end))
    end
    vim.fn.append(current_line + #comments + 1, string.format("%s", comment_start))
  end)
end

return Show_author
