registerBroadcastEvent("onMountElder", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (msg.mountname == "" and entity:HasCustomGeosets()) then
            local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
            if (mountedEntity) then
                -- take the entity in left hand
                local boneName = "L_Hand"
                local oldEntity = entity:GetLinkChildAtBone(boneName)
                if (oldEntity) then
                    mountedEntity:FallDown()
                else
                    local x, y, z = entity:GetPosition()
                    local aabb = mountedEntity:GetInnerObjectAABB()
                    local dx, dy, dz = aabb:GetExtendValues()
                    local pos = {math.max(math.sqrt(dx ^ 2, dz ^ 2) - 0.2, 0), -0.1,
                                 -math.max(math.sqrt(dx ^ 2 + dz ^ 2) - 0.2, 0)}
                    mountedEntity:LinkTo(entity, boneName, pos);
                end
                -- my code begin
                -- checkFood(entity, mountedEntity)
                -- my code end
            end
        end
    end
end)
