function load(plugin)
    dofile(path .. "/" .. plugin .. ".lua")
end

local plugins = {
    'galaxyline',
    'lsp',
    'cmp',
    'which-key',
}

for _,plugin in ipairs(plugins) do
    load(plugin)
end

