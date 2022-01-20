-- 简单的 色块密码门
local lock1 = false
local lock2 = false
local index1 = 1
local index2 = 2

local PicFileName = {'blocktemplates/f12.bmax', 'blocktemplates/f13.bmax', 'blocktemplates/f14.bmax',
                     'blocktemplates/f15.bmax', 'blocktemplates/f16.bmax', 'blocktemplates/f12.bmax'}

local function openDoor()
    if (lock1 and lock2) then
        -- 开门

        say('Good!')
        wait(2)

        setBlock(19583, 16, 19373, 0)
        setBlock(19583, 16, 19372, 0)
        setBlock(19583, 16, 19371, 0)

        setBlock(19583, 15, 19373, 0)
        setBlock(19583, 15, 19372, 0)
        setBlock(19583, 15, 19371, 0)

        setBlock(19583, 14, 19373, 0)
        setBlock(19583, 14, 19372, 0)
        setBlock(19583, 14, 19371, 0)

        setBlock(19583, 13, 19373, 0)
        setBlock(19583, 13, 19372, 0)
        setBlock(19583, 13, 19371, 0)

        local entity1 = GameLogic.EntityManager.GetEntity('ghost_lock1')
        local entity2 = GameLogic.EntityManager.GetEntity('ghost_lock2')
        local entity3 = GameLogic.EntityManager.GetEntity('ghost_lock3')
        entity1:Destroy()
        entity2:Destroy()
        entity3:Destroy()
    end
end

registerBroadcastEvent("onclickLock1", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        index1 = index1 + 1
        entity:SetModelFile(PicFileName[index1])
        if (index1 == 4) then
            lock1 = true
            openDoor()
        else
            if (index1 == 5) then
                index1 = 0
            end
            lock1 = false
        end
    end
end)

registerBroadcastEvent("onclickLock2", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        index2 = index2 + 1
        entity:SetModelFile(PicFileName[index2])
        if (index2 == 4) then
            lock2 = true
            openDoor()
        else
            if (index2 == 5) then
                index2 = 0
            end
            lock2 = false
        end
    end
end)
