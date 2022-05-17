-- KEYBINDS

-- requirements
local awful = require("awful")
local misc = require("misc")

local win = "Mod4"
local shift  = "Shift"
local ctrl = "Control"
local alt = "Mod1"

-- configurations

-- launchers
-- launchers
awful.keyboard.append_global_keybindings({
	awful.key({ win }, "Return", function()
		awful.spawn(user_likes.term)
	end,
    { description = "open terminal", group = "launcher" }),

	awful.key({ win }, "s", function()
		awful.spawn(user_likes.music)
	end,
    { description = "launch music client", group = "launcher" }),

	awful.key({ win }, "b", function()
		awful.spawn.with_shell(user_likes.web)
	end,
    { description = "open web browser", group = "launcher" }),

	awful.key({ win }, "e", function()
        awful.spawn(misc.rofiCommand)
	end,
    { description = "open rofi", group = "launcher" }),
})

-- media keys
awful.keyboard.append_global_keybindings({

    awful.key({}, "XF86MonBrightnessUp",  function()
        awful.spawn("light -A 5", false)
    end,
    {description = "increase brightness", group = "control"}),


    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn("light -U 5", false)
    end,
    {description = "decrease brightness", group = "control"}),


    awful.key({}, "Print", function()
        awful.util.spawn("exec --no-startup-id maim | xclip -selection clipboard -t image/png", false)
    end,
    {description = "screenshot", group = "control"}),


    awful.key({}, "XF86AudioRaiseVolume",
            function() awful.spawn("amixer -D pulse set Master 5%+", false)
    end,
    {description = "increase volume", group = "control"}),


    awful.key({}, "XF86AudioLowerVolume",
            function() awful.spawn("amixer -D pulse set Master 5%-", false)
    end,
    {description = "decrease volume", group = "control"}),


    awful.key({}, "XF86AudioMute", function()
        awful.spawn("amixer -D pulse set Master 1+ toggle", false)
    end,
    {description = "mute volume", group = "control"}),
})
