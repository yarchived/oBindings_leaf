
local _NAME, _NS = ...

local _BINDINGS = {}
local _BUTTONS = {}

local _types = {
    s = 'spell',
    m = 'macro',
    i = 'item',
}

local createButton = function(key, mod)
    if(mod) then
        key = mod..'-'..key
    else
        key = tostring(key)
    end

    if(_BUTTONS[key]) then
        return _BUTTONS[key]
    end

    local button = CreateFrame('Button', _NAME..'-gkb-'..key, UIParent, 'SecureActionButtonTemplate')
    _BUTTONS[key] = button
    return button
end

local bind = function(key, action, mod)
    -- maybe profile swapping?
    local button = createButton(key, mod)
    local ty, action = string.split('|', action)
    ty = _types[ty] or ty

    button:SetAttribute('type', ty)
    if(action) then
        ty = (ty == 'macro' and 'macrotext' or ty)
        button:SetAttribute(ty, action)
    end

    key = tonumber(key) or key
    if(type(key) == 'number') then
        key = 'BUTTON' .. key
    end
    if(mod) then
        key = (mod..'-'..key):upper()
    end
    SetOverrideBindingClick(button, true, key, button:GetName())
    --print('SetOverrideBindingClick', button:GetName(), key)
end

local bind_keys = function()
    for key, action in next, _BINDINGS do
        if(type(action) == 'table') then
            for modkey, modaction in next, action do
                bind(modkey, modaction, key)
            end
        else
            bind(key, action)
        end
    end
end

function _NS:RegisterGlobalBindings(...)
    local bindings = _BINDINGS

    for i = 1, select('#', ...) do
        local tbl = select(i, ...)
        if(tbl) then
            for key, action in next, tbl do
                if(type(action) == 'table') then
                    if(not bindings[key]) then bindings[key] = {} end
                    for modkey, modaction in next, action do
                        bindings[key][modkey] = modaction
                    end
                else
                    bindings[key] = action
                end
            end
        end
    end

    bind_keys()
end

