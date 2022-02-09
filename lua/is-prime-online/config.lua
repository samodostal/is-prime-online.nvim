local M = {}

M.SOURCES = {
	{ name = "twitch" },
}

M.TWITCH_STATUS_IDENTIFIERS = {
	auth = '"status": 401',
	live = '"type": "live"',
	offline = '"data": [],',
}

M.DEFAULT_OPTS = {
	source = "twitch",
	streamer_name = "thePrimeagen",
	refresh_interval_in_seconds = 60,
	callback_on_start = function()
		print("Prime started his stream!")
	end,
	-- open_stream_on_start = true,
}

return M
