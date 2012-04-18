
-- mount.lua
-- simple mount addon


local band = bit.band
local tinsert = table.insert

local FLAG_GROUND = 0x1               -- Ground 
local FLAG_FLY = 0x2               -- Can fly 
local FLAG_FLOAT = 0x4               -- Floats above ground 
local FLAG_UNDERWATER = 0x8               -- Underwater 
local FLAG_CANJUMP = 0x10              -- Can jump (turtles cannot)

local SEA_LEGS = GetSpellInfo(73701)

local specialmounts = {
    VASHJIR = {
        [75207] = true, --Abyssal Seahorse
    },
    AHNQIRAJ = {
        [26054] = true,
        [25953] = true,
        [26056] = true,
        [26055] = true,
    }
}

local get_current_mount_type = function()
    if(IsIndoors()) then
        return
    elseif(UnitAura('player', SEA_LEGS)) then
        return 'VASHJIR'
    elseif(IsSwimming()) then
        return 'WATER'
    elseif(IsFlyableArea() and IsUsableSpell(60025)) then
        return 'AIR'
    elseif(IsUsableSpell(26054)) then
        return 'AHNQIRAJ'
    elseif(IsUsableSpell(43688)) then
        return 'GROUND'
    end
end

local is_empty = function(list)
    if not (list and next(list)) then
        return true
    end
end

local has_flag = function(a, b)
    return band(a, b) == b
end

local function mktypechk_by_flag(flag)
    return function(spellid, type_flag)
        return has_flag(type_flag, flag)
    end
end

local function mktypechk_by_list(lst)
    return function(spellid, type_flag)
        return lst[spellid]
    end
end

local statefilter = {}

statefilter.VASHJIR = function(spellid, mountType)
    return specialmounts.VASHJIR[spellid]
end

statefilter.AHNQIRAJ = function(spellid, mountType)
    return specialmounts.AHNQIRAJ[spellid]
--    if(specialmounts.AHNQIRAJ[spellid] or
--        statefilter.GROUND(spellid, mountType)) then
--        return true
--    end
end

statefilter.AIR = function(spellid, mountType)
    return has_flag(mountType, FLAG_FLY)
end

statefilter.WATER =function(spellid, mountType)
    if(has_flag(mountType, FLAG_UNDERWATER) and
        (not has_flag(mountType, FLAG_CANJUMP))
        ) then
        return true
    end
end

statefilter.GROUND = function(spellid, mountType)
    if( specialmounts.AHNQIRAJ[spellid]) then return false end
    if( has_flag(mountType, 0x10101)
        or (
            has_flag(mountType, FLAG_GROUND)
            and not has_flag(mountType, FLAG_FLY)
        )
        ) then
        return true
    end
end

local _mount_list = {}
local get_mount_list = function(state)
    local list = wipe(_mount_list)
    local chk_func = statefilter[state]

    if(chk_func) then
        for i = 1, GetNumCompanions'MOUNT' do
            local creatureID, creatureName, spellid, icon, issummoned,
            mountType = GetCompanionInfo('MOUNT', i)
            if(chk_func(spellid, mountType)) then
                tinsert(list, i)
            end
        end
    end

    if(not is_empty(list)) then
        return list
    end
end

SlashCmdList.LEAF_MOUNT = function()
    if(InCombatLockdown()) then return end
    if(IsMounted()) then return Dismount() end

    local state = get_current_mount_type()
    if(state) then
        local list = get_mount_list(state)

        if(list) then
            return CallCompanion('MOUNT', list[math.random(#list)])
        end
    end
end

SLASH_LEAF_MOUNT1 = '/mount'
SLASH_LEAF_MOUNT2 = '/leafmount'

