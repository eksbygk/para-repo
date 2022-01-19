local waterModelFile = "character/particles/fountain2/fountain2.x"
local effectsModelFile = "character/CC/05effect/waterbubble.x"
local smokeModelFile = "character/particles/smoke/smoke.x"

local waterheadName = "ghost_water_pipe"
local entityWaterPipe = GameLogic.EntityManager.GetEntity(waterheadName)
local entityCommode = GameLogic.EntityManager.GetEntity("ghost_commode")

-- 1. 马桶部分 --------------------------
-- 马桶冒烟
if (entityCommode) then
    local subEntity = GameLogic.EntityManager.GetEntity("ghost_smoke")
    if (not subEntity) then
        subEntity = entityCommode:CloneMe()
        subEntity:SetName("ghost_smoke")
        subEntity:SetModelFile(smokeModelFile)
        subEntity:SetOnClickEvent(nil)
        subEntity:SetCanDrag(false)
        subEntity:EnablePhysics(false)
        subEntity:SetScaling(0.4)
        subEntity:SetFacing(subEntity:GetFacing() + math.pi)
        local x, y, z = subEntity:GetPosition()
        subEntity:SetPosition(x, y + 0.6, z)
    end
end

-- 插件点，马桶，替换物体并销毁烟雾
registerBroadcastEvent("onMountChange4Commode", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local Atag = entity:GetStaticTag()
    if (entity and Atag ~= 'changed') then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local Btag = mountedEntity:GetStaticTag()
        if (mountedEntity and Btag and Btag ~= 'changed') then
            local CFileName = 'blocktemplates/' .. Btag .. '.bmax'
            entity:SetStaticTag('changed')
            mountedEntity:SetModelFile(CFileName)
            -- 静态属性！设为此格式！待收集物品之一
            mountedEntity:SetStaticTag('{"collect", 3}')

            local smokeEntity = GameLogic.EntityManager.GetEntity("ghost_smoke")
            print(smokeEntity)
            smokeEntity:Destroy()
        end
    end
end)

-- 2. 浴缸水流部分 --------------------------
-- 往浴缸注水
local function waterInjection(entityWaterPipe, type, scaling)
    if (not scaling) then
        scaling = 1
    end
    local subEntityWater = GameLogic.EntityManager.GetEntity(waterheadName .. "_water")
    local subEntityWaterBubble = GameLogic.EntityManager.GetEntity(waterheadName .. "_bubble")
    if (type == "open") then
        if (not subEntityWater) then
            subEntityWater = entityWaterPipe:CloneMe()
            subEntityWater:SetName(waterheadName .. "_water")
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
            subEntityWaterBubble = entityWaterPipe:CloneMe()
            subEntityWaterBubble:SetName(waterheadName .. "_bubble")
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

-- 点击，水龙头事件
registerBroadcastEvent("onclickWaterhead", function(msg)
    effectsModelFile = "character/CC/05effect/waterbubble.x"
    if (entityWaterPipe) then
        if (entityWaterPipe.tag == "open") then
            entityWaterPipe.tag = "close"
        else
            entityWaterPipe.tag = "open"
        end
        waterInjection(entityWaterPipe, entityWaterPipe.tag)
    end
end)

-- 点击，沐浴液1
registerBroadcastEvent("onclickChangeModel1", function(msg)
    effectsModelFile = "character/CC/05effect/star.x"
    waterInjection(entityWaterPipe, "close")
    waterInjection(entityWaterPipe, "open")
end)

-- 点击，沐浴液2
registerBroadcastEvent("onclickChangeModel2", function(msg)
    effectsModelFile = "character/v5/09effect/firewater/firewater.x"
    waterInjection(entityWaterPipe, "close")
    waterInjection(entityWaterPipe, "open", 0.06)
end)

-- 点击，洗手池 普通水流
registerBroadcastEvent("onclickCreateWater", function(msg)
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
                subEntity:SetModelFile(waterModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                subEntity:SetPosition(x, y - 2.5, z + 0.2)
            end
        else
            if (subEntity) then
                subEntity:Destroy()
            end
        end
    end
end)

-- 点击，衣篓的小幽灵，不通用！
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
