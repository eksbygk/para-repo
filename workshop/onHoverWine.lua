-- status 2 ,for open the wine
local knife2 = "blocktemplates/g12.bmax"
local wine = "blocktemplates/m15.bmax"
local wineOpen = "blocktemplates/m16.bmax"
local cap = "blocktemplates/m17.bmax"
local wineDesc = "一瓶没有打开的红酒"
local wineOpenDesc = "红酒被打开了~可以倒进高酒杯里"
local capDesc = "红酒瓶上被打开后的木栓子"

function Pouring(hoverEntity)
    run(function()
        if (not hoverEntity.isPouring) then
            hoverEntity.isPouring = true
            if (hoverEntity:IsAutoTurningDuringDragging()) then
                hoverEntity:SetFacing(entity:GetFacing())
            end
            for i = 1, 10 do
                hoverEntity:SetRoll(-i / 10 * math.pi / 2)
                wait(0.03)
            end
            for i = 10, 0, -1 do
                hoverEntity:SetRoll(-i / 10 * math.pi / 2)
                wait(0.03)
            end
            hoverEntity.isPouring = nil;
            return
        end
    end)
end

registerBroadcastEvent("onHoverWine", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        hoverEntity:Say()
        if entity.filename == wine and hoverEntity.filename ~= wine then
            if hoverEntity.filename == knife2 then
                Pouring(hoverEntity)
                entity.tag = wineOpenDesc
                entity:SetModelFile(wineOpen)
                entity:Say("红酒被打开了", 3)

                -- 瓶盖
                local subEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName .. "_cap")
                if (not subEntity) then
                    subEntity = entity:CloneMe()
                    subEntity:SetName(msg.name .. "_cap")
                    subEntity:SetModelFile(cap)
                    subEntity:SetOnMountEvent(nil)
                    subEntity:SetOnHoverEvent(nil)
                    subEntity:SetScaling(0.2)
                    subEntity.tag = capDesc
                    local x, y, z = subEntity:GetPosition()
                    subEntity:SetPosition(x, y, z - 0.5)
                end
            else
                entity:Say("无法打开红酒，换一种工具试试", 3)
            end
        end
    end
end)

registerBroadcastEvent("onMountWine", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if entity and mountedEntity then
        if entity.filename == wineOpen and mountedEntity.filename == cap then
            entity:SetModelFile(wine)
            entity.tag = wineDesc
            mountedEntity:Destroy()
        end
    end
end)

local goblet = "blocktemplates/m18.bmax"
local gobleFull = "blocktemplates/m19.bmax"

registerBroadcastEvent("onHoverGoblet", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        hoverEntity:Say()
        if entity.filename == goblet and hoverEntity.filename ~= goblet then
            if hoverEntity.filename == wineOpen then
                Pouring(hoverEntity)
                entity:SetOnHoverEvent(nil)
                entity.tag = "倒了红酒的高脚杯"
                entity:SetModelFile(gobleFull)
            end
        end
    end
end)
