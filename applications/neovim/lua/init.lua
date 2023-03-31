function load(plugin)
    dofile(path .. "/" .. plugin .. ".lua")
end

local plugins = {
    'bufferline',
    'cmp',
    'fidget',
    'gitsigns',
    'glow',
    'indent-blankline',
    'lualine',
    'notify',
    'null-ls',
    'nvim-tree',
    'projections',
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
