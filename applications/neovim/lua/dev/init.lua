local function load(plugin)
    dofile(path .. "/dev/" .. plugin .. ".lua")
end

local plugins = {
    'cmake',
    'dap',
    'dapui',
    -- 'diffview',
    'neotest',
}

for _,plugin in ipairs(plugins) do
    load(plugin)
end

