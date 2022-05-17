local flowerTable = {
    ["blocktemplates/z5.bmax"] = {
        next = "blocktemplates/z24.bmax"
    },
    ["blocktemplates/z24.bmax"] = {
        next = "blocktemplates/z7.bmax"
    },
    ["blocktemplates/z7.bmax"] = {
        next = "blocktemplates/z6.bmax",
        spec = "最终形态"
    }
}

-- Mount
registerBroadcastEvent("onMountFlower", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        local filename = entity:GetModelFile()
        local mountedFile = mountedEntity:GetModelFile()
        if filename == mountedFile and flowerTable[filename] then
            local nextFlower = flowerTable[filename]
            entity:SetModelFile(nextFlower.next)
            if nextFlower.spec then
                entity.tag = nextFlower.spec
            end
            mountedEntity:Destroy()
            broadcast("gardening1", "")
        end
    end
end)
