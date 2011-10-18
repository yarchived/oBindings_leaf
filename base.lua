
local _NAME, _NS = ...
_NS.CLASS = select(2, UnitClass'player')

local base = {
    -- base movement
    W = 'MOVEFORWARD',
    S = 'MOVEBACKWARD',
    A = 'STRAFELEFT',
    D = 'STRAFERIGHT',

    F6 = [[m|/run local n,r=UnitName'target';n=r and(n..'-'..r)or n;return n and ChatFrame_OpenChat('/w '..n..' ')]],
    F7 = 'm|/inspect',
    F8 = 'FOCUSTARGET',
    F9 = "m|/run ChatFrame_OpenChat'/g '",
    F10 = "m|/run ChatFrame_OpenChat'/5 '",
    F11 = "m|/run ChatFrame_OpenChat'/s '",
    F12 = [[m|/run local i,t,c=IsInInstance();c=(i and t=='pvp')and'/bg 'or(GetRealNumRaidMembers()>0)and'/ra 'and(GetRealNumPartyMembers()>0)and'/p 'or'/s ';ChatFrame_OpenChat(c)]],

    alt = {
        V = 'NAMEPLATES',
        F10 = "m|/run ChatFrame_OpenChat'/9 '",
        --F11 = "m|/run ChatFrame_OpenChat'/rw '",
        F12 = "m|/run ChatFrame_OpenChat'/bg '",
    },

    ctrl = {
        F9 = "m|/run ChatFrame_OpenChat'/o '",
        F10 = "m|/run ChatFrame_OpenChat'/6 '",
        F11 = "m|/run ChatFrame_OpenChat'/rw '",
        F12 = "m|/run ChatFrame_OpenChat'/ra '",
    },

    shift = {
        F10 = "m|/run ChatFrame_OpenChat'/8 '",
        F11 = "m|/run ChatFrame_OpenChat'/y '",
        F12 = "m|/run ChatFrame_OpenChat'/p '",
    },
}

_NS.BASE = base

