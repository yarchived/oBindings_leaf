
local _NAME, _NS = ...
local oBindings = _G[_NAME]

_NS:RegisterGlobalBindings(_NS.globalbindings.BASE, _NS.globalbindings[_NS.CLASS])

oBindings:RegisterKeyBindings(_NAME, _NS.ybindings.BASE, _NS.ybindings[_NS.CLASS] or {})
oBindings:UnregisterEvent'ACTIVE_TALENT_GROUP_CHANGED'
function oBindings:PLAYER_TALENT_UPDATE(event)
    self:LoadBindings(_NAME)
    return event and self:UnregisterEvent(event)
end

