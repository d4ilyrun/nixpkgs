-- home variable
user_home = os.getenv("HOME")

-- user preferences
user_likes = {
    -- apps
    terminal = "alacritty",
    editor = "nvim",
    code = "",
    web = "firefox",
    music = "",
    files = "ranger",
}

require("theme")
require("config")
