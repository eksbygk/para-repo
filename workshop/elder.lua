-- ！！！暂时加入所有物品，待配置好section后删减
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
-- elderItemTable[2] = {
--     key = 2,
--     filename = sunFlower,
--     text = "向日葵"
-- }
-- elderItemTable[3] = {
--     key = 3,
--     filename = wine,
--     text = "红酒"
-- }
-- elderItemTable[4] = {
--     key = 4,
--     filename = cake,
--     text = "蛋糕"
-- }

local section = 0
registerBroadcastEvent("section", function(msg)
    section = msg
    if section == 2 then
        -- 在末尾插入。章节二，加入向日葵物品
        table.insert(elderItemTable, {
            key = 2,
            filename = sunFlower,
            text = "向日葵"
        })
    elseif section == 3 then
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
local html = ""
function init(entity)
    length = #elderItemTable
    if length == 0 then
        -- 移除click事件、mount事件，老者头顶电影。所有物品已找到，table不再更新
        entity:SetOnClickEvent(nil)
        entity:SetOnMountEvent(nil)
        return
    end
    currentIndex = math.random(1, length)
    html = [[<div style="font-size: 28px; width: 1834px;height: 337px;background: url(images/elder/dialog_bg.png);">
    <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:57px;background: url(images/elder/]] ..
               elderItemTable[currentIndex].key .. [[.png);"></div></div>]]
end
init()

function checkHat(entity, mountedEntity)
    if (mountedEntity.filename == elderItemTable[currentIndex].filename) then
        entity:Say("谢谢你，送给你一个四叶草")
        entity:SetOnMountEvent(nil)
        -- 物品已交付，暂时移除插件点事件
        -- 物品已交付，从表中移除这一条
        table.remove(elderItemTable, currentIndex)
        init(entity)
        wait(0.5)
        mountedEntity:Destroy()
    else
        entity:Say("不需要这个物品，再去找找看吧")
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
local itemHtmlTable = {}

function elderDialog()
    local dialog = window(html, "_ctb", 0, 0, 1834, 337)
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
        entity:SetOnMountEvent("onMountElder")
        elderDialog()
    end
end)

