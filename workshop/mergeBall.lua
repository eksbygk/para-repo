local ball = {
    filename = "blocktemplates/z11.bmax",
    spec = "来玩叠叠乐吗？(可以试着将相同的草团叠在一起)"
}

local maxSpec = "最终形态"

registerBroadcastEvent("onMountBall", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        local filename = entity:GetModelFile()
        local mountedFile = mountedEntity:GetModelFile()
        local scaling = entity:GetScaling()
        local mountedScaling = mountedEntity:GetScaling()
        if filename == mountedFile and filename == ball.filename and mountedScaling == scaling then
            newScaling = scaling * 1.5
            entity:SetScaling(newScaling)
            mountedEntity:Destroy()
            if newScaling > 3 then
                entity:SetOnMountEvent(nil)
                entity.tag = maxSpec
                broadcast("gardening2", "")
            end
        end
    end
end)

local ballNum = 0
registerBroadcastEvent("onClickGrassBall", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local x, y, z = entity:GetPosition()
        for i = 1, 4 do
            local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. ballNum)
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. ballNum)
                subEntity:SetModelFile(ball.filename)
                subEntity.tag = ball.spec
                subEntity:SetOnClickEvent("showTag")
                subEntity:SetOnMountEvent("onMountBall")
                subEntity:SetAutoTurningDuringDragging(true)
                subEntity:SetCanDrag(true)
                subEntity:EnablePhysics(true)
                subEntity:SetScaling(1)
                subEntity:SetPosition(x + math.random(-2, 2), y + 2, z + math.random(-2, 2))
                wait(0.1)
                subEntity:FallDown()
                ballNum = ballNum + 1
            end
        end
    end
end)
