html = [[<div style="width: 1834px;height: 337px;background: url(images/dialog3-0.png);">
        <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/dialog3-3.png);"></div>
    </div>]]

local dialog = window(html, "_ctb", 0, 0, 1834, 337)
dialog:SetDesignResolution(1834, 337)
dialog:registerEvent("onmouseup", function(event)
    if (event:button() == "left") then
        dialog:CloseWindow()
    end
end)

-- Mount
registerBroadcastEvent("onMountEvent", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity) then
        -- do something
    end
end)

-- Hover
registerBroadcastEvent("onHoverEvent", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        -- do something
    end
end)

-- Create
registerBroadcastEvent("onclickCreate", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_water")
        if (entity.tag == "open") then
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_water")
                subEntity:SetModelFile(waterModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                subEntity:SetPosition(x, y - 2.5, z + 0.2)
            end
        else
            if (subEntity) then
                subEntity:Destroy()
            end
        end
    end
end)

-- API
registerBroadcastEvent("onMountEvent", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity) then
        mountedEntity = entity:CloneMe()
        mountedEntity:SetName()
        mountedEntity:SetModelFile()
        mountedEntity:SetOnClickEvent(nil)
        mountedEntity:SetOnMountEvent(nil)
        mountedEntity:SetOnHoverEvent(nil)
        mountedEntity:SetCanDrag(false)
        mountedEntity:EnablePhysics(false)
        mountedEntity:SetScaling(1)
        mountedEntity:SetFacing(mountedEntity:GetFacing() + math.pi)
        mountedEntity:SetFacing(95 * 3.14 / 180)
        mountedEntity:SetFacing(95 * math.pi / 180)
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x, y - 2.6, z - 0.2)
        mountedEntity:FallDown()

        mountedEntity:Destroy()
    end
end)
