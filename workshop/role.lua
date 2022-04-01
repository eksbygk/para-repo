registerBroadcastEvent("onclick_DoorAxisZ", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        broadcast("playEntityClickSound", entity:GetModelFile())
        local dir = 1;
        if (entity.tag == "open") then
            entity.tag = "close"
            dir = -1;
        else
            entity.tag = "open"
        end
        local roll = entity:GetRoll()
        for i = 0, 90, 10 do
            entity:SetRoll(roll + dir * i / 180 * math.pi)
            wait(0.01)
        end
    end
end)

registerBroadcastEvent("onclick_DoorAxisX", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        broadcast("playEntityClickSound", entity:GetModelFile())
        local dir = -1;
        if (entity.tag == "open") then
            entity.tag = "close"
            dir = 1;
        else
            entity.tag = "open"
        end
        local pitch = entity:GetPitch()
        for i = 0, 90, 10 do
            entity:SetPitch(pitch + dir * i / 180 * math.pi)
            wait(0.01)
        end
    end
end)
