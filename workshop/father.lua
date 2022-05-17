local dialogs3 =
    {[[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-1a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-2a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-3a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-4a.png);"></div></div>]]}

local isShow = false

function renderDialog3(i, mcmlNode)
    local index = tonumber(mcmlNode:GetAttribute("param"))
    dialog2:CloseWindow()
    dialog3 = window(dialogs3[index], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
            isShow = false
        end
    end)
end

function closeDialog2()
    dialog2:CloseWindow()
    isShow = false
end

-- 关闭 S1的所有dialog
-- function closeAllDialog()
--     dialog1:CloseWindow()
--     dialog2:CloseWindow()
--     dialog3:CloseWindow()
--     isShow = false
-- end

function renderDialog2()
    dialog2 = window([[
        <div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <span style="margin-top: 85px;margin-left: 1730px;width:70px;height:70px;background: url(images/icon/close.png);" onclick="closeDialog2"></span>
        <div style="margin-top: -15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog2-1.png);" param="1" onclick="renderDialog3"></div>
        <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog2-2.png);" param="2" onclick="renderDialog3"></div>
        <div style="margin-top: -85px;margin-left: 900px;width:270px;height:35px;background: url(images/father/dialog2-3.png);" param="3" onclick="renderDialog3"></div>
        <div style="margin-top: -35px;margin-left: 900px;width:270px;height:35px;background: url(images/father/dialog2-4.png);" param="4" onclick="renderDialog3"></div>
    </div>
    ]], "_ctb", 0, 0, 1834, 337)
    dialog2:SetDesignResolution(1834, 337)
end

function renderDialog1()
    if not isShow then
        isShow = true
        dialog1 = window([[
    <div style="width: 1834px;height: 337px;background: url(images/father/dialog1.png);"></div>
]], "_ctb", 0, 0, 1834, 337)
        dialog1:SetDesignResolution(1834, 337)
        dialog1:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog1:CloseWindow()
                renderDialog2()
                broadcast("showTasks", "")
            end
        end)
    end
end

function renderDialogS2()
    if not isShow then
        isShow = true
        local dialog = window([[
    <div style="width: 1834px;height: 337px;background: url(images/father/dialog4-3.png);"></div>
]], "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog:CloseWindow()
                broadcast("showTasks", "")
                isShow = false
            end
        end)
    end

end

registerClickEvent(function()
    if _G.section == 1 then
        renderDialog1()
    elseif _G.section == 2 then
        renderDialogS2()
    end
    stopMovie("notice2")
end)

