
local _NAME, _NS = ...
local oBindings = _G[_NAME]
local bindings = {}

bindings.base = {
    W = 'MOVEFORWARD',
    S = 'MOVEBACKWARD',
    A = 'STRAFELEFT',
    D = 'STRAFERIGHT',
}

bindings.druid = {
    F1 = 'm|/click yDruidFrameBear',
    F2 = 'm|/click yDruidFrameSmart',
    F3 = 'm|/click yDruidFrameCat',
    F4 = 'm|/click yDruidFrameUMOUNT',
    F5 = 'm|/click yDruidFrameMoonkinOrTree',
}

local loaded = false
local function load_bindings()
    local class = select(2, UnitClass'player')
    if(class == 'DRUID') then
        for i = 1, 3 do
            local _, talent = GetTalentTabInfo(i)
            if(talent) then
                oBindings:RegisterKeyBindings(talent_name, bindings.base, bindings.druid)
                loaded = true
            end
        end
    end
end

load_bindings()
if(loaded) then return end

local f = CreateFrame'Frame'
f:RegisterEvent'PLAYER_TALENT_UPDATE'
f:RegisterEvent'PLAYER_LOGIN'
f:RegisterEvent'PLAYER_ENTERING_WORLD'
f:RegisterEvent'VARIABLES_LOADED'
f:RegisterEvent'CHAT_MSG_CHANNEL_JOIN'
f:SetScript('OnEvent', function(self, event)
    pcall(load_bindings)

    if(loaded) then
        self:UnregisterAllEvents()
    end
end)

