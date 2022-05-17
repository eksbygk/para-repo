local head = [[<div style="width: 1834px;height: 337px;background: url(images/gardener/dialog.png);">
<div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/gardener/]]
local tail = [[.png);"></div></div>]]

-- section2 章节二的函数
local flower = 1
local index = 0
registerBroadcastEvent("gardenerTask1", function(msg)
    -- 完成任务1（第二章第1个任务）
    playMovie("notice3")
    flower = 2
    index = 0
end)

registerBroadcastEvent("gardenerTask2", function(msg)
    -- 完成任务2（第二章第2个任务）
    flower = 3
end)

local isShow = false
function renderDialog()
    if not isShow then
        isShow = true
        local html = ""
        if flower == 1 then
            html = head .. index .. tail
        elseif flower == 2 then
            html = head .. "flower" .. index .. tail
        else
            -- 只显示 不需要花花 对话框
            html = head .. "flower3" .. tail
        end
        local dialog = window(html, "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                if flower == 3 then
                    dialog:CloseWindow()
                    isShow = false
                    return
                end
                if index == 2 then
                    index = 1
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

local index2 = 0
function renderDialog3()
    if not isShow then
        isShow = true
        local html = head .. "sushi" .. index2 .. tail
        local dialog = window(html, "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                if index2 == 1 then
                    dialog:CloseWindow()
                    isShow = false
                    return
                end
                print(index2)
                dialog:CloseWindow()
                isShow = false
                index2 = index2 + 1
                renderDialog3()
            end
        end)
    end
end

registerBroadcastEvent("onClickGardener", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if entity then
        stopMovie("notice3")
        if _G.section == 2 then
            renderDialog()
        elseif _G.section == 3 then
            renderDialog3()
        end
    end
end)
