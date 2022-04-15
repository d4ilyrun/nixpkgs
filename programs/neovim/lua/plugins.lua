function load(plugin)
    dofile(path .. "/" .. plugin .. ".lua")
end

local plugins = {
    'galaxyline',
    'lsp', 'lspsaga',
    'cmp',
    'which-key',
    'treesitter',
}

for _,plugin in ipairs(plugins) do
    load(plugin)
end

