local dialogTable = {
    notThis = [[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog0.png);">
        <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/custodian/dialog3-3.png);"></div>
    </div>]],
    right = [[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog0.png);">
        <div style="margin-top: 200px;margin-left: 600px;width:1134px;height:28px;background: url(images/custodian/dialog3-4.png);"></div>
    </div>]],
    notCold = [[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog0.png);">
        <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/custodian/dialog3-5.png);"></div>
    </div>]]
}

-- dialog- wait 4 seconds close
function renderDialog(type)
    local dialog = window(dialogTable[type], "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
        end
    end)
    wait(3)
    dialog:CloseWindow()
end

local colaColdTable = {"blocktemplates/cupredcola_cold.bmax", "blocktemplates/cola_cold.bmax"}
local colaTable = {"blocktemplates/cupredcola.bmax", "blocktemplates/cola.bmax"}

local gule = "blocktemplates/k23.bmax"

function checkFood(entity, mountedEntity)
    local filename = mountedEntity:GetModelFile()
    if (filename == colaColdTable[1] or filename == colaColdTable[2]) then
        local fogname = mountedEntity.name .. "_fogModel"
        local fogEntity = GameLogic.EntityManager.GetEntity(fogname)
        renderDialog("right")
        fogEntity:Destroy()
        mountedEntity:SetModelFile(gule)
        mountedEntity:SetScaling(1)
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x - 2, y, z)
        mountedEntity:FallDown()
        entity:SetOnMountEvent(nil)
        broadcast("getFood", "")
    elseif (filename == colaTable[1] or filename == colaTable[2]) then
        renderDialog("notCold")
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x - 1.5, y, z)
        mountedEntity:FallDown()
    else
        renderDialog("notThis")
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x - 1.5, y, z)
        mountedEntity:FallDown()
    end
end

registerBroadcastEvent("onMountCustodian", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (msg.mountname == "" and entity:HasCustomGeosets()) then
            local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
            if (mountedEntity) then
                local boneName = "L_Hand"
                local oldEntity = entity:GetLinkChildAtBone(boneName)
                if (oldEntity) then
                    mountedEntity:FallDown()
                else
                    local x, y, z = entity:GetPosition()
                    local aabb = mountedEntity:GetInnerObjectAABB()
                    local dx, dy, dz = aabb:GetExtendValues()
                    local pos = {math.max(math.sqrt(dx ^ 2, dz ^ 2) - 0.2, 0), -0.1,
                                 -math.max(math.sqrt(dx ^ 2 + dz ^ 2) - 0.2, 0)}
                    mountedEntity:LinkTo(entity, boneName, pos);
                end
                -- my code begin
                checkFood(entity, mountedEntity)
                -- my code end
            end
        end
    end
end)
