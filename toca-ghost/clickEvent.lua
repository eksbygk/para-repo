-- 通用点击变换：A->B,点击A，A变为B（不可逆）
-- 配置：A点击事件，A静态属性（B文件名.bamx）
registerBroadcastEvent("onClickReplace", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local Atag = entity:GetStaticTag()
    if (entity and Atag and Atag ~= 'replaced') then
        local BFileName = 'blocktemplates/' .. Atag .. '.bmax'
        entity:SetModelFile(BFileName)
        entity:SetStaticTag('replaced')
    end
end)

-- 通用点击切换：A<->B，任意切换
-- 配置：A点击事件，B文件名(A文件名+'toggle'.bmax), Ex:item.bamx,itemtoggle.bamx
registerBroadcastEvent("onclickToggle", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local filename = entity:GetModelFile()
        if (filename:match("toggle")) then
            filename = filename:gsub("toggle", "")
            entity:SetModelFile(filename)
        else
            filename = filename:gsub("(%.%w+)$", "toggle%1")
            entity:SetModelFile(filename)
        end
    end
end)

-- 通用点击新增：A->AB,点击A，新增B
