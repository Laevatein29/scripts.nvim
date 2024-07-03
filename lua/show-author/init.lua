-- local co_author = {}
--
-- co_author.generate = function()
--     local co_authors = vim.fn.systemlist('git log --format="%aN <%aE>"')
--     local unique_co_authors = {}
--     for _, author in ipairs(co_authors) do
--         if not unique_co_authors[author] then
--             unique_co_authors[author] = true
--             unique_co_authors[#unique_co_authors + 1] = author
--         end
--     end
--     return unique_co_authors
-- end
--
-- co_author.list = function()
--     local co_authors = co_author.generate()
--     local items = {}
--     for _, author in ipairs(co_authors) do
--         items[#items + 1] = author
--     end
--     if #co_authors > 0 then
--         vim.ui.select(items, { prompt = 'Select Co-Author' }, function(item, _)
--             if item ~= nil then
--                 local string = 'Co-authored-by: ' .. item
--                 local line, column = unpack(vim.api.nvim_win_get_cursor(0))
--
--                 vim.api.nvim_buf_set_lines(0, line, line, true, { string })
--                 vim.api.nvim_win_set_cursor(0, { line, column + #string })
--             end
--         end)
--     end
-- end
--
-- return co_author

local Show_author = {}

Show_author.generate = function()
	local co_authors = vim.fn.systemlist('git log --format="%aN <%aE>"')
	local unique_co_authors = {}
	for _, author in ipairs(co_authors) do
		if not unique_co_authors[author] then
			unique_co_authors[author] = true
			unique_co_authors[#unique_co_authors + 1] = author
		end
	end
	return unique_co_authors
	--
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
				local string = "show-authored-by: " .. item
				local filename = vim.fn.expand("%:t")
				local date = os.date("%Y-%m-%d")
				vim.fn.append(vim.fn.line("."), string.format(" */"))
				vim.fn.append(vim.fn.line("."), string.format(" * @filename - %s", filename))
				vim.fn.append(vim.fn.line("."), string.format(" * @author - %s", item))
				vim.fn.append(vim.fn.line("."), string.format(" * @date - %s", date))
				vim.fn.append(vim.fn.line("."), string.format("/**"))
			end
		end)
	end
end

return Show_author
