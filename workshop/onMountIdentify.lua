-- onMountIdentify
-- identifyItems结构 鉴定物品->变换后的物品
local identifyItems = {
    ["blocktemplates/j1.bmax"] = {
        filename = "blocktemplates/j11.bmax"
    },
    ["blocktemplates/j2.bmax"] = {
        filename = "blocktemplates/j11.bmax"
    },
    ["blocktemplates/j3.bmax"] = {
        filename = "blocktemplates/j14.bmax"
    },
    ["blocktemplates/j4.bmax"] = {
        filename = "blocktemplates/j16.bmax"
    },
    ["blocktemplates/j5.bmax"] = {
        filename = "blocktemplates/j10.bmax"
    },
    ["blocktemplates/j6.bmax"] = {
        filename = "blocktemplates/j10.bmax"
    },
    ["blocktemplates/j7.bmax"] = {
        filename = "blocktemplates/j10.bmax"
    },
    ["blocktemplates/j8.bmax"] = {
        filename = "blocktemplates/j11.bmax"
    },
    ["blocktemplates/j9.bmax"] = {
        filename = "blocktemplates/j10.bmax"
    },
    ["blocktemplates/j10.bmax"] = {
        filename = "blocktemplates/j10.bmax"
    }
}

registerBroadcastEvent("onMountIdentify", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        if identifyItems[mountedEntity.filename] then
            entity:Say("鉴定中......")
            wait(1)
            entity:Say("鉴定完毕！")
            mountedEntity:SetModelFile(identifyItems[mountedEntity.filename].filename)
            local x, y, z = mountedEntity:GetPosition()
            mountedEntity:SetPosition(x - 2, y + 2, z)
            -- wait(0.1)
            mountedEntity:FallDown()
        end
    end
end)
