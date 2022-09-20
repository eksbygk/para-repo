local cardTable = {
    ["blocktemplates/k1.bmax"] = {["blocktemplates/k14.bmax"] = true},
    ["blocktemplates/k2.bmax"] = {["blocktemplates/k8.bmax"] = true},
    ["blocktemplates/k3.bmax"] = {["blocktemplates/k11.bmax"] = true},
    ["blocktemplates/k4.bmax"] = {["blocktemplates/k20.bmax"] = true},
    ["blocktemplates/k5.bmax"] = {["blocktemplates/k16.bmax"] = true},
    ["blocktemplates/k6.bmax"] = {["blocktemplates/k23.bmax"] = true}
}
local starJar = "blocktemplates/k51.bmax"

registerBroadcastEvent("onMountCard", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    local mountedEntity = GetEntity(msg.mountedEntityName)
    if entity and mountedEntity then
        local cardFile = entity:GetModelFile()
        if cardTable[cardFile] then
            local mountedFile = mountedEntity:GetModelFile()
            local x, y, z = mountedEntity:GetPosition()
            local starEntity = GetEntity(msg.mountedEntityName .. 'star')
            if cardTable[cardFile][mountedFile] then
                tip("正确的")
                starEntity = mountedEntity:CloneMe()
                starEntity:SetPosition(x, y + 1, z)
                starEntity:SetModelFile(starJar)
                starEntity:SetScaling(2)
                starEntity:SetCanDrag(true)
                starEntity:SetOnClickEvent("onClickStarJar")
                starEntity:SetFacing(270 * math.pi / 180)
            else
                tip("错误")
                wait(0.5)
                mountedEntity:SetPosition(x + 1, y, z)
            end
        end
    end
end)
