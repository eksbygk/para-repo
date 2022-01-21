-- 南瓜头闪烁特效 flicker
local flickerModelFile = "character/CC/05effect/star.x"
registerBroadcastEvent("onclickCreateFlicker", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_flicker")
        if (entity.tag == "open") then
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_flicker")
                subEntity:SetModelFile(flickerModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(0.1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                subEntity:SetPosition(x, y + 0.5, z)
                setBlock(subEntity.bx, subEntity.by, subEntity.bz, 270)
            end
        else
            if (subEntity) then
                subEntity:Destroy()
                setBlock(subEntity.bx, subEntity.by, subEntity.bz, 0)
            end
        end
    end
end)

-- 闪烁的氛围灯 故障的灯
local flag = true
local function flicker()
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
end

registerBroadcastEvent("clickStopFlicker", function(msg)
    if (flag) then
        flag = false
        flicker()
        wait(0.5)
        setBlock(19573, 7, 19373, 0)
        setBlock(19573, 7, 19373, 270)
    else
        flag = true
        flicker()
    end
end)
flicker(flag)

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
