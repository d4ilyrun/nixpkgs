local function load(plugin)
    dofile(path .. "/lsp/" .. plugin .. ".lua")
end

local plugins = {
    'lspsaga',
    'lsp-installer',
}

for _,plugin in ipairs(plugins) do
    load(plugin)
end

