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

				local current_line = vim.fn.line(".")
				vim.fn.append(current_line, string.format("--"))
				vim.fn.append(current_line + 1, string.format("-- @filename - %s", filename))
				vim.fn.append(current_line + 2, string.format("-- @author - %s", item))
				vim.fn.append(current_line + 3, string.format("-- @date - %s", date))
				vim.fn.append(current_line + 4, string.format("--"))
			end
		end)
	end
end

return Show_author
