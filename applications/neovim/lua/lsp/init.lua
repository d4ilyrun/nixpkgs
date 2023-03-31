local function load(plugin)
    dofile(path .. "/lsp/" .. plugin .. ".lua")
end

local plugins = {
    'lspsaga',
    'mason',
}

for _,plugin in ipairs(plugins) do
    load(plugin)
end

