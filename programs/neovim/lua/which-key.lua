local which_key = require('which-key')

local setup = {
    window = {
        border = "rounded",
    },
}

which_key.setup(setup)

local opts = {
    prefix = "<leader>",
    nowait = true,
}

local keymaps = {
    f = {
        name = "Telescope", -- optional group name
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        o = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        p = { "<cmd>Telescope projections<cr>", "Projects" },
        b = { "<cmd>Telescope buffers<cr>", "Switch Buffer" },
        g = { "<cmd>Telescope live_grep<cr>", "Find Text in Workspace" },
        r = { "<cmd>Telescope resume<cr>", "Resume Last Search" },
        t = { "<cmd>TodoTelescope<cr>", "Find Todo's"},
    },

    g = {
        name = "git",

        h = {
            name = "Gitsigns",
            b = {"<cmd>Gitsigns blame_line<cr>", "Line Blame"},
            d = {"<cmd>Gitsigns diffthis<cr>", "Show Diff"},
        },

        d = {
            name = "Diffview",
            o = {"<cmd>DiffviewOpen<cr>", "Show Current Diffs"},
            f = {"<cmd>DiffviewFileHistory<cr>", "Show File History"},
            q = {"<cmd>DiffviewClose<cr>", "Close Diffs"},
        },

        a = {
            name = "Add",
            h = {"<cmd>Gitsigns stage_hunk<cr>", "Hunk"},
            b = {"<cmd>Gitsigns stage_buffer<cr>", "Buffer"},
        },

        r = {
            name = "reset",
            h = {"<cmd>Gitsigns reset_hunk<cr>", "Hunk"},
            b = {"<cmd>Gitsigns reset_buffer<cr>", "Buffer"},
        },

        ["<S-a>"] = {
            name = "Undo Add",
            h = {"<cmd>Gitsigns undo_stage_hunk<cr>", "Hunk"},
            b = {"<cmd>Gitsigns undo_stage_buffer<cr>", "Buffer"},
        },

        t = {
            name = "Trouble",
            r = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "Find Diagnostics"},
            d = {"<cmd>TodoTrouble<cr>", "Find Todo's"},
        },

        b = { "<cmd>Telescope git_branches<cr>", "Branches" },
        s = { "<cmd>Telescope git_status<cr>", "Status" },

        ["<M-cr>"] = { "<cmd>Lspsaga open_floaterm lazygit<cr>", "Lazygit" },
    },

    c = {
        name = "Colorscheme",
        s = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" } ,
    },

    t = {
        name = "Tabs/Buffers",
        t = { "<cmd>enew<cr>", "Open New Buffer" },
        d = { "<cmd>Bdelete<cr>", "Delete Current Buffer" },
        D = { "<cmd>bufdo bwipeout<cr>", "Delete All Buffers" },
        l = { "<cmd>Telescope buffers<cr>", "List Active Buffers" },
        c = { "<cmd>Centerpad<cr>", "Center Buffer" },
        s = {
            name = "Sort Buffers",
            d = { "<cmd>BufferLineSortByDirectory<cr>", "By Directory" },
            e = { "<cmd>BufferLineSortByExtension<cr>", "By Extension" },
            i = { "<cmd>require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>", "By Id" },
        }
    },

    v = {
        name = "Vimrc",
        r = { "<cmd>source $MYVIMRC<cr>", "Source/Reload" },
        e = { "<cmd>e $MYVIMRC<cr>", "Edit" },
    },

    d = {
        name = "dap (debugger)",

        b = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },

        -- Navigation
        n = { "<cmd>DapStepOver<cr>", "Step Over" },
        s = { "<cmd>DapStepInto<cr>", "Step Into" },
        o = { "<cmd>DapStepOut<cr>", "Step Out" },
        c = { "<cmd>DapContinue<cr>", "Continue" },
        u = { "<cmd>lua require('dap').up()<cr>", "Up" },
        d = { "<cmd>lua require('dap').down()<cr>", "Down" },

        -- Session
        r = { "<cmd>lua require('dap').run_last()<cr>", "Re-Run Last" },
        q = { "<cmd>lua require('dap').close()<cr>", "Close Session" },

        f = {
            name = "Telescope",
            c = { "<cmd>Telescope dap commands<cr>", "Commands" },
            b = { "<cmd>Telescope dap list_breakpoints<cr>", "Breakpoints" },
            v = { "<cmd>Telescope dap variables<cr>", "Variables" },
            f = { "<cmd>Telescope dap frames<cr>", "Frames" },
            g = { "<cmd>Telescope dap configurations<cr>", "Configurations" },
        },

        ["xa"] = { "<cmd>DapToggleRepl<cr>", "Toggle Repl" },
    },

    ["<F1>"] = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    ["?"] = { "<cmd>Telescope help_tags<cr>", "Vim docs" },
    ["<M-cr>"] = { "<cmd>Lspsaga open_floaterm<cr>", "Floating Terminal" },
    l = { "<cmd>!clang-format --style=file -i %<cr>", "Clang-format" },

}

which_key.register(keymaps, opts)
