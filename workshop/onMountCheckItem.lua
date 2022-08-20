function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

itemTable = {}
itemFile1 = {
    gule = "blocktemplates/k23.bmax",
    saw = "blocktemplates/k22.bmax",
    wood = "blocktemplates/k18.bmax",
    ruler = "blocktemplates/g28.bmax"
}
itemTable1 = {
    [itemFile1.gule] = {
        num = 1,
        title = "特制胶水",
        type = "待收集"
    },
    [itemFile1.saw] = {
        num = 1,
        title = "木工锯",
        type = "待收集"
    },
    [itemFile1.wood] = {
        num = 5,
        join = " * ",
        title = "普通木板",
        type = "待收集"
    },
    [itemFile1.ruler] = {
        title = "尺子",
        type = "待收集",
        num = 1
    }
}

itemFile2 = {
    steel = "blocktemplates/j10.bmax", -- 钢筋块
    wood = "blocktemplates/w26.bmax", -- 特制木板
    paint = "blocktemplates/j9.bmax", -- 喷漆块
    concrete = "blocktemplates/k19.bmax", -- 混凝土
    eucalyptus = "blocktemplates/j8.bmax" -- 桉树块
}
itemTable2 = {
    [itemFile2.steel] = {
        num = 3,
        join = " * ",
        title = "钢筋块",
        type = "待收集"
    },
    [itemFile2.wood] = {
        num = 1,
        title = "特制木板 ",
        type = "待收集"
    },
    [itemFile2.paint] = {
        num = 2,
        join = " * ",
        title = "喷漆木块",
        type = "待收集"
    },
    [itemFile2.concrete] = {
        num = 6,
        join = " * ",
        title = "混凝土",
        type = "待收集"
    },
    [itemFile2.eucalyptus] = {
        title = "桉树块",
        join = " * ",
        type = "待收集",
        num = 2
    }
}

itemFile3 = {
    grass = "blocktemplates/m24.bmax", -- 玻璃
    steelPlate = "blocktemplates/m27.bmax" -- 钢板
}
itemTable3 = {
    [itemFile3.grass] = {
        num = 1,
        title = "玻璃",
        type = "待收集"
    },
    [itemFile3.steelPlate] = {
        num = 1,
        join = " * ",
        title = "钢板 ",
        type = "待收集"
    }
}

html = ""
html1 = [[
    <div style="width: 200px;height: 200px;background-color: #00000090;color:#fff;font-size:18px;font-weight: bold;">
        <div
            style="width: 200%; height: 50px;background-color: #000;font-size:24px;text-align: center;line-height: 50px;">
            任务列表</div>
        <div style="padding:10px;">
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile1.gule].title%>
                </span>
                <pe:label value='<%=itemTable[itemFile1.gule].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile1.saw].title%>
                </span>
                <pe:label value='<%=itemTable[itemFile1.saw].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile1.wood].title%>
                        <pe:label value='<%=tostring(itemTable[itemFile1.wood].join)%>' getter="value" />
                        <pe:label value='<%=tostring(itemTable[itemFile1.wood].num)%>' getter="value" />
                </span>
                <pe:label value='<%=itemTable[itemFile1.wood].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;">
                    <%=itemTable[itemFile1.ruler].title%>
                </span>
                <pe:label value='<%=itemTable[itemFile1.ruler].type%>' getter="value" />
            </div>
        </div>
    </div>
]]
html2 = [[
    <div style="width: 200px;height: 220px;background-color: #00000090;color:#fff;font-size:18px;font-weight: bold;">
        <div
            style="width: 200%; height: 50px;background-color: #000;font-size:24px;text-align: center;line-height: 50px;">
            任务列表</div>
        <div style="padding:10px;">
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile2.steel].title%>
                        <pe:label value='<%=tostring(itemTable[itemFile2.steel].join)%>' getter="value" />
                        <pe:label value='<%=tostring(itemTable[itemFile2.steel].num)%>' getter="value" />
                </span>
                <pe:label value='<%=itemTable[itemFile2.steel].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile2.wood].title%>
                </span>
                <pe:label value='<%=itemTable[itemFile2.wood].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile2.paint].title%>
                        <pe:label value='<%=tostring(itemTable[itemFile2.paint].join)%>' getter="value" />
                        <pe:label value='<%=tostring(itemTable[itemFile2.paint].num)%>' getter="value" />
                </span>
                <pe:label value='<%=itemTable[itemFile2.paint].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile2.concrete].title%>
                        <pe:label value='<%=tostring(itemTable[itemFile2.concrete].join)%>' getter="value" />
                        <pe:label value='<%=tostring(itemTable[itemFile2.concrete].num)%>' getter="value" />
                </span>
                <pe:label value='<%=itemTable[itemFile2.concrete].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile2.eucalyptus].title%>
                        <pe:label value='<%=tostring(itemTable[itemFile2.eucalyptus].join)%>' getter="value" />
                        <pe:label value='<%=tostring(itemTable[itemFile2.eucalyptus].num)%>' getter="value" />
                </span>
                <pe:label value='<%=itemTable[itemFile2.eucalyptus].type%>' getter="value" />
            </div>
        </div>
    </div>
]]
html3 = [[
    <div style="width: 200px;height: 130px;background-color: #00000090;color:#fff;font-size:18px;font-weight: bold;">
        <div
            style="width: 200%; height: 50px;background-color: #000;font-size:24px;text-align: center;line-height: 50px;">
            任务列表</div>
        <div style="padding:10px;">
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile3.grass].title%>
                </span>
                <pe:label value='<%=itemTable[itemFile3.grass].type%>' getter="value" />
            </div>
            <div>
                <span style="width: 120px;margin-bottom: 8px;">
                    <%=itemTable[itemFile3.steelPlate].title%>
                </span>
                <pe:label value='<%=itemTable[itemFile3.steelPlate].type%>' getter="value" />
            </div>
        </div>
    </div>
]]

function resetTask(section)
    if section == 1 then
        itemTable = itemTable1
        html = html1
    elseif section == 2 then
        itemTable = itemTable2
        html = html2
    elseif section == 3 then
        itemTable = itemTable3
        html = html3
    end
end
resetTask(1)

local flagTask = true
taskDeskEntity = GameLogic.EntityManager.GetEntity("workshop_task_desk")
registerBroadcastEvent("showTasks", function(fromName)
    if flagTask then
        flagTask = false
        taskWnd = window(html, "_lt", 50, 200, 10, 10)
        taskDeskEntity:SetOnMountEvent("onMountCheckItem")
    end
end)

-- 物品总数
itemNum = 0

-- dialog
local dialogHtml = [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
<div style="margin-top: 135px;margin-left: 470px;width:1134px;height:28px;background: url(images/father/dialog4-1.png);"></div>
</div>]]

local foundation = {
    -- 地基模型
    filename = "blocktemplates/g1.bmax",
    spec = "小屋模型地基，我现在要去找更多的材料帮助爸爸把小屋搭建起来。"
}

-- 小屋模型
local houseModel = {}
houseModel[1] = {
    filename = "blocktemplates/g1.bmax",
    spec = "小屋模型地基，我现在要去找更多的材料帮助爸爸把小屋搭建起来。"
}
houseModel[2] = {
    filename = "blocktemplates/g2.bmax",
    spec = "小屋模型结构，我现在要去找更多的材料帮助爸爸把小屋搭建起来。"
}
-- houseModel[3] = {
--     filename = "blocktemplates/g3.bmax",
--     spec = "小屋模型楼层，我现在要去找更多的材料帮助爸爸把小屋搭建起来。"
-- }

local itemBase = GameLogic.EntityManager.GetEntity("workshop_item")
local houseModelName = ""
function handleStartSection(section, entity)
    -- section == 2表示第一章已结束，第二章开始
    if section == 2 then
        cmd("/setblock 19289,5,19654 192")
        houseModelName = entity.name .. "_houseModel"
        local subEntity = GameLogic.EntityManager.GetEntity(houseModelName)
        if not subEntity then
            subEntity = entity:CloneMe()
            subEntity:SetName(houseModelName)
            subEntity:SetModelFile(houseModel[1].filename)
            subEntity.tag = houseModel[1].spec
            subEntity:SetOnClickEvent("showTag")
            subEntity:SetCanDrag(false)
            subEntity:SetScaling(2.47)
            subEntity:SetFacing(90 * math.pi / 180)
            subEntity:SetPosition(20042.1, -123.7, 20392.4)
        end
    elseif section == 3 then
        cmd("/setblock 19289,5,19659 192")
        local subEntity = GameLogic.EntityManager.GetEntity(houseModelName)
        if subEntity then
            subEntity:SetModelFile(houseModel[2].filename)
            subEntity.tag = houseModel[2].spec
        end
    elseif section == 4 then
        cmd("/setblock 19289,5,19678 192")
        local subEntity = GameLogic.EntityManager.GetEntity(houseModelName)
        if subEntity then
            subEntity:Destroy()
        end
    end
end

local finhtmlTable = {[[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:28px;background: url(images/father/fin1.png);"></div>
    </div>]], [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/fin2.png);"></div>
    </div>]], [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/fin3.png);"></div>
    </div>]]}
local section = 1
local flag = true
local function renderDialog(entity)
    if (flag) then
        flag = false
        local dialog = window(dialogHtml, "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog:CloseWindow()
                flag = true
                if (itemNum >= tablelength(itemTable)) then
                    -- 开启新章节
                    flagTask = true
                    itemNum = 0
                    section = section + 1
                    resetTask(section)
                    taskDeskEntity:SetOnMountEvent(nil)
                    cmd("/setblock 19188 6 19506 (0 9 129) 0")
                    taskWnd:CloseWindow()
                    local dialogFinal = window(finhtmlTable[section - 1], "_ctb", 0, 0, 1834, 337)
                    dialogFinal:SetDesignResolution(1834, 337)
                    dialogFinal:registerEvent("onmouseup", function(event)
                        if (event:button() == "left") then
                            dialogFinal:CloseWindow()
                            handleStartSection(section, entity)
                            broadcast("newSection", section)
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
    if entity and mountedEntity then
        local mountedFileName = mountedEntity:GetModelFile()
        if (itemTable[mountedFileName] and itemTable[mountedFileName].type == "待收集") then
            playSound("music/item.ogg")
            local entity4Clone = mountedEntity
            mountedEntity:Destroy()
            itemTable[mountedFileName].num = itemTable[mountedFileName].num - 1
            if (itemTable[mountedFileName].num == 0) then
                if (itemTable[mountedFileName].join) then
                    itemTable[mountedFileName].join = ""
                end
                itemTable[mountedFileName].num = ""
                renderDialog(entity4Clone)
                itemTable[mountedFileName].type = "已完成"
                itemNum = itemNum + 1
            end
        end
    end
end)
