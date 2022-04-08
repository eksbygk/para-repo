registerBroadcastEvent("onMountEvent", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity) then

    end
end)

-- API

registerBroadcastEvent("onMountEvent", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity) then
        mountedEntity = entity:CloneMe()
        mountedEntity:SetName()
        mountedEntity:SetModelFile()
        mountedEntity:SetOnClickEvent(nil)
        mountedEntity:SetOnMountEvent(nil)
        mountedEntity:SetCanDrag(false)
        mountedEntity:EnablePhysics(false)
        mountedEntity:SetScaling(1)
        mountedEntity:SetFacing(mountedEntity:GetFacing() + math.pi)
        mountedEntity:SetFacing(95 * 3.14 / 180)
        mountedEntity:SetFacing(95 * math.pi / 180)
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x, y - 2.6, z - 0.2)
    end
end)
