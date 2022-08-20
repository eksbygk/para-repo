-- onMountIdentify
-- identifyItems结构 鉴定物品->变换后的物品
local identifyItems = {
    ["blocktemplates/j2.bmax"] = {
        filename = "blocktemplates/j11.bmax",
        spec = "和田玉(爸爸需要用到的材料)"
    },
    ["blocktemplates/j3.bmax"] = {
        filename = "blocktemplates/j12.bmax",
        spec = "皓石方钻(爸爸需要用到的材料)"
    },
    ["blocktemplates/j5.bmax"] = {
        filename = "blocktemplates/j10.bmax",
        spec = "钢筋块(爸爸需要用到的材料)"
    },
    ["blocktemplates/j6.bmax"] = {
        filename = "blocktemplates/j8.bmax",
        spec = "桉树块(爸爸需要用到的材料)"
    },
    ["blocktemplates/j4.bmax"] = {
        filename = "blocktemplates/j9.bmax",
        spec = "喷漆木块(爸爸需要用到的材料)"
    },
    ["blocktemplates/j1.bmax"] = {
        filename = "blocktemplates/j7.bmax",
        spec = "七彩琉璃(爸爸需要用到的材料)"
    }
}

local html = [[<div style="width: 1834px;height: 337px;background: url(images/robot/robot2.png);"></div>]]

registerBroadcastEvent("onMountIdentify", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        if identifyItems[mountedEntity.filename] then
            entity:Say("鉴定中......")
            wait(1)
            entity:Say("鉴定完毕！")
            if mountedEntity.filename == "blocktemplates/j3.bmax" then
                mountedEntity:SetScaling(0.7)
            elseif mountedEntity.filename == "blocktemplates/j1.bmax" then
                mountedEntity:SetScaling(0.9)
            end
            mountedEntity.tag = identifyItems[mountedEntity.filename].spec
            mountedEntity:SetModelFile(identifyItems[mountedEntity.filename].filename)
            local x, y, z = mountedEntity:GetPosition()
            mountedEntity:SetPosition(x - 2, y + 2, z)
            -- wait(0.1)
            mountedEntity:FallDown()
        else
            local dialog = window(html, "_ctb", 0, 0, 1834, 337)
            dialog:SetDesignResolution(1834, 337)
            dialog:registerEvent("onmouseup", function(event)
                if (event:button() == "left") then
                    dialog:CloseWindow()
                end
            end)
        end
    end
end)
