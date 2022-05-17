-- 小土堆
local soil = {
    filename = "blocktemplates/k19.bmax",
    spec = "混凝土(可用铲子挖土堆获得)"
}
local shovelFileName = "blocktemplates/g16.bmax" -- 铲

function pouring(hoverEntity)
    run(function()
        if (not hoverEntity.isPouring) then
            playSound("music/w.mp3")
            hoverEntity.isPouring = true
            if (hoverEntity:IsAutoTurningDuringDragging()) then
                hoverEntity:SetFacing(entity:GetFacing())
            end
            for i = 1, 10 do
                hoverEntity:SetPitch(-i / 10 * math.pi / 4)
                wait(0.01)
            end
            for i = 10, 0, -1 do
                hoverEntity:SetPitch(-i / 10 * math.pi / 4)
                wait(0.01)
            end
            hoverEntity.isPouring = nil;
            return
        end
    end)
end

local soilNum = 0
function digSoil(entity)
    local subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_soil_" .. soilNum)
    if (not subEntity) then
        subEntity = entity:CloneMe()
        subEntity:SetName(entity.name .. "_soil_" .. soilNum)
        subEntity:SetModelFile(soil.filename)
        subEntity.tag = soil.spec
        subEntity:SetOnClickEvent("showTag")
        subEntity:SetOnHoverEvent(nil)
        subEntity:SetCanDrag(true)
        subEntity:SetScaling(1)
        local x, y, z = subEntity:GetPosition()
        subEntity:SetPosition(x + 4 + math.random(-1, 1), y + 8, z + math.random(-1, 1))
        wait(0.1)
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
            pouring(hoverEntity)
            digSoil(hoverEntity)
        end
    end
end)

registerBroadcastEvent("onBeginDragSoil", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if entity then
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_soil_" .. soilNum)
        if subEntity then
            soilNum = soilNum + 1
        end
    end
end)
