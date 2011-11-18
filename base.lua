
local _NAME, _NS = ...
_NS.CLASS = select(2, UnitClass'player')

local open_chat = function(key)
    return ('m|/run ChatFrame_OpenChat"/%s" '):format(key)
end

local base = {
    -- base movement
    W = 'MOVEFORWARD',
    S = 'MOVEBACKWARD',
    A = 'STRAFELEFT',
    D = 'STRAFERIGHT',

    F6 = [[m|/run local n,r=UnitName'target';n=r and(n..'-'..r)or n;return n and ChatFrame_OpenChat('/w '..n..' ')]],
    F7 = 'm|/inspect',
    F8 = 'FOCUSTARGET',
    F9 = open_chat'g',
    F10 = open_chat'5',
    F11 = open_chat's',
    F12 = [[m|/run local i,t,c=IsInInstance();c=(i and t=='pvp')and'/bg 'or(GetRealNumRaidMembers()>0)and'/ra 'and(GetRealNumPartyMembers()>0)and'/p 'or'/s ';ChatFrame_OpenChat(c)]],

    alt = {
        V = 'NAMEPLATES',
        F10 = open_chat'9',
        --F11 = open_chat'rw',
        F12 = open_chat'bg',
    },

    ctrl = {
        ['['] = 'TOGGLEGAMEMENU', -- esc is just too far away

        F9  = open_chat'o',
        F10 = open_chat'6',
        F11 = open_chat'rw',
        F12 = open_chat'ra',
    },

    shift = {
        F10 = open_chat'8',
        F11 = open_chat'y',
        F12 = open_chat'p',
    },
}

_NS.BASE = base

