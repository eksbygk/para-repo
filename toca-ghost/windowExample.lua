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


-- 例子2:MCML UI
test = {
    key = "hello world"
}

function OnClickTest2()
    test.key = document:GetPageCtrl():GetValue("myName")
    cmd("/tip clicked2!" .. test.key)
end

function GetTitle()
    return "Enter text:"
end

window([[ 
<script>
function OnClose()
    cmd("/tip clicked!"..Page:GetValue("myName"))
    Page:CloseWindow()
end
</script>
<div style="margin:10px"> 
    <%=GetTitle()%> 
    <input name="myName"  type="text" style="width:90px" value='<%=test.key%>'/> 
    <input type="button" onclick="OnClickTest2" value="click me"/> 
    <input type="button" onclick="OnClose" value="close" style="margin-left:5px"/> 
</div> 
]], "_lt", 10, 10, 300, 100)


-- 例子3:Context2d API
local wnd = window([[<div>draw something</div>]], "_lt", 200, 20, 300, 300);
local ctx = wnd:getContext();
ctx.globalAlpha = 0.5
ctx:clearRect()
ctx.fillStyle = "#80808080"
ctx:fillRect(0, 0, ctx.width, ctx.height)
ctx.lineWidth = 2
ctx.font = "System;20;"
ctx:save()
ctx:translate(50, 10)
ctx:rotate(-0.2)
ctx:drawImage("preview.jpg", 70, 60, 64, 32)
ctx:strokeText("left click and drag", 10, 30)
ctx:restore()
ctx.strokeStyle = "#ff0000"
ctx:moveTo(0, 0)
ctx:lineTo(80, 80)
ctx:lineTo(0, 80)
ctx:stroke()
ctx:beginPath()
ctx:arc(100, 100, 40, 0, 1.4, true)
ctx:lineTo(190, 120)
ctx:closePath()
ctx:stroke()
ctx.fillStyle = "blue"
ctx:fill()
