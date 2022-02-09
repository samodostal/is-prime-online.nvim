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
	refresh_interval_in_seconds = 60 * 5,
	callback_on_live = function() end,
	-- open_stream_on_start = true,
}

return M
