local waterContainers = {
    ["blocktemplates/cola.bmax"] = {
        ["blocktemplates/cupred.bmax"] = {
            filename = "blocktemplates/cupredcola.bmax",
            spec = "装了可乐汽水的杯子"
        }
    },
    ["blocktemplates/peachsoda.bmax"] = {
        ["blocktemplates/cupred.bmax"] = {
            filename = "blocktemplates/cupredpeachsoda.bmax",
            spec = "装了桃子味汽水的杯子"
        }
    },
    ["blocktemplates/fanta.bmax"] = {
        ["blocktemplates/cupred.bmax"] = {
            filename = "blocktemplates/cupredfanta.bmax",
            spec = "装了橙子味汽水的杯子"
        }
    }
}
local drinkTable = {
    ["blocktemplates/cupredorange.bmax"] = {
        filename = "blocktemplates/cupred.bmax"
    },
    ["blocktemplates/cupredmilk.bmax"] = {
        filename = "blocktemplates/cupred.bmax"
    },
    ["blocktemplates/cupredchocolate.bmax"] = {
        filename = "blocktemplates/cupred.bmax"
    },
    ["blocktemplates/cupwater.bmax"] = {
        filename = "blocktemplates/cup.bmax"
    },
    ["blocktemplates/teacup.bmax"] = {
        filename = "blocktemplates/teacupempty.bmax"
    },
    ["blocktemplates/drinkblue.bmax"] = {
        filename = "blocktemplates/drinkempty.bmax"
    },
    ["blocktemplates/drinkyellow.bmax"] = {
        filename = "blocktemplates/drinkempty.bmax"
    },
    ["blocktemplates/drinkred.bmax"] = {
        filename = "blocktemplates/drinkempty.bmax"
    }
}

registerBroadcastEvent("__entity_onhover", function(msg)
    msg = commonlib.LoadTableFromString(msg)

    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    run(function()
        if (entity and hoverEntity) then

            local filenameTop = hoverEntity:GetModelFile() or ""
            local filenameBottom = entity:GetModelFile() or ""

            -- pour water into another cup
            local waterItem = waterContainers[filenameTop]
            if (waterItem and not hoverEntity.isPouring) then

                local result = waterItem[filenameBottom]
                if (result) then
                    playSound("music/d.mp3")
                    hoverEntity.isPouring = true
                    if (hoverEntity:IsAutoTurningDuringDragging()) then
                        hoverEntity:SetFacing(entity:GetFacing())

                    end
                    if (waterItem.playSpawnEffect) then

                        local x, y, z = entity:GetPosition()
                        mygame.PlaySpawnEffect(x, y, z)
                    end
                    broadcast("playEntityClickSound", waterItem.poursound or "pourwater")
                    for i = 1, 10 do
                        hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                        wait(0.05)
                    end
                    entity:SetModelFile(result.filename)
                    entity.tag = result.spec
                    for i = 10, 0, -1 do
                        hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                        wait(0.05)
                    end
                    hoverEntity.isPouring = nil;
                    return
                end
            end
            -- drink water if bottom is character
            if (entity:HasCustomGeosets() and drinkTable[filenameTop] and not hoverEntity.isPouring) then
                local result = drinkTable[filenameTop]
                if (result.filename) then
                    hoverEntity.isPouring = true
                    if (hoverEntity:IsAutoTurningDuringDragging()) then
                        hoverEntity:SetFacing(entity:GetFacing() + math.pi / 2)
                    end
                    broadcast("playEntityClickSound", "drink")
                    for i = 1, 10 do
                        hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                        wait(0.05)
                    end
                    hoverEntity:SetModelFile(result.filename)
                    for i = 10, 0, -1 do
                        hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                        wait(0.05)
                    end
                    hoverEntity.isPouring = nil;
                    return
                end
            end
        end
    end)
end)
