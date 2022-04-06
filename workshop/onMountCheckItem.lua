_G.section = 1

itemFile = {
    gule = "blocktemplates/k23.bmax",
    saw = "blocktemplates/k22.bmax",
    wood = "blocktemplates/k18.bmax",
    ruler = "blocktemplates/g28.bmax"
}

itemTable = {
    [itemFile.gule] = {
        index = 1,
        num = 1,
        title = "特制胶水",
        type = "待收集",
        color = "#ffffff",
        filename = "blocktemplates/k23.bmax"
    },
    [itemFile.saw] = {
        index = 2,
        num = 1,
        title = "木工锯",
        type = "待收集",
        color = "#ffffff",
        filename = "blocktemplates/k22.bmax"
    },
    [itemFile.wood] = {
        index = 3,
        num = 5,
        join = " * ",
        title = "普通木板",
        type = "待收集",
        color = "#ffffff",
        filename = "blocktemplates/k18.bmax"
    },
    [itemFile.ruler] = {
        index = 4,
        title = "尺子",
        type = "待收集",
        num = 1,
        color = "#ffffff",
        filename = "blocktemplates/g28.bmax"
    }
}

registerBroadcastEvent("showTasks", function(fromName)
    taskWnd = window([[ 
        <div style="width: 200px;height: 200px;background-color: #00000090;color:#fff;font-size:18px;font-weight: bold;">
            <div
                style="width: 200%; height: 50px;background-color: #000;font-size:24px;text-align: center;line-height: 50px;">
                任务列表</div>
            <div style="padding:10px;">
                <div>
                    <span style="width: 120px;margin-bottom: 8px;">
                        <%=itemTable[itemFile.gule].title%>
                    </span>
                    <pe:label value='<%=itemTable[itemFile.gule].type%>' getter="value" />
                </div>
                <div>
                    <span style="width: 120px;margin-bottom: 8px;">
                        <%=itemTable[itemFile.saw].title%>
                    </span>
                    <pe:label value='<%=itemTable[itemFile.saw].type%>' getter="value" />
                </div>
                <div>
                    <span style="width: 120px;margin-bottom: 8px;">
                        <%=itemTable[itemFile.wood].title%>
                        <pe:label value='<%=tostring(itemTable[itemFile.wood].join)%>' getter="value" />
                        <pe:label value='<%=tostring(itemTable[itemFile.wood].num)%>' getter="value" />
                    </span>
                    <pe:label value='<%=itemTable[itemFile.wood].type%>' getter="value" />
                </div>
                <div>
                    <span style="width: 120px;">
                        <%=itemTable[itemFile.ruler].title%>
                    </span>
                    <pe:label value='<%=itemTable[itemFile.ruler].type%>' getter="value;style" style="color:'<%=itemTable[itemFile.ruler].color%>'"/>
                </div>
            </div>
        </div>
        ]], "_lt", 50, 110, 200, 200)
end)

-- 物品总数
itemNum = 0

-- dialog
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
                if (itemNum == 4) then
                    _G.section = 2
                    taskWnd:CloseWindow()
                    local dialogFinal = window([[
                        <div style="width: 1834px;height: 337px;background: url(images/dialog2.png);">
                            <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:28px;background: url(images/dialog4.png);"></div>
                        </div>
                    ]], "_ctb", 0, 0, 1834, 337)
                    dialogFinal:SetDesignResolution(1834, 337)
                    dialogFinal:registerEvent("onmouseup", function(event)
                        if (event:button() == "left") then
                            dialogFinal:CloseWindow()
                        end
                    end)
                end
            end
        end)
    end
end

registerBroadcastEvent("onMountCheckItem", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    local mountedFileName = mountedEntity:GetModelFile()
    if (itemTable[mountedFileName] and itemTable[mountedFileName].type == "待收集") then
        mountedEntity:Destroy()
        itemTable[mountedFileName].num = itemTable[mountedFileName].num - 1
        if (itemTable[mountedFileName].num == 0) then
            if (itemTable[mountedFileName].join) then
                itemTable[mountedFileName].join = ""
            end
            itemTable[mountedFileName].num = ""
            renderDialog()
            itemTable[mountedFileName].type = "已完成"
            itemNum = itemNum + 1

        end
    end
end)
