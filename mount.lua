
-- mount.lua
-- simple mount addon


local band = bit.band
local tinsert = table.insert

local FLAG_GROUND = 0x1               -- Ground 
local FLAG_FLY = 0x2               -- Can fly 
local FLAG_FLOAT = 0x4               -- Floats above ground 
local FLAG_UNDERWATER = 0x8               -- Underwater 
--local CANJUMP = 0x10              -- Can jump (turtles cannot)

local SEA_LEGS = GetSpellInfo(73701)

local special = {
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
    if(list and next(list)) then
        return false
    end
    return true
end

local in_the_list = function(item, list)
    if(item and list) then
        if(list[item]) then
            return true
        end
    else
        return true
    end
end

local has_flag = function(a, b)
    if(a and b) then
        return band(a, b) == b
    end
    return true
end

local _mount_list = {}
local get_mount_list = function(state)
    local list = wipe(_mount_list)
    local flag, special_lst
    if(state == 'VASHJIR') then
        -- flag = FLAG_UNDERWATER
        special_lst = special.VASHJIR
    elseif(state == 'AHNQIRAJ') then
        -- flag = FLAG_GROUND
        special_lst = special.AHNQIRAJ
    elseif(state == 'AIR') then
        flag = FLAG_FLY
    elseif(state == 'GROUND') then
        flag = FLAG_GROUND
    --elseif(state == WATER) then
    end

    if not(flag or special_lst) then return end

    for i = 1, GetNumCompanions'MOUNT' do
        local creatureID, creatureName, spellid, icon, issummoned,
            mountType = GetCompanionInfo('MOUNT', i)
        if(has_flag(mountType, flag) and in_the_list(spellid, special_lst)) then
            tinsert(list, i)
        end
    end

    if(not is_empty(list)) then
        return list
    end
end

local filtered_list = {}
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

