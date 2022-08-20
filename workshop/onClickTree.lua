local wood = {
    filename = "blocktemplates/k18.bmax",
    spec = "木板(砍伐小树可以获得)"
}
local axFileName = "blocktemplates/g13.bmax"

function logging(entity, life)
    local subEntity = GameLogic.EntityManager.GetEntity()
    subEntity = entity:CloneMe()
    subEntity:SetName(entity.name .. "_wood" .. life)
    subEntity:SetModelFile(wood.filename)
    subEntity.tag = wood.spec
    subEntity:SetOnClickEvent("showTag")
    subEntity:SetOnHoverEvent(nil)
    subEntity:SetCanDrag(true)
    subEntity:SetScaling(1)
    local x, y, z = subEntity:GetPosition()
    subEntity:SetPosition(x + 1, y + 2, z)
    entity.tag = life - 1
    subEntity:FallDown()
    if (entity.tag == 0) then
        subEntity:Say("这棵树已经被消耗了")
        entity:Destroy()
    end
end
registerBroadcastEvent("onClickTree", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local life = tonumber(entity.tag)
    if (entity and life) then
        if (life > 0) then
            logging(entity, life)
        end
    end
end)

registerBroadcastEvent("onClickBigTree", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        say("这棵树太大了,  请换一颗小树！")
    end
end)

registerBroadcastEvent("onHoverTree", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        -- check filename match ax filename
        hoverFileName = hoverEntity:GetModelFile()
        if (hoverFileName == axFileName) then
            run(function()
                if (not hoverEntity.isPouring) then
                    hoverEntity.isPouring = true
                    if (hoverEntity:IsAutoTurningDuringDragging()) then
                        hoverEntity:SetFacing(entity:GetFacing())
                    end
                    for i = 1, 10 do
                        hoverEntity:SetRoll(-i / 10 * math.pi / 2)
                        wait(0.01)
                    end
                    for i = 10, 0, -1 do
                        hoverEntity:SetRoll(-i / 10 * math.pi / 2)
                        wait(0.01)
                    end
                    hoverEntity.isPouring = nil;
                    return
                end
            end)
            local life = tonumber(entity.tag)
            run(function()
                if (life > 0) then
                    logging(entity, life)
                end
            end)
        end
    end
end)
