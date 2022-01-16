local waterModelFile = "character/particles/fountain2/fountain2.x"
local effectsModelFile = "character/CC/05effect/waterbubble.x"

local msgGlobal = string
local entityGlobal = object

-- 往浴缸注水事件
local function waterInjection(msg, entity, type, scaling)
    if (not scaling) then
        scaling = 1
    end
    local subEntityWater = GameLogic.EntityManager.GetEntity(msg.name .. "_water")
    local subEntityWaterBubble = GameLogic.EntityManager.GetEntity(msg.name .. "_bubble")
    if (type == "open") then
        if (not subEntityWater) then
            subEntityWater = entity:CloneMe()
            subEntityWater:SetName(msg.name .. "_water")
            subEntityWater:SetModelFile(waterModelFile)
            subEntityWater:SetOnClickEvent(nil)
            subEntityWater:SetCanDrag(false)
            subEntityWater:EnablePhysics(false)
            subEntityWater:SetScaling(1)
            subEntityWater:SetFacing(subEntityWater:GetFacing() + math.pi)
            local x, y, z = subEntityWater:GetPosition()
            subEntityWater:SetPosition(x, y - 2.6, z - 0.2)
        end
        if (not subEntityWaterBubble) then
            subEntityWaterBubble = entity:CloneMe()
            subEntityWaterBubble:SetName(msg.name .. "_bubble")
            subEntityWaterBubble:SetModelFile(effectsModelFile)
            subEntityWaterBubble:SetOnClickEvent(nil)
            subEntityWaterBubble:SetCanDrag(false)
            subEntityWaterBubble:EnablePhysics(false)
            subEntityWaterBubble:SetScaling(scaling)
            subEntityWaterBubble:SetFacing(subEntityWater:GetFacing() + math.pi)
            local x, y, z = subEntityWaterBubble:GetPosition()
            subEntityWaterBubble:SetPosition(x, y - 1, z - 0.8)
        end
    else
        if (subEntityWater) then
            subEntityWater:Destroy()
        end
        if (subEntityWaterBubble) then
            subEntityWaterBubble:Destroy()
        end
    end
end

-- 水龙头点击事件
registerBroadcastEvent("onclickWaterhead", function(msg)
    effectsModelFile = "character/CC/05effect/waterbubble.x"
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    msgGlobal = msg
    entityGlobal = entity
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        waterInjection(msg, entity, entity.tag)
    end
end)

-- 沐浴液1
registerBroadcastEvent("onclickChangeModel1", function(msg)
    effectsModelFile = "character/CC/05effect/star.x"
    waterInjection(msgGlobal, entityGlobal, "close")
    waterInjection(msgGlobal, entityGlobal, "open")
end)

-- 沐浴液2
registerBroadcastEvent("onclickChangeModel2", function(msg)
    effectsModelFile = "character/v5/09effect/firewater/firewater.x"
    waterInjection(msgGlobal, entityGlobal, "close")
    waterInjection(msgGlobal, entityGlobal, "open", 0.06)
end)

registerBroadcastEvent("onclickEgg", function(msg)
    itemA:CloseWindow()
    itemA = window([[
    <div style="width: 70px;height: 70px;background: url(images/1.png);"></div>
 ]], "_lt", 10, 10, 70, 70)
end)

-- 衣篓小幽灵，不通用！
registerBroadcastEvent("onclickBasket", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entityBasket = GameLogic.EntityManager.GetEntity(msg.name)
    local entityGhost = GameLogic.EntityManager.GetEntity("ghost")
    if (entityBasket and entityGhost) then
        local facing = entityBasket:GetFacing()
        local dirX, dirZ = math.cos(facing), -math.sin(facing);
        if (entityBasket.tag == "open") then
            dirX, dirZ = -dirX, -dirZ;
            entityBasket.tag = "close"
        else
            entityBasket.tag = "open"
        end
        local x, y, z = entityGhost:GetPosition()
        for i = 0, 1, 0.1 do
            entityGhost:SetPosition(x, y + dirX * i, z + dirZ * i)
            wait(0.03)
        end
    end
end)
