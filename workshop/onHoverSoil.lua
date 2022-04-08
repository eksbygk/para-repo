local soilModelFile = "blocktemplates/k19.bmax" -- 小土堆
local shovelFileName = "blocktemplates/g16.bmax" -- 铲

function digSoil(entity)
    local subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_wood")
    if (not subEntity) then
        subEntity = entity:CloneMe()
        subEntity:SetName(entity.name .. "_wood")
        subEntity:SetModelFile(soilModelFile)
        subEntity:SetOnClickEvent(nil)
        subEntity:SetOnHoverEvent(nil)
        subEntity:SetCanDrag(true)
        subEntity:SetScaling(1)
        local x, y, z = subEntity:GetPosition()
        subEntity:SetPosition(x + 8, y, z)

        subEntity:FallDown()
    end

end

registerBroadcastEvent("onHoverSoil", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        -- check filename match ax filename
        hoverFileName = hoverEntity:GetModelFile()
        if (hoverFileName == shovelFileName) then
            run(function()
                if (not hoverEntity.isPouring) then
                    hoverEntity.isPouring = true
                    if (hoverEntity:IsAutoTurningDuringDragging()) then
                        hoverEntity:SetFacing(entity:GetFacing())
                    end
                    for i = 1, 10 do
                        hoverEntity:SetRoll(-i / 10 * math.pi / 4)
                        wait(0.01)
                    end
                    for i = 10, 0, -1 do
                        hoverEntity:SetRoll(-i / 10 * math.pi / 4)
                        wait(0.01)
                    end
                    hoverEntity.isPouring = nil;
                    return
                end
            end)
            digSoil(entity)
        end
    end
end)
