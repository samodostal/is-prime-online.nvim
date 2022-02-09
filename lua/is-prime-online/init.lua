local M = {}

local config = require("is-prime-online.config")
local utils = require("is-prime-online.utils")
local validate_source = require("is-prime-online.sources.validate")

IS_PRIME_ONLINE = nil

M.setup = function(opts)
	opts = opts or {}
	opts = vim.tbl_deep_extend("force", config.DEFAULT_OPTS, opts)

	if not validate_source(opts.source) then
		print(
			"Source "
				.. opts.source
				.. " not found. You can use one of the following sources: "
		)
		utils.print_sources(config.SOURCES)
		return
	end

	if opts.source == "twitch" then
		require("is-prime-online.sources.twitch").setup(opts)
	end
end

M.status = function()
	return IS_PRIME_ONLINE
end

return M
