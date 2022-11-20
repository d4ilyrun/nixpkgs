local telescope = require('telescope')
local actions = require('telescope.actions')
local previewers = require("telescope.previewers")

telescope.setup {
    defaults = {

        prompt_prefix = " ",
        selection_caret = "➜ ",
        path_display = { "smart" },
        color_devicons = true,

        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,

        file_ignore_patterns = { "node_modules", "build" },

        vimgrep_arguments = {
            "rg",
            "-L",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-s>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,

                ["<C-!>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["q"] = actions.close,
                ["?"] = actions.which_key,
            }
        },

        pickers = {
        },

        extensions = {
        }
    }
}
