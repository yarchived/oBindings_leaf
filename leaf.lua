
local _NAME, _NS = ...
local oBindings = _G[_NAME]

local movement = {
    W = 'MOVEFORWARD',
    S = 'MOVEBACKWARD',
    A = 'STRAFELEFT',
    D = 'STRAFERIGHT',
}

local druidbase = {
    F1 = 'm|/click yDruidFrameBear',
    F2 = 'm|/click yDruidFrameSmart',
    F3 = 'm|/click yDruidFrameCat',
    F4 = 'm|/click yDruidFrameUMOUNT',
    F5 = 'm|/click yDruidFrameMoonkinOrTree',
}

local LOAD = function()
    local KLASS = select(2, UnitClass'player')
    if(KLASS == 'DRUID') then
        for i = 1, 3 do
            local _, talent_name = GetTalentTabInfo(i)
            oBindings:RegisterKeyBindings(talent_name, movement, druidbase)
        end
    end
end

local f = CreateFrame'Frame'
f:RegisterEvent'PLAYER_LOGIN'
f:SetScript('OnEvent', function(self)
    pcall(LOAD)

    self:UnregisterAllEvents()
end)

