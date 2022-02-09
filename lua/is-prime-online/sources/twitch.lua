local Job = require("plenary.job")
local config = require("is-prime-online.config")

local M = {}

M.setup = function(opts)
	if M.verify_installed_command() and M.verify_authenticated_command() then
		M.start_interval(opts)
	end
end

M.verify_installed_command = function()
	if vim.fn.executable("twitch") == 0 then
		print(
			"The command 'twitch' not found. Read the is-prime-online README file for instructions."
		)
		return false
	end
	return true
end

M.verify_authenticated_command = function()
	local auth_test_cmd = "twitch api get streams -q user_login=thePrimeagen"
	local res = vim.fn.system(auth_test_cmd)

	if string.find(res, config.TWITCH_STATUS_IDENTIFIERS.auth, nil, true) then
		print(
			"Authentication failed. Read the is-prime-online README file for instructions."
		)
		return false
	end
	return true
end

M.start_interval = function(opts)
	local timer = vim.loop.new_timer()
	timer:start(
		1000,
		opts.refresh_interval_in_seconds * 1000,
		vim.schedule_wrap(function()
			M.check_status(opts)
		end)
	)
end

M.check_status = function(opts)
	local cmd = "twitch"
	local args = {
		"api",
		"get",
		"streams",
		"-q",
		"user_login=" .. opts.streamer_name,
	}

	Job
		:new({
			command = cmd,
			args = args,
			on_stdout = function(_, line)
				if
					string.find(
						line,
						config.TWITCH_STATUS_IDENTIFIERS.live,
						nil,
						true
					)
				then
					M.status_live(opts.callback_on_start)
				elseif
					string.find(
						line,
						config.TWITCH_STATUS_IDENTIFIERS.offline,
						nil,
						true
					)
				then
					M.status_offline()
				end
			end,
		})
		:start()

	return true
end

M.status_live = function(callback_on_start)
	-- Update global vim variable and call the lua callback
	IS_PRIME_ONLINE = true
	callback_on_start()
end

M.status_offline = function()
	IS_PRIME_ONLINE = false
end

return M
