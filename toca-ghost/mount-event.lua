-- 通用物体变换 A+B=C
-- 配置：A插件点事件，B静态属性（新bmax文件名）
registerBroadcastEvent("onMountMerge", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local Atag = entity:GetStaticTag()
    if (entity and Atag ~= 'merged') then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local Btag = mountedEntity:GetStaticTag()
        if (mountedEntity and Btag and Btag ~= 'merged') then
            local CFileName = 'blocktemplates/' .. Btag .. '.bmax'
            entity:Destroy()
            mountedEntity:SetModelFile(CFileName)
            mountedEntity:SetStaticTag('merged')
            mountedEntity:FallDown()
        end
    end
end)

-- 物体变换 A+B = A+C (B换C)
-- 配置：A插件点事件，B静态属性（新bmax文件名）
registerBroadcastEvent("onMountChange", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local Atag = entity:GetStaticTag()
    if (entity and Atag ~= 'changed') then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local Btag = mountedEntity:GetStaticTag()
        if (mountedEntity and Btag and Btag ~= 'changed') then
            local CFileName = 'blocktemplates/' .. Btag .. '.bmax'
            entity:SetStaticTag('changed')
            mountedEntity:SetModelFile(CFileName)
            mountedEntity:SetStaticTag('changed')
        end
    end
end)
