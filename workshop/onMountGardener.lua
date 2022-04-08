-- gardener
local flowers = {
    ["blocktemplates/w30.bmax"] = {
        type = false
    },
    ["blocktemplates/w31.bmax"] = {
        type = false
    },
    ["blocktemplates/w32.bmax"] = {
        type = false
    }
}

local boxOrange = "blocktemplates/j4.bmax"
local flowerNum = 0
function checkFlower(entity, mountedEntity)
    local x, y, z = entity:GetPosition()
    if (flowers[mountedEntity.filename]) then
        local type = flowers[mountedEntity.filename].type
        if (type) then
            entity:Say("i already have this one")
            wait(1)
            mountedEntity:SetPosition(x, y, z - 1.5)
        else
            flowers[mountedEntity.filename].type = true
            entity:Say("thank you")
            wait(0.5)
            mountedEntity:Destroy()
            flowerNum = flowerNum + 1
            if flowerNum == 3 then
                wait(1)
                local boxEntity = GameLogic.EntityManager.GetEntity()
                boxEntity = entity:CloneMe()
                boxEntity:SetPosition(x, y, z - 1)
                boxEntity:SetModelFile(boxOrange)
                boxEntity:SetCanDrag(true)
                boxEntity:SetOnMountEvent(nil)
                entity:Say("gave you box")
            end
        end
    else
        entity:Say("don t neet this")
        wait(1)
        mountedEntity:SetPosition(x, y, z - 1.5)
    end
end

registerBroadcastEvent("onMountGardener", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (msg.mountname == "" and entity:HasCustomGeosets()) then
            local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
            if (mountedEntity) then
                local boneName = "L_Hand"
                local oldEntity = entity:GetLinkChildAtBone(boneName)
                local x, y, z = entity:GetPosition()
                local aabb = mountedEntity:GetInnerObjectAABB()
                local dx, dy, dz = aabb:GetExtendValues()
                local pos = {math.max(math.sqrt(dx ^ 2, dz ^ 2) - 0.2, 0), -0.1,
                             -math.max(math.sqrt(dx ^ 2 + dz ^ 2) - 0.2, 0)}
                mountedEntity:LinkTo(entity, boneName, pos);

                -- my code begin
                checkFlower(entity, mountedEntity)
                -- my code end
            end
        end
    end
end)
