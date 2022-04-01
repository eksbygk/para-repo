function renderDialog3(e)
    say(e)
end

function renderDialog2()
    local dialog2 = window([[
        <div style="width: 1834px;height: 337px;background: url(images/dialog2.png);">
            <div style="margin-top: 120px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-1.png);" onclick="renderDialog3(1)"></div>
            <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-2.png);" onclick="renderDialog3(2)"></div>
            <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-3.png);" onclick="renderDialog3(3)"></div>
            <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/dialog2-4.png);" onclick="renderDialog3(4)"></div>
        </div>
    ]], "_ctb", 0, 0, 1834, 337)
    dialog2:SetDesignResolution(1834, 337)
    dialog2:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog2:CloseWindow()
        end
    end)
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
        end
    end)
end

registerClickEvent(function()
    renderDialog1()
end)

