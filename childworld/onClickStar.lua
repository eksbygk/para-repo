local starJar = "blocktemplates/k51.bmax"
local star = "blocktemplates/k28.bmax"

registerBroadcastEvent("onClickStarJar", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    local file = entity:GetModelFile()
    if entity and file == starJar then
        local starNum = entity.tag or 10
        if starNum <= 0 then
            entity:Destroy()
            return
        end
        local starEntity = GetEntity(msg.name .. 'star' .. starNum)
        starEntity = entity:CloneMe()
        local x, y, z = starEntity:GetPosition()
        starEntity:SetPosition(x + math.random(-2, 2), y + 3,
                               z + math.random(-2, 2))
        starEntity:FallDown()
        starEntity:SetModelFile(star)
        starEntity:SetOnClickEvent(nil)
        entity.tag = starNum - 1
    end
end)
