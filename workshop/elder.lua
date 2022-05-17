-- 老爷爷的点击 插件点事件
-- 需要搜寻的物品有章节增加而增加，表中物品随机出现
local hat = "blocktemplates/e3.bmax"
local sunFlower = "blocktemplates/h17.bmax"
local wine = "blocktemplates/m19.bmax"
local cake = "blocktemplates/c24.bmax"

local elderItemTable = {}
elderItemTable[1] = {
    key = 1,
    filename = hat,
    text = "帽子"
}

local haveTask = true
local section = 0
registerBroadcastEvent("section", function(msg)
    section = msg
    if section == 2 then
        haveTask = true
        -- 在末尾插入。章节二，加入向日葵物品
        table.insert(elderItemTable, {
            key = 2,
            filename = sunFlower,
            text = "向日葵"
        })
    elseif section == 3 then
        haveTask = true
        -- 章节三，加入红酒，蛋糕
        table.insert(elderItemTable, {
            key = 3,
            filename = wine,
            text = "红酒"
        })
        table.insert(elderItemTable, {
            key = 4,
            filename = cake,
            text = "蛋糕"
        })
    end
end)

local length = 0
local currentIndex = 0
local mainHtml = ""
function init(entity)
    length = #elderItemTable
    if length == 0 then
        if _G.section >= 3 then
            -- 所有物品已找到。如果已处于 第三章以后（第三章开放所有场景），移除点击事件
            entity:SetOnClickEvent(nil)
        else
            -- 未到第三章，table还会增加，暂时阻止弹出对话框
            haveTask = false
        end
        -- 移除mount事件，老者头顶电影。，table不再更新
        entity:SetOnMountEvent(nil)
        return
    end
    currentIndex = math.random(1, length)
    mainHtml = [[<div style="font-size: 28px; width: 1834px;height: 337px;background: url(images/elder/dialog_bg.png);">
    <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/elder/]] ..
                   elderItemTable[currentIndex].key .. [[.png);"></div></div>]]
end
init()

local errorHtml = [[<div style="width: 1834px;height: 337px;background: url(images/elder/dialog_bg.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/custodian/dialog3-3.png);"></div>
    </div>]]
local successHtml = [[<div style="width: 1834px;height: 337px;background: url(images/elder/dialog_bg.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/elder/6.png);"></div>
    </div>]]
local normalHtml = [[<div style="width: 1834px;height: 337px;background: url(images/elder/dialog_bg.png);">
    <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/elder/5.png);"></div>
</div>]]
local isNoticeShow = false
local leafFile = "blocktemplates/j13.bmax"

function createNotice(html)
    local dialog = window(html, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
            isNoticeShow = false
        end
    end)
end

function checkHat(entity, mountedEntity)
    if (mountedEntity.filename == elderItemTable[currentIndex].filename) then
        -- 交付正确物品，创建四叶草物品
        if not isNoticeShow then
            isNoticeShow = true
            createNotice(successHtml)
        end

        entity:SetOnMountEvent(nil)
        -- 物品已交付，暂时移除插件点事件
        -- 物品已交付，从表中移除这一条
        table.remove(elderItemTable, currentIndex)
        init(entity)
        wait(0.5)
        -- 创建四叶草
        mountedEntity:SetModelFile(leafFile)
        mountedEntity:SetOnClickEvent("onClickLeaf")
        mountedEntity:SetCanDrag(true)
        mountedEntity:SetScaling(0.8)
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x, y, z - 1.5)
        mountedEntity:FallDown()

    else
        -- entity:Say("不需要这个物品，再去找找看吧")
        if not isNoticeShow then
            isNoticeShow = true
            createNotice(errorHtml)
        end

        wait(0.5)
        local x, y, z = mountedEntity:GetPosition()
        mountedEntity:SetPosition(x, y, z - 1.5)
        mountedEntity:FallDown()
    end
end

registerBroadcastEvent("onMountElder", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (msg.mountname == "" and entity:HasCustomGeosets()) then
            local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
            if (mountedEntity) then
                local boneName = "L_Hand"
                local oldEntity = entity:GetLinkChildAtBone(boneName)
                local x, y, z = entity:GetPosition()
                local aabb = mountedEntity:GetInnerObjectAABB()
                local dx, dy, dz = aabb:GetExtendValues()
                local pos = {math.max(math.sqrt(dx ^ 2, dz ^ 2) - 0.2, 0), -0.1,
                             -math.max(math.sqrt(dx ^ 2 + dz ^ 2) - 0.2, 0)}
                -- my code begin
                checkHat(entity, mountedEntity)
                -- my code end
            end
        end
    end
end)

-- [[ 点击事件 ]]
-- local itemHtmlTable = {}
local isShow = false
function elderDialog()
    if not isShow then
        isShow = true
        local dialog = window(mainHtml, "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog:CloseWindow()
                isShow = false
            end
        end)
    end

end

local normalHtml = [[<div style="width: 1834px;height: 337px;background: url(images/elder/dialog_bg.png);">
<div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/elder/5.png);"></div>
</div>]]

function normalDialog()
    local dialog = window(normalHtml, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
        end
    end)
end

registerBroadcastEvent("onClickElder", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if haveTask then
            -- haveTask 控制没有任务时不弹出任务对话框
            stopMovie("notice4")
            entity:SetOnMountEvent("onMountElder")
            elderDialog()
        else
            -- 无任务
            normalDialog()
        end
    end
end)

