local Workspace = require("projections.workspace")
local Session = require("projections.session")

require("projections").setup({
    patterns = { ".git", "flake.nix" },
    workspaces = {                             -- Default workspaces to search for
        "~/Documents/Projects",
        "~/Documents/School",
        "~/Documents/Work",
        "~/.config",
    },

    store_hooks = {
        pre = nil,
        post = function()
            local session_info = Session.info(vim.loop.cwd())
            vim.notify("Session stored: " .. session_info.project.name, "INFO")
        end
    },

    restore_hooks = {
        pre = function()
            local session_info = Session.info(vim.loop.cwd())
            vim.notify("Loading existing session: " .. session_info.project.name, "INFO")
        end,

        post = function()
            local session_info = Session.info(vim.loop.cwd())
            vim.notify("Existing session deleted: " .. session_info.project.name, "INFO")
            vim.cmd.source '$MYVIMRC'
        end
    }
})

-- Add to telescope
require('telescope').load_extension('projections')

-- Auto Session/Workspace commands

-- If vim was started with arguments, do nothing
-- If in some project's root, attempt to restore's that project's session
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     callback = function()
--         if vim.fn.argc() ~= 0 then return end
--         local session_info = Session.info(vim.loop.cwd())
--         if session_info ~= nil then
--             vim.notify(vim.loop.cwd(), "INFO")
--             Session.restore(vim.loop.cwd())
--         end
--     end,
--     desc = "Restore last session automatically"
-- })

vim.api.nvim_create_user_command("StoreProjectSession", function()
    Session.store(vim.loop.cwd())
end, {})

vim.api.nvim_create_user_command("RestoreProjectSession", function()
    Session.restore(vim.loop.cwd())
end, {})

vim.api.nvim_create_user_command("AddWorkspace", function()
    Workspace.add(vim.loop.cwd())
end, {})
