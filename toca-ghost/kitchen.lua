-- 灶台的火
local fireModelFile = "character/CC/05effect/fire.x"
registerBroadcastEvent("onclickFireOnStove", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_fire")

        if (entity.tag == "open") then
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_fire")
                subEntity:SetModelFile(fireModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                -- subEntity.SetScale(10)
                subEntity:SetPosition(x, y, z)
            end
        else
            if (subEntity) then
                subEntity:Destroy()
            end
        end
    end
end)
