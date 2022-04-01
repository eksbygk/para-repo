-- 例子1:绘图板
wnd = window([[<div>draw something</div>]], "_lt", 200, 20, 300, 300);
local ctx = wnd:getContext();
ctx.strokeStyle = "#ff0000"
ctx.lineWidth = 2
ctx.font = "System;20;"
ctx:fillText("left click and drag", 10, 30)
ctx.fillStyle = "#80808080"
ctx:fillRect(0, 0, ctx:getWidth(), ctx:getHeight())
wnd:registerEvent("onmousedown", function(event)
    ctx:strokeRect(event:pos():x(), event:pos():y(), 1, 1)
    ctx:beginPath()
    ctx:moveTo(event:pos():x(), event:pos():y())
end)
wnd:registerEvent("onmousemove", function(event)
    if (event:LeftButton()) then
        ctx:lineTo(event:pos():x(), event:pos():y())
        ctx:stroke()
        ctx:beginPath()
        ctx:moveTo(event:pos():x(), event:pos():y())
    end
end)
wnd:registerEvent("onmouseup", function(event)
    if (event:button() == "right") then
        wnd:CloseWindow()
    end
end)
