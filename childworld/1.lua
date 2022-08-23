registerBroadcastEvent("getPosition", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        local x, y, z = entity:GetPosition()
        print(x, y, z)
        tip(x, y, z)
    end
end)
