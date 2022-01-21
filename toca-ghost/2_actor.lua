-- split
function split(str, sep)
    local res = {}
    if str ~= nil then
        if sep == nil then
            sep = "%s"
        end
        for s in string.gmatch(str, "([^" .. sep .. "]+)") do
            table.insert(res, s)
        end
    end
    return res
end

-- 二楼开门
function openTheDoor(entity, mountedEntity)
    local entityTag = entity:GetStaticTag()
    local mountedTag = mountedEntity:GetStaticTag()
    local mountedTable = split(mountedTag, ',')
    if (entityTag and mountedTag and mountedTable[2] == 'open') then
        say("The door is open !")
        stopMovie(entityTag)
        wait(1)
        cmd("/setblock 19566 12 19373 (3 0 6) 0")
    end
end

-- 通用演员插件点事件 来源world 118742
-- 二楼开门
registerBroadcastEvent("onMountToCharacter4lock", function(msg)
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
                openTheDoor(entity, mountedEntity)
                -- my code end
            end
        end
    end
end)
