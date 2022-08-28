score = 0
local html = [[
    <div style="color:red;">得分： <%=score%></div>
    <div onclick="exit" style="width:100;height:50;background-color:cyan;margin-top:20;font-size:20;line-height:50;text-align:center;">
        退出！
    </div>
]]

local wnd = window(html, "_lt", 50, 50, 300, 100)

registerBroadcastEvent("score", function(msg)
    score = score + 1
    wnd:CloseWindow()
    wnd = window(html, "_lt", 50, 50, 300, 100)
end)

function exit()
    cmd("/setblock 18322,9,19483 0")
end
