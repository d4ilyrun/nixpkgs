function load(plugin)
    dofile(path .. "/" .. plugin .. ".lua")
end

local plugins = {
    'bufferline',
    'cmp',
    'galaxyline/evilline',
    'gitsigns',
    'glow',
    'indent-blankline',
    'null-ls',
    'nvim-tree',
    'startup',
    'telescope',
    'todo',
    'treesitter',
    'trouble',
    'which-key',
}

local subdirs = {
    'lsp/init',
    'dev/init',
}

for _,plugin in ipairs(plugins) do
    load(plugin)
end

for _,subdir in ipairs(subdirs) do
    load(subdir)
end
