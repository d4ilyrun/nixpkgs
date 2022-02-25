-- COLORS

-- TODO: Find better colors
local colors = {
  bg = "#272b3b",
  fg = "#bbc2cf",
  fg_alt = "#5B6268",

  orange = "#da8548",
  violet = "#a9a1e1",

  red = "#f7768e";
  green = "#9ece6a";
  yellow = "#e0af68";
  blue = "#7aa2f7";
  magenta = "#bb9af7";
  cyan = "#7dcfff";
  white = "#a9b1d6";
}

-- CONDITIONS

local condition = {}

condition.buffer_not_empty = function()
    local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, vim.fn.line("$"), true)
    if buffer_lines[1] == "" and #buffer_lines == 1 then
        return false
    end
    return true
end

condition.check_git_workspace = function()
  local get_git_dir = require("galaxyline.providers.vcs").get_git_dir
  if vim.bo.buftype == "terminal" then
    return false
  end
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  -- if file is a symlinks
  if vim.fn.getftype(current_file) == "link" then
    local real_file = vim.fn.resolve(current_file)
    current_dir = vim.fn.fnamemodify(real_file, ":h")
  else
    current_dir = vim.fn.expand("%:p:h")
  end
  local result = get_git_dir(current_dir)
  if not result then
    return false
  end
  return true
end

condition.hide_in_width = function()
  local squeeze_width = vim.api.nvim_win_get_width(0) / 2
  if squeeze_width >= 50 then
    return true
  end
  return false
end

condition.check_active_lsp = function()
  local clients = vim.lsp.buf_get_clients()
  return next(clients) ~= nil
end


local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

gls.left[1] = {
  RainbowRed = {
    provider = function()
      return "▊ "
    end,
    highlight = { colors.blue, colors.bg },
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [""] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [""] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.red,
        t = colors.red,
      }
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
      return "  "
    end,
    highlight = { colors.red, colors.bg, "bold" },
  },
}
gls.left[3] = {
  FileSize = {
    provider = "FileSize",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg },
  },
}
gls.left[4] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = { require("galaxyline.providers.fileinfo").get_file_icon_color, colors.bg },
  },
}

gls.left[5] = {
  FileName = {
    provider = "FileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.magenta, colors.bg, "bold" },
  },
}

gls.left[6] = {
  LineInfo = {
    provider = "LineColumn",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.fg, colors.bg },
  },
}

gls.left[7] = {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.fg, colors.bg, "bold" },
  },
}

gls.left[8] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = { colors.red, colors.bg },
  },
}
gls.left[9] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = { colors.yellow, colors.bg },
  },
}

gls.left[10] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = { colors.cyan, colors.bg },
  },
}

gls.left[11] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    highlight = { colors.blue, colors.bg },
  },
}

gls.mid[1] = {
  ShowLspClient = {
    provider = "GetLspClient",
    condition = function()
      local tbl = { ["dashboard"] = true, [""] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = " LSP:",
    highlight = { colors.cyan, colors.bg, "bold" },
  },
}

gls.right[1] = {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.green, colors.bg, "bold" },
  },
}

gls.right[2] = {
  FileFormat = {
    provider = "FileFormat",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.green, colors.bg, "bold" },
  },
}

gls.right[3] = {
  GitIcon = {
    provider = function()
      return "  "
    end,
    condition = condition.check_git_workspace,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.violet, colors.bg, "bold" },
  },
}

gls.right[4] = {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    highlight = { colors.violet, colors.bg, "bold" },
  },
}

gls.right[5] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.green, colors.bg },
  },
}
gls.right[6] = {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = " 柳",
    highlight = { colors.orange, colors.bg },
  },
}
gls.right[7] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = "  ",
    highlight = { colors.red, colors.bg },
  },
}

gls.right[8] = {
  RainbowBlue = {
    provider = function()
      return " ▊"
    end,
    highlight = { colors.blue, colors.bg },
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.blue, colors.bg, "bold" },
  },
}

gls.short_line_left[2] = {
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg, "bold" },
  },
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = { colors.fg, colors.bg },
  },
}
