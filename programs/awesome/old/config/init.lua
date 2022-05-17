local function require_config(name)
    require("config." .. name)
end

local configs = {
    "keys",
}

for _,name in ipairs(configs) do
    require_config(name)
end
