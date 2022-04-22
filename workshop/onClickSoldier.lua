htmlTable = {}
htmlTable[1] = [[<div style="width: 1834px;height: 337px;background: url(images/soldier/dialog10.png);">
<div style="margin-top: 200px;margin-left: 500px;width:1134px;height:57px;background: url(images/soldier/dialog10-1.png);"></div></div>]]
htmlTable[2] = [[<div style="width: 1834px;height: 337px;background: url(images/soldier/dialog10.png);">
<div style="margin-top: 200px;margin-left: 500px;width:1134px;height:57px;background: url(images/soldier/dialog10-2.png);"></div></div>]]
htmlTable[3] = [[<div style="width: 1834px;height: 337px;background: url(images/soldier/dialog10.png);">
<div style="margin-top: 200px;margin-left: 500px;width:1134px;height:57px;background: url(images/soldier/dialog10-3.png);"></div></div>]]

html = htmlTable[1]

local index = 1
local orangeBox = {
    filename = "blocktemplates/j4.bmax",
    spec = "橙色方块(未鉴定物品)"
}
function renderDialog(entity)
    local dialog = window(html, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then

            if index == 3 then
                -- 第三次点击，结束。创建奖励物品并移除点击事件
                dialog:CloseWindow()

                local subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_orangebox")
                if (not subEntity) then
                    subEntity = entity:CloneMe()
                    subEntity:SetName(entity.name .. "_orangebox")
                    subEntity.tag = orangeBox.spec
                    subEntity:SetModelFile(orangeBox.filename)
                    subEntity:SetOnClickEvent("showTag")
                    subEntity:SetCanDrag(true)
                    subEntity:SetScaling(1.2)
                    local x, y, z = subEntity:GetPosition()
                    subEntity:SetPosition(x, y, z - 1.5)
                    subEntity:FallDown()
                end
            else
                dialog:CloseWindow()
                index = index + 1
                html = htmlTable[index]
                renderDialog(entity)
            end

        end
    end)
end

registerBroadcastEvent("onClickSoldier", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        -- do something
        renderDialog(entity)
    end
end)
