registerBroadcastEvent("desk_inner_click1", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local facing = entity:GetFacing()
        local dirX, dirZ = math.cos(facing), -math.sin(facing);
        if (entity.tag == "open") then
            dirX, dirZ = -dirX, -dirZ;
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local x, y, z = entity:GetPosition()
        for i = 0, 0.5, 0.1 do
            entity:SetPosition(x - dirZ * i, y, z - dirX * i)
            wait(0.01)
        end
    end
end)

registerBroadcastEvent("onclick_Door", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then

        local facing = entity:GetFacing()
        local dir = 1;
        if (entity.tag == "open") then
            entity.tag = "close"
            dir = -1;
        else
            entity.tag = "open"
        end
        for i = 0, 130, 10 do
            entity:SetFacing(facing + dir * i / 180 * math.pi)
            wait(0.01)
        end
    end
end)

registerBroadcastEvent("onclick_DoorRight", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then

        local facing = entity:GetFacing()
        local dir = -1;
        if (entity.tag == "open") then
            entity.tag = "close"
            dir = 1;
        else
            entity.tag = "open"
        end
        for i = 0, 130, 10 do
            entity:SetFacing(facing + dir * i / 180 * math.pi)
            wait(0.01)
        end
    end
end)
