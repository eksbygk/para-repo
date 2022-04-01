local itemCollectedTable = {
    ["blocktemplates/k23.bmax"] = "待收集", -- 特制胶水
    ["blocktemplates/k22.bmax"] = "待收集", -- 木工锯
    ["blocktemplates/k18.bmax"] = "待收集", -- 木板
    ["blocktemplates/g28.bmax"] = "待收集" -- 尺子
}

local function rendersTasks()
    return "特制胶水： " .. itemCollectedTable["blocktemplates/k23.bmax"] .. "\n木工锯   ： " ..
               itemCollectedTable["blocktemplates/k22.bmax"] .. "\n木板       ： " ..
               itemCollectedTable["blocktemplates/k18.bmax"] .. "\n尺子       ： " ..
               itemCollectedTable["blocktemplates/g28.bmax"]
end

registerBroadcastEvent("showTasks", function(fromName)
    local wnd = window([[<div style="font-weight:bold;background-color:#ffffff;padding:5px;width:170%;">Tasks</div>]],
        "_lt", 20, 20, 160, 120)
    local ctx = wnd:getContext()
    ctx.fillStyle = "#00000090"
    ctx:fillRect(0, 0, ctx:getWidth(), ctx:getHeight())

    ctx.fillStyle = "#ffffff"
    ctx:fillText(rendersTasks(), 10, 30)
end)

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
