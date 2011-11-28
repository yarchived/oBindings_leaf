

if(select(2, UnitClass'player') ~= 'DRUID') then return end

local _NAME, _NS = ...
local i = 0
local function name()
    i = i + 1
    return _NAME..'Button'..i
end

local wildgrowth = CreateFrame('Button', name(), UIParent, 'SecureActionButtonTemplate')
wildgrowth:SetAttribute('type', 'spell')
wildgrowth:SetAttribute('spell', 48438)
SetOverrideBindingClick(wildgrowth, true, 'BUTTON5', wildgrowth:GetName())


