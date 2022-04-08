-- onMountIdentify
-- identifyItems结构 鉴定物品->变换后的物品
local identifyItems = {
    ["blocktemplates/j8.bmax"] = {
        filename = "blocktemplates/j11.bmax"
    }
}

registerBroadcastEvent("onMountIdentify", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        if identifyItems[mountedEntity.filename] then
            wait(1)
            entity:Say("鉴定完毕！")
            mountedEntity:SetModelFile(identifyItems[mountedEntity.filename].filename)
            local x, y, z = mountedEntity:GetPosition()
            mountedEntity:SetPosition(x - 2, y, z)
        end
    end
end)
