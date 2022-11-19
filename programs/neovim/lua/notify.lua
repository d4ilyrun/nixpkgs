local notify = require("notify")

notify.setup ({
    background_colour = "FloatShadow",
    fps = 60,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 'TRACE',
    minimum_width = 20,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 2000
})


vim.notify = notify
