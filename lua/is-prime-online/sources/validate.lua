local config = require("is-prime-online.config")

local function validate_source(source)
	local is_valid = false

	for _, real_source in ipairs(config.SOURCES) do
		if real_source.name == source then
			is_valid = true
			break
		end
	end

	return is_valid
end

return validate_source
