-- split
function split(str, sep)
    local res = {}
    if sep == nil then
        sep = "%s"
    end
    for s in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(res, s)
    end
    return res
end

function changeTargetFood(entity, mountedEntity)
    local entityTag = entity:GetStaticTag()
    local mountedTag = mountedEntity:GetStaticTag()
    print(mountedTag)
    if (entityTag and mountedTag) then
        local entityTagTable = split(entityTag, ',') -- 演员
        local mountedTagTable = split(mountedTag, ',') -- 食物
        if (entityTagTable[1] ~= 'changed' and mountedTagTable[1] == 'food_cooked' and entityTagTable[1] ==
            mountedTagTable[2]) then
            entity:Say("Good!")
            wait(1.5)
            local newFileName = 'blocktemplates/' .. entityTagTable[1] .. '.bmax'
            entity:SetStaticTag('changed')
            mountedEntity:SetModelFile(newFileName)
            mountedEntity:SetStaticTag('changed')
            local x, y, z = mountedEntity:GetPosition()
            mountedEntity:SetPosition(x, y + 2, z)
            stopMovie(entityTagTable[2])
            return
        end
    end
    entity:Say("Not this!")
end

-- 通用演员插件点事件 来源world 118742
-- 配置：演员静态属性 == 食物第二个静态属性（food_cooked,XXX），必须配置为新模型文件名！
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
                changeTargetFood(entity, mountedEntity)
                -- my code end
            end
        end
    end
end)
