local htmlMouse = [[
    <div style="width: 1834px;height: 337px;background: url(images/custodian/dialog-bg.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/custodian/mouse1.png);"></div>
    </div>]]
local htmlMouseGot = [[
    <div style="width: 1834px;height: 337px;background: url(images/custodian/dialog-bg.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/custodian/mouse2.png);"></div>
    </div>]]

-- 捉到老鼠
function renderDialogMouseGot()
    local dialog = window(htmlMouseGot, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
            -- dosomething
            -- 进入动画、移除点击事件等
            cmd("/setblock 19283,5,19661 192")
            cmd("/goto 19242,10,19501")
        end
    end)
end

local woodFile = {
    filename = "blocktemplates/w26.bmax",
    spec = "特制的木板(任务收集物品)"
}
function renderDialogMouse(entity)
    local dialog = window(htmlMouse, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
            cmd("/setblock 19275,5,19619 192")
            -- 创建木板
            local subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_wood")
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(entity.name .. "_wood")
                subEntity:SetModelFile(woodFile.filename)
                subEntity.tag = woodFile.spec
                subEntity:SetOnClickEvent("showTag")
                subEntity:SetCanDrag(true)
                subEntity:SetScaling(1)
                subEntity:SetPosition(20044, -121, 20315)
                subEntity:FallDown()
            end
        end
    end)
end

local isShow = false

local dialogTable = {[[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog0.png);"></div>]],
                     [[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog1.png);"></div>]],
                     [[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog2.png);"></div>]]}
local index = 1
function renderDialog(entity)
    if not isShow then
        isShow = true
        local dialog = window(dialogTable[index], "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                if entity then
                    entity:SetOnMountEvent("onMountCustodian")
                end
                if index == 3 then
                    dialog:CloseWindow()
                    isShow = false
                    return
                end
                dialog:CloseWindow()
                isShow = false
                index = index + 1
                renderDialog()
            end
        end)
    end

end

local isGetFood = false
local isGetMouse = false
registerBroadcastEvent("getFood", function(msg)
    -- 此变量设置为空，章节2开始前都不会弹出对话框，点击事件保留
    isGetFood = true
end)

registerBroadcastEvent("getMouse", function(msg)
    isGetMouse = true
end)

local fristClick = true
local key = {
    filename = "blocktemplates/k17.bmax",
    spec = "银制钥匙，用来打开仓库门"
}
registerBroadcastEvent("onClickCustodian", function(msg)
    stopMovie("notice1")
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if _G.section == 1 then
            if not isGetFood then
                if fristClick then
                    fristClick = false
                    -- 首次点击，创建钥匙物品
                    local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_key")
                    subEntity = entity:CloneMe()
                    subEntity:SetName(msg.name .. "_key")
                    subEntity:SetModelFile(key.filename)
                    subEntity.tag = key.spec
                    subEntity:SetOnClickEvent("showTag")
                    subEntity:SetScaling(1.27)
                    subEntity:SetFacing(-90 * 3.14 / 180)
                    local x, y, z = subEntity:GetPosition()
                    subEntity:SetPosition(x, y + 1, z - 1)
                end
                renderDialog(entity)
            end
        elseif _G.section == 2 then
            if isGetMouse then
                renderDialogMouseGot()
                entity:SetOnClickEvent(nil)
            else
                renderDialogMouse(entity)
            end
        end
    end
end)
