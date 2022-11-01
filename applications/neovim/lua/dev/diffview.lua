-- Lua
local actions = require("diffview.actions")

require("diffview").setup({
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = true,
  use_icons = true,

  icons = {
    folder_closed = "",
    folder_open = "",
  },

  signs = {
    fold_closed = "",
    fold_open = "",
  },

  file_panel = {
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = {
      position = "left",
      width = 25,
    },
  },

  file_history_panel = {
    log_options = {   -- See ':h diffview-config-log_options'
      single_file = {
        diff_merges = "combined",
      },
      multi_file = {
        diff_merges = "first-parent",
      },
    },
    win_config = {
      position = "bottom",
      height = 13,
    },
  },

  -- See ':h diffview-config-hooks'
  hooks = {},

  -- I only let the one I'm succptible to forget + the one I added
  keymaps = {
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      ["<tab>"]      = actions.select_next_entry, -- Open the diff for the next file
      ["<s-tab>"]    = actions.select_prev_entry, -- Open the diff for the previous file
      ["gf"]         = actions.goto_file,         -- Open the file in a new split in the previous tabpage
      ["<C-w><C-f>"] = actions.goto_file_split,   -- Open the file in a new split
      ["<C-w>gf"]    = actions.goto_file_tab,     -- Open the file in a new tabpage

      -- diffget
      ["do"] = actions.diffget('ours'),
      ["dt"] = actions.diffget('theirs'),
      ["dl"] = actions.diffget('local'),
      ["db"] = actions.diffget('base'),

      -- switch between diffs
      ["dn"] = actions.next_conflict,
      ["dp"] = actions.prev_conflict,
    },
    file_panel = {
      ["-"]             = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
      ["S"]             = actions.stage_all,          -- Stage all entries.
      ["U"]             = actions.unstage_all,        -- Unstage all entries.
      ["X"]             = actions.restore_entry,      -- Restore entry to the state on the left side.
      ["R"]             = actions.refresh_files,      -- Update stats and entries in the file list.
      ["L"]             = actions.open_commit_log,    -- Open the commit log panel.
      ["<c-u>"]         = actions.scroll_view(-0.25), -- Scroll the view up
      ["<c-d>"]         = actions.scroll_view(0.25),  -- Scroll the view down
      ["i"]             = actions.listing_style,        -- Toggle between 'list' and 'tree' views
      ["f"]             = actions.toggle_flatten_dirs,  -- Flatten empty subdirectories in tree listing style.
    },
    file_history_panel = {
      ["g!"]            = actions.options,          -- Open the option panel
      ["<C-A-d>"]       = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
      ["y"]             = actions.copy_hash,        -- Copy the commit hash of the entry under the cursor
      ["L"]             = actions.open_commit_log,
      ["zR"]            = actions.open_all_folds,
      ["zM"]            = actions.close_all_folds,
      ["<c-u>"]         = actions.scroll_view(-0.25),
      ["<c-d>"]         = actions.scroll_view(0.25),
    },
    option_panel = {
      ["<tab>"] = actions.select_entry,
      ["q"]     = actions.close,
    },
  },
})

-- Set the diff area 'filler' character
vim.cmd[[set fillchars+=diff:/]]
