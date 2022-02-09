local M = {}

M.print_sources = function(sources)
	local str = ""
	for _, source in ipairs(sources) do
		str = str .. source.name
		if source ~= sources[#sources] then
			str = str .. ", "
		end
	end
	print(str)
end

return M
