local dialogTable = {
    notThis = [[<div style="width: 1834px;height: 337px;background: url(images/dialog3-0.png);">
        <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/dialog3-3.png);"></div>
    </div>]],
    right = [[<div style="width: 1834px;height: 337px;background: url(images/dialog3-0.png);">
        <div style="margin-top: 200px;margin-left: 600px;width:1134px;height:28px;background: url(images/dialog3-4.png);"></div>
    </div>]],
    notCold = [[<div style="width: 1834px;height: 337px;background: url(images/dialog3-0.png);">
        <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/dialog3-5.png);"></div>
    </div>]]
}

-- dialog- wait 4 seconds close
function renderDialog(type)
    local dialog = window(dialogTable[type], "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    wait(4)
    dialog:CloseWindow()
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
        end
    end)
end

local colaColdTable = {"blocktemplates/cupredcola_cold.bmax", "blocktemplates/cola_cold.bmax"}
local colaTable = {"blocktemplates/cupredcola.bmax", "blocktemplates/cola.bmax"}

function checkFood(entity, mountedEntity)
    local filename = mountedEntity:GetModelFile()
    if (filename == colaColdTable[1] or filename == colaColdTable[2]) then
        local fogname = mountedEntity.name .. "_fogModel"
        local fogEntity = GameLogic.EntityManager.GetEntity(fogname)
        renderDialog("right")
        fogEntity:destroy()
        mountedEntity:destroy()
    elseif (filename == colaTable[1] or filename == colaTable[2]) then
        renderDialog("notCold")
    else
        renderDialog("notThis")
    end
end

-- 通用演员插件点事件 来源world 118742
registerBroadcastEvent("onMountToCharacter", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (msg.mountname == "" and entity:HasCustomGeosets()) then
            local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
            if (mountedEntity) then
                local category = mountedEntity:GetCategory()
                if (category == "customCharItem") then
                    local itemId = mountedEntity:GetStaticTag();
                    local replacedItemId = entity:PutOnCustomCharItem(itemId)
                    if (replacedItemId) then
                        mountedEntity:BecomeCustomCharacterItem(replacedItemId)
                        mountedEntity:SetStaticTag(replacedItemId)

                        local facing = entity:GetFacing()
                        local x, y, z = entity:GetPosition()
                        x = x + math.cos(facing)
                        z = z - math.sin(facing)
                        local x1, y1, z1 = mountedEntity:GetPosition()
                        mountedEntity:SetPosition(x, y1, z)
                        mountedEntity:SetBootHeight(0)
                        mountedEntity:SetPitch(-1.57)
                        mountedEntity:FallDown()
                    else
                        mountedEntity:Destroy()
                    end
                elseif (mountedEntity:GetCanDrag()) then
                    -- take the entity in left hand
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
                end
                -- my code begin
                checkFood(entity, mountedEntity)
                -- my code end
            end
        end
    end
end)
