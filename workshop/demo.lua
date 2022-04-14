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

registerBroadcastEvent("onMountEvent", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity) then
        -- do something
    end
end)

registerBroadcastEvent("onHoverEvent", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        -- do something
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
        mountedEntity:SetCanDrag(false)
        mountedEntity:EnablePhysics(false)
        mountedEntity:SetScaling(1)
        mountedEntity:SetFacing(mountedEntity:GetFacing() + math.pi)
        mountedEntity:SetFacing(95 * 3.14 / 180)
        mountedEntity:SetFacing(95 * math.pi / 180)
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x, y - 2.6, z - 0.2)
        mountedEntity:FallDown()
    end
end)