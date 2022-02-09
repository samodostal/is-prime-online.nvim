# is-prime-online.nvim

is-prime-online is a neovim plugin with a goal of notifying vim users that their favorite streamer is online

## Dependencies
 * `twitch-cli` installed
 * Twitch account
 * Neovim plugin 'nvim-lua/plenary.nvim'

## Install
#### Register application
1. Log in to a twitch developer console: https://dev.twitch.tv/console (You might need to verify your email)
2. Click 'Register your application'
3. Fill name: 'is-prime-online', OAuth Redirect URL: 'http://localhost', Category: 'Application Integration'
4. Create. Click on 'Manage' and save 'Client ID' and 'Client Secret' for later
#### Install `twitch-cli`
1. Install the package from: https://dev.twitch.tv/docs/cli
2. Run `twitch configure` and use saved 'Client ID' and 'Client Secret' to authenticate
### Plugin
* With vim.plug
```vim
Plug 'samodostal/is-prime-online.nvim'
Plug 'nvim-lua/plenary.nvim' "Dependency
```
* With packer.nvim
```lua
use {
  'samodostal/is-prime-online.nvim',
  requires = { 'nvim-lua/plenary.nvim' }
}
```

## Usage
* After installation, require plugin and run the setup function
```lua
require("is-prime-online").setup()

-- Or with the default values, 
require("is-prime-online").setup({
  source = "twitch",
  streamer_name = "thePrimeagen",
  refresh_interval_in_seconds = 60 * 5,
  callback_on_live = function()
  end,
})
```

There are 3 ways the plugin can be used:
- `require('is-prime-online').status()` returns the streamer status. Either: `true` for online, `false` for offline, and `nil` for syncing. You can integrate this function into statuslines. This function doesn't fetch the status, it just returns saved value from the last fetch.
- `callback_on_live` inside the setup function. This callback gets called when the streamer goes live.
- `vim.g:IS_PRIME_ONLINE` vim variable that is updated to the current streamer status.

## Example integration
This is an example integration with the `galaxyline.nvim` plugin. It uses the `.status()`.

```lua
IsPrimeOnline = {
  provider = function()
    local status = require("is-prime-online").status()
    if status == true then
      return "🟢 Prime is online!"
    elseif status == false then
      return "🔴 Prime is offline."
    else
      return "🟠 Status syncing..."
    end
  end,
  separator = " ",
  highlight = { colors.gray, colors.bg, "bold" },
  separator_highlight = { "NONE", colors.bg },
},
```
