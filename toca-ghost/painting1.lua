-- 1张画
-- 挂画机关
local painting2 = false
local batModelFile = "blocktemplates/a5.bmax"

registerBroadcastEvent("onMountToImg", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local itemName = mountedEntity:GetName()
        mountedEntity:SetFacing(90 * 3.14 / 180);
        if (itemName == "ghostImg2") then
            painting2 = true
        end

        if (painting2) then
            local newEntity = GameLogic.EntityManager.GetEntity("ghost_bat")
            newEntity = mountedEntity:CloneMe()
            newEntity:SetName("ghost_bat")
            newEntity:SetModelFile(batModelFile)
            newEntity:SetOnClickEvent("onclickCollectItem")
            newEntity:SetStaticTag([[{"collect", 4}]])
            newEntity:SetCanDrag(false)
            newEntity:EnablePhysics(false)
            newEntity:SetScaling(1)
            newEntity:SetPosition(20401.76, -126, 20176)
        end
    end
end)

-- 2张画
-- 挂画机关
local painting1 = false
local painting2 = false
local batModelFile = "blocktemplates/a5.bmax"

registerBroadcastEvent("onMountToImg", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local itemName = mountedEntity:GetName()
        mountedEntity:SetFacing(90 * 3.14 / 180);
        if (itemName == "ghostImg1") then
            painting1 = true
        end
        if (itemName == "ghostImg2") then
            painting2 = true
        end

        if (painting1 and painting2) then
            local newEntity = GameLogic.EntityManager.GetEntity("ghost_bat")
            newEntity = mountedEntity:CloneMe()
            newEntity:SetName("ghost_bat")
            newEntity:SetModelFile(batModelFile)
            newEntity:SetOnClickEvent("onclickCollectItem")
            newEntity:SetStaticTag([[{"collect", 4}]])
            newEntity:SetCanDrag(false)
            newEntity:EnablePhysics(false)
            newEntity:SetScaling(1)
            newEntity:SetPosition(20401.76, -126, 20176)
            wait(0.5)
            newEntity:FallDown()
        end
    end
end)
