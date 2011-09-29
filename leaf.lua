
local _NAME, _NS = ...
local oBindings = _G[_NAME]

local movement = {
    W = 'MOVEFORWARD',
    S = 'MOVEBACKWARD',
    A = 'STRAFELEFT',
    D = 'STRAFERIGHT',
}

local druidbase = {
    F1 = 'm|CLICK yDruidFrameBear:LeftButton',
    F2 = 'm|CLICK yDruidFrameSmart:LeftButton',
    F3 = 'm|CLICK yDruidFrameCat:LeftButton',
    F4 = 'm|CLICK yDruidFrameUMOUNT:LeftButton',
    F5 = 'm|CLICK yDruidFrameMoonkinOrTree:LeftButton',
}

if(select(2, UnitClass'player') == 'DRUID') then
    for i = 1, 3 do
        local _, talent_name = GetTalentTabInfo(i)
        oBindings:RegisterKeyBindings(talent_name, movement, druidbase)
    end
end

