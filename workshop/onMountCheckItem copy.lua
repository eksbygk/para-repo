local itemCollectedTable = {
    ["blocktemplates/k23.bmax"] = {
        type = "待收集",
        index = 1,
        title = "特制胶水",
        num = 1,
        color = "#ffffff"
    },
    ["blocktemplates/k22.bmax"] = {
        type = "待收集",
        index = 2,
        title = "木工锯",
        num = 1,
        color = "#ffffff"
    },
    ["blocktemplates/k18.bmax"] = {
        type = "待收集",
        index = 3,
        title = "木板",
        num = 3,
        color = "#ffffff"
    },
    ["blocktemplates/g28.bmax"] = {
        type = "待收集",
        index = 4,
        title = "尺子",
        num = 1,
        color = "#ffffff"
    }
}
local positionY = {50, 80, 110, 140}

-- registerBroadcastEvent("showTasks", function(fromName)
local wnd = window(
    [[<div style="font-weight:bold;background-color:#000000;color:#fff;padding:5px;width:240px;font-size:26px;">
    当前任务</div>]], "_lt", 50, 110, 240, 180)
local ctx = wnd:getContext()
ctx.fillStyle = "#00000095"
ctx:fillRect(0, 0, ctx:getWidth(), ctx:getHeight())
ctx.font = "Microsoft YaHei;20;"
ctx.fillStyle = "#ffffff"
ctx:fillText("特制胶水*" .. itemCollectedTable["blocktemplates/k23.bmax"]["num"], 10, positionY[1])
ctx:fillText("木工锯*" .. itemCollectedTable["blocktemplates/k22.bmax"]["num"], 10, positionY[2])
ctx:fillText("普通木板*" .. itemCollectedTable["blocktemplates/k18.bmax"]["num"], 10, positionY[3])
ctx:fillText("尺子*" .. itemCollectedTable["blocktemplates/g28.bmax"]["num"], 10, positionY[4])
ctx:fillText(itemCollectedTable["blocktemplates/k23.bmax"]["type"], 140, positionY[1])
ctx:fillText(itemCollectedTable["blocktemplates/k22.bmax"]["type"], 140, positionY[2])
ctx:fillText(itemCollectedTable["blocktemplates/k18.bmax"]["type"], 140, positionY[3])
ctx:fillText(itemCollectedTable["blocktemplates/g28.bmax"]["type"], 140, positionY[4])
-- end)

local dialogHtml = [[<div style="width: 1834px;height: 337px;background: url(images/dialog2.png);">
<div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/dialog4-1.png);"></div>
</div>]]

local flag = true
local function renderDialog()
    if (flag) then
        flag = false
        local dialog = window(dialogHtml, "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog:CloseWindow()
                flag = true
            end
        end)
    end
end

registerBroadcastEvent("onMountCheckItem", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    local mountedFileName = mountedEntity:GetModelFile()
    if (itemCollectedTable[mountedFileName]["type"] == "待收集") then
        renderDialog()
        itemCollectedTable[mountedFileName]["type"] = "已完成"
        itemCollectedTable[mountedFileName]["color"] = "#00ff00"
        local index = itemCollectedTable[mountedFileName]["index"]
        ctx:clearRect()
        ctx.fillStyle = "#00000095"
        ctx:fillRect(0, 0, ctx:getWidth(), ctx:getHeight())
        ctx.font = "Microsoft YaHei;20;"
        ctx.fillStyle = "#ffffff"
        ctx:fillText("特制胶水*" .. itemCollectedTable["blocktemplates/k23.bmax"]["num"], 10, positionY[1])
        ctx:fillText("木工锯*" .. itemCollectedTable["blocktemplates/k22.bmax"]["num"], 10, positionY[2])
        ctx:fillText("普通木板*" .. itemCollectedTable["blocktemplates/k18.bmax"]["num"], 10, positionY[3])
        ctx:fillText("尺子*" .. itemCollectedTable["blocktemplates/g28.bmax"]["num"], 10, positionY[4])

        ctx.fillStyle = itemCollectedTable["blocktemplates/k23.bmax"]["color"]
        ctx:fillText(itemCollectedTable["blocktemplates/k23.bmax"]["type"], 140, positionY[1])
        ctx.fillStyle = itemCollectedTable["blocktemplates/k22.bmax"]["color"]
        ctx:fillText(itemCollectedTable["blocktemplates/k22.bmax"]["type"], 140, positionY[2])
        ctx.fillStyle = itemCollectedTable["blocktemplates/k18.bmax"]["color"]
        ctx:fillText(itemCollectedTable["blocktemplates/k18.bmax"]["type"], 140, positionY[3])
        ctx.fillStyle = itemCollectedTable["blocktemplates/g28.bmax"]["color"]
        ctx:fillText(itemCollectedTable["blocktemplates/g28.bmax"]["type"], 140, positionY[4])

        -- ctx:fillText("完成", 140, positionY[index])
    end
end)
