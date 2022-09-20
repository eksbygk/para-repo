local giftBox = "blocktemplates/k26.bmax"
local scissors = "blocktemplates/k35.bmax"
local gifts = {
    {file = "blocktemplates/k7.bmax", size = 3},
    {file = "blocktemplates/k8.bmax", size = 3},
    {file = "blocktemplates/k9.bmax", size = 3},
    {file = "blocktemplates/k10.bmax", size = 3},
    {file = "blocktemplates/k11.bmax", size = 3},
    {file = "blocktemplates/k12.bmax", size = 3},
    {file = "blocktemplates/k13.bmax", size = 3},
    {file = "blocktemplates/k14.bmax", size = 3},
    {file = "blocktemplates/k15.bmax", size = 3},
    {file = "blocktemplates/k16.bmax", size = 3},
    {file = "blocktemplates/k17.bmax", size = 3},
    {file = "blocktemplates/k18.bmax", size = 3},
    {file = "blocktemplates/k19.bmax", size = 3},
    {file = "blocktemplates/k20.bmax", size = 3},
    {file = "blocktemplates/k21.bmax", size = 3},
    {file = "blocktemplates/k22.bmax", size = 3},
    {file = "blocktemplates/k23.bmax", size = 3},
    {file = "blocktemplates/k24.bmax", size = 3}
}

registerBroadcastEvent("onMountChangeRandom", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    local file = entity:GetModelFile()
    local mountedEntity = GetEntity(msg.mountedEntityName)
    local mountedFile = entity:GetModelFile()
    if entity and mountedEntity and file == giftBox and mountedFile == scissors then
        local index = math.random(1, #gifts)
        entity:SetModelFile(gifts[index].file)
        entity:SetScaling(gifts[index].size)
        entity:SetOnClickEvent(nil)
        entity:EnablePhysics(false)
    end
end)
