
local _NAME, _NS = ...
if(_NS.CLASS ~= 'DRUID') then return end

local spells = {
    Aquatic         = 1066,
    Flight          = 33943,
    SwiftFlight     = 40120,
    Travel          = 783,
    Bear            = 5487,
    Cat             = 768,
    Tree            = 33891,
    Moonkin         = 62795,
}
for k, v in next, spells do
    spells[k] = GetSpellInfo(v)
end

_NS.ybindings.DRUID = {
    F1 = 'm|/cast ' ..spells.Bear,
    --F2 = 'm|/click yDruidFrameSmart',
    F2 = 'm|/stopmacro [flying,combat]' ..
        '\n/cast [swimming]!'..spells.Aquatic ..
        ';[combat]!' ..spells.Travel ..
        ';[flyable,nocombat]!'.. spells.SwiftFlight ..
        '\n/stopmacro [combat][mounted][flyable]' ..
        '\n/cancelform' ..
        '\n/mount' ..
        '\n/cast '..spells.Travel,
    F3 = 'm|/cast ' ..spells.Cat,
    F4 = 'm|/dismount\n/cancelform',
    F5 = 'm|/cast '..spells.Moonkin..'\n/cast '..spells.Tree,
}

_NS.globalbindings.DRUID = {
    ctrl = {
        [4] = 's|48438',
    },
}
