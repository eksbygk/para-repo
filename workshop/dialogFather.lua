local dialogs3 =
    {[[<div style="width: 1834px;height: 337px;background: url(images/dialog2.png);"><div style="margin-top: 180px;margin-left: 600px;width:1080px;height:35px;background: url(images/dialog2-1a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/dialog2.png);"><div style="margin-top: 180px;margin-left: 600px;width:1080px;height:35px;background: url(images/dialog2-2a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/dialog2.png);"><div style="margin-top: 180px;margin-left: 600px;width:1080px;height:35px;background: url(images/dialog2-3a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/dialog2.png);"><div style="margin-top: 180px;margin-left: 600px;width:1080px;height:35px;background: url(images/dialog2-4a.png);"></div></div>]]}

function renderDialog31()
    dialog2:CloseWindow()
    local dialog3 = window(dialogs3[1], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
            stopMovie("notice2")
        end
    end)
end
function renderDialog32()
    dialog2:CloseWindow()
    local dialog3 = window(dialogs3[2], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
        end
    end)
end
function renderDialog33()
    dialog2:CloseWindow()
    local dialog3 = window(dialogs3[3], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
        end
    end)
end
function renderDialog34()
    dialog2:CloseWindow()
    local dialog3 = window(dialogs3[4], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
        end
    end)
end

function renderDialog2()
    dialog2 = window([[
        <div style="width: 1834px;height: 337px;background: url(images/dialog2.png);">
            <div style="margin-top: 120px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-1.png);" onclick="renderDialog31"></div>
            <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-2.png);" onclick="renderDialog32"></div>
            <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-3.png);" onclick="renderDialog33"></div>
            <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-4.png);" onclick="renderDialog34"></div>
        </div>
    ]], "_ctb", 0, 0, 1834, 337)
    dialog2:SetDesignResolution(1834, 337)
end

function renderDialog1()
    local dialog1 = window([[
    <div style="width: 1834px;height: 337px;background: url(images/dialog1.png);"></div>
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

registerClickEvent(function()
    renderDialog1()
end)

