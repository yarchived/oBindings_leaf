
local _NAME, _NS = ...
local oBindings = _G[_NAME]

oBindings:RegisterKeyBindings(_NAME, _NS.BASE, _NS[_NS.CLASS])

oBindings:UnregisterEvent'ACTIVE_TALENT_GROUP_CHANGED'
function oBindings:PLAYER_TALENT_UPDATE(event)
    self:LoadBindings(_NAME)
    return event and self:UnregisterEvent(event)
end

