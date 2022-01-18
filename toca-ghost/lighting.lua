-- 南瓜头闪烁特效 flicker
-- local flickerModelFile = "character/CC/05effect/glow.x"
-- local flickerModelFile = "character/CC/05effect/ghost.x"
local flickerModelFile = "character/CC/05effect/ray.x"
registerBroadcastEvent("onclickCreateFlicker", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_water")
        if (entity.tag == "open") then
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_water")
                subEntity:SetModelFile(flickerModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(0.1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                subEntity:SetPosition(x, y + 0.5, z)
            end
        else
            if (subEntity) then
                subEntity:Destroy()
            end
        end
    end
end)

-- 灯！
registerBroadcastEvent("click_light", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local bx, by, bz = entity:GetBlockPos()
        local id = getBlock(bx, by, bz)
        local lightblockId = 270 -- invisible light block 
        if (entity.tag == "on") then
            entity.tag = nil
            if (id == lightblockId) then
                setBlock(bx, by, bz, 0)
            end
        else
            if (not id or id == 0 or id == lightblockId) then
                entity.tag = "on"
                setBlock(bx, by, bz, lightblockId)
            end
        end
    end
end)

-- 灯 2.0
registerBroadcastEvent("click_light2", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local bx, by, bz = entity:GetBlockPos()
        local id = getBlock(bx, by, bz)
        local lightblockId = 270 -- invisible light block 
        if (entity.tag == "on") then
            entity.tag = nil
            if (id == lightblockId) then
                setBlock(bx, by + 1, bz, 0)
            end
        else
            if (not id or id == 0 or id == lightblockId) then
                entity.tag = "on"
                setBlock(bx, by + 1, bz, lightblockId)
            end
        end
    end
end)

-- 火焰
-- local fireModelFile = "character/CC/05effect/fire.x"
local fireModelFile = "character/particles/fire5/fire5.x"
registerBroadcastEvent("onclickFireplace", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_fire")

        if (entity.tag == "open") then
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_fire")
                subEntity:SetModelFile(fireModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                -- subEntity.SetScale(10)
                subEntity:SetPosition(x, y + 1, z)
            end
        else
            if (subEntity) then
                subEntity:Destroy()
            end
        end
    end
end)

-- 闪烁的氛围灯
local flag = true
registerBroadcastEvent("clickStopFlicker", function(msg)
    flag = false
    setBlock(19573, 7, 19373, 270)
end)

while (flag) do
    setBlock(19573, 7, 19373, 270)
    wait(0.1)
    setBlock(19573, 7, 19373, 0)
    wait(0.1)
    setBlock(19573, 7, 19373, 270)
    wait(0.1)
    setBlock(19573, 7, 19373, 0)
    wait(0.1)
    setBlock(19573, 7, 19373, 270)
    wait(0.5)
    setBlock(19573, 7, 19373, 0)
    wait(0.5)
end
