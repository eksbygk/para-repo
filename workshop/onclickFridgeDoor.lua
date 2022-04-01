local fridgeConvert = {
    ["blocktemplates/cola.bmax"] = "blocktemplates/cola_cold.bmax",
    ["blocktemplates/peachsoda.bmax"] = "blocktemplates/peachsoda_cold.bmax",
    ["blocktemplates/fanta.bmax"] = "blocktemplates/fanta_cold.bmax",
    ["blocktemplates/cupredcola.bmax"] = "blocktemplates/cupredcola_cold.bmax",
    ["blocktemplates/cupredpeachsoda.bmax"] = "blocktemplates/cupredpeachsoda_cold.bmax",
    ["blocktemplates/cupredfanta.bmax"] = "blocktemplates/cupredfanta_cold.bmax"
}

local fogModelFile = "character/CC/05effect/V5/wu/WU.x"

registerBroadcastEvent("onclickFridgeDoor", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        broadcastAndWait("onclick_DoorAxisX", msg)
        if (entity.tag == "close") then
            local door_x, door_y, door_z = entity:GetPosition()
            local fridgeEntity = GameLogic.EntityManager.GetEntity("workshop_fridgebody")
            if (fridgeEntity) then
                local hasCooked;
                fridgeEntity:ForEachChildLinkEntity(function(childEntity)
                    local childEntityName = commonlib.LoadTableFromString(childEntity).name
                    local filename = childEntity:GetModelFile()
                    local toFilename = fridgeConvert[filename]
                    if (toFilename) then
                        local x, y, z = childEntity:GetPosition()
                        local fogEntity = GameLogic.EntityManager.GetEntity(childEntityName .. "_subModel")
                        if (math.abs(y - door_y) < 0.5 and math.abs(door_z - z) < 1.1) then
                            -- mygame.PlaySmokeSmallEffect(x, y, z, 1)
                            -- mygame.PlaySpawnEffect(x, y, z)
                            childEntity:SetModelFile(toFilename)
                            fogEntity = childEntity:CloneMe()
                            fogEntity:SetName(childEntityName .. "_fogModel")
                            fogEntity:SetModelFile(fogModelFile)
                            fogEntity:SetScaling(0.1)
                            local x, y, z = fogEntity:GetPosition()
                            fogEntity:SetPosition(x, y, z)
                            fogEntity:LinkTo(childEntity)
                        end
                    end
                end);
                if (hasCooked) then
                    broadcast("playEntityClickSound", "giftopen")
                end
            end
        end
    end
end)
