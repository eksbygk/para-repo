registerBroadcastEvent("onclick_Door4Fridge", function(msg)
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
