-- 特殊物体变换
-- 留声机
registerBroadcastEvent("onMountChange4Phonograph", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local entityTag = entity:GetStaticTag()
    if (entity) then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local mountedTag = mountedEntity:GetStaticTag()
        if (mountedEntity and mountedTag == "a9") then
            local CFileName = 'blocktemplates/a9.bmax'
            entity:SetStaticTag('changed')
            mountedEntity:SetModelFile(CFileName)
            mountedEntity:SetOnClickEvent("onclickCollectItem")
            mountedEntity:SetStaticTag('{"collect", 16}')
            local x, y, z = entity:GetPosition()
            mountedEntity:SetPosition(x, y + 1, z)
        end
    end
end)

registerBroadcastEvent("onMountChange4Cat", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local entityTag = entity:GetStaticTag()
    if (entity) then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local mountedTag = mountedEntity:GetStaticTag()
        if (mountedEntity and mountedTag == "e26") then
            local CFileName = 'blocktemplates/e26.bmax'
            entity:SetStaticTag('changed')
            mountedEntity:SetModelFile(CFileName)
            mountedEntity:SetOnClickEvent("onclickCollectItem")
            mountedEntity:SetStaticTag('{"collect", 15}')
            local x, y, z = entity:GetPosition()
            mountedEntity:SetPosition(x, y + 1, z)
        end
    end
end)
