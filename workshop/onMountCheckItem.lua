local itemCollectedTable = {
    ["blocktemplates/k23.bmax"] = "待收集", -- 特制胶水
    ["blocktemplates/k22.bmax"] = "待收集", -- 木工锯
    ["blocktemplates/k18.bmax"] = "待收集", -- 木板
    ["blocktemplates/g28.bmax"] = "待收集" -- 尺子
}
local itemNameTable = {"特质胶水", "木工锯", "普通木板", "尺子"}
local positionY = {40, 65, 90, 115}

local function rendersTasks()
    -- return itemCollectedTable["blocktemplates/k23.bmax"] .. "\n" .. itemCollectedTable["blocktemplates/k22.bmax"] ..
    --            "\n" .. itemCollectedTable["blocktemplates/k18.bmax"] .. "\n" ..
    --            itemCollectedTable["blocktemplates/g28.bmax"]
    
end

-- registerBroadcastEvent("showTasks", function(fromName)
local wnd = window(
    [[<div style="font-weight:bold;background-color:#00000090;color:#fff;padding:5px;width:170%;font-size:18px;">
    当前任务</div>]], "_lt", 50, 110, 160, 150)
local ctx = wnd:getContext()
ctx.fillStyle = "#00000080"
ctx:fillRect(0, 0, ctx:getWidth(), ctx:getHeight())
ctx.font = "Microsoft YaHei;16;"
ctx.fillStyle = "#ffffff"
ctx:fillText("特制胶水", 10, positionY[1])
ctx:fillText("木工锯", 10, positionY[2])
ctx:fillText("普通木板*3", 10, positionY[3])
ctx:fillText("尺子", 10, positionY[4])
ctx:fillText(itemCollectedTable["blocktemplates/k23.bmax"], 100, positionY[1])
ctx:fillText(itemCollectedTable["blocktemplates/k22.bmax"], 100, positionY[2])
ctx:fillText(itemCollectedTable["blocktemplates/k18.bmax"], 100, positionY[3])
ctx:fillText(itemCollectedTable["blocktemplates/g28.bmax"], 100, positionY[4])

-- ctx:fillText(rendersTasks(), 100, 40)
-- end)

local dialogHtml = [[<div style="width: 1834px;height: 337px;background: url(images/dialog2.png);">
<div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/dialog4-1.png);"></div>
</div>]]

local function renderDialog()
    local dialog = window(dialogHtml, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
        end
    end)
end

registerBroadcastEvent("onMountCheckItem", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    local mountedFileName = mountedEntity:GetModelFile()
    if (itemCollectedTable[mountedFileName] == "待收集") then
        renderDialog()
        itemCollectedTable[mountedFileName] = "完成"
        ctx:clearRect()
        ctx.fillStyle = "#00000090"
        ctx:fillRect(0, 0, ctx:getWidth(), ctx:getHeight())
        ctx.fillStyle = "#ffffff"
        ctx:fillText(rendersTasks(), 10, 30)
    end
end)
