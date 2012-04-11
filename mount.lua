
-- mount.lua
-- takes advantage of LibMounts to write a simple random mount addon
-- LibMounts
-- http://www.wowace.com/addons/libmounts-1-0/

local LibMounts = LibStub 'LibMounts-1.0'

local num_comps = 0
local spellid2compid = {}
local update_comp = function()
    num_comps = GetNumCompanions'MOUNT'
    wipe(spellid2compid)
    for i = 1, num_comps do
        local _, _, id = GetCompanionInfo('MOUNT', i)
        spellid2compid[id] = i
    end
end

local is_empty = function(list)
    if(list and next(list)) then
        return false
    end
    return true
end

local _mount_list = {}
local get_mount_list = function(state)
    local list = LibMounts:GetMountList(state, wipe(_mount_list))
    if(not is_empty(list)) then
        return list
    end
end

local filtered_list = {}
SlashCmdList.LEAF_MOUNT = function()
    if(InCombatLockdown()) then return end
    if(IsMounted()) then return Dismount() end

    if(GetNumCompanions'MOUNT' ~= num_comps) then
        update_comp()
    end

    local statePrimary, stateSecondary, stateTertiary = LibMounts:GetCurrentMountType()
    local mntlist = get_mount_list(statePrimary) 
        or get_mount_list(stateSecondary)
        or get_mount_list(stateTertiary)

    if(not mntlist) then return end
    local list = wipe(filtered_list)
    for id in next, mntlist do
        if(spellid2compid[id]) then
            table.insert(list, id)
        end
    end
    local spellid = list[math.random(#list)]
    return CallCompanion('MOUNT', spellid2compid[spellid])
end

SLASH_LEAF_MOUNT1 = '/mount'
SLASH_LEAF_MOUNT2 = '/leafmount'

