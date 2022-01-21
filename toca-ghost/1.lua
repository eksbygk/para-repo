-- 特殊物体变换
-- 收音机换bgm
registerBroadcastEvent("onMountRepalceBgm", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        if (mountedEntity and mountedEntity:GetStaticTag() == "bgm") then
            playMusic()
            playMusic("bgm2.mp3")
        end
    end
end)

-- 切菜 菜刀拖拽结束事件
registerBroadcastEvent("onEndDragKnife", function(msg)
    msg = commonlib.totable(msg)
    if (msg.targetName) then
        local targetEntity = GameLogic.EntityManager.GetEntity(msg.targetName)
        local vegetableName = targetEntity:GetModelFile()
        if (targetEntity) then
            local targetTag = targetEntity:GetStaticTag()
            if (targetTag == 'vegetable') then
                local cutFileName = vegetableName:gsub("(%.%w+)$", "_cut%1")
                targetEntity:SetModelFile(cutFileName)
                targetEntity:SetStaticTag('cut')
            end
        end
    end
end)
