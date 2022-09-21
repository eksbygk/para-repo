score = 0
local html = [[
    <div style="color:red;">得分： <%=score%></div>
    <div onclick="exit" style="width:100;height:50;background-color:cyan;margin-top:20;font-size:20;line-height:50;text-align:center;">
        退出！
    </div>
]]

local wnd = window(html, "_lt", 40, 100, 300, 100)

registerBroadcastEvent("score", function(msg)
    score = score + 1
    wnd:CloseWindow()
    wnd = window(html, "_lt", 40, 100, 300, 100)
end)

function exit()
    cmd("/setblock 19267,2,19437 0")
    tip("您的得分： " .. score)
    broadcast("movieOver")
end

countdown = 60
local time = [[
    <div style="color:red;">倒计时： <%=countdown%></div>
]]
local timeWnd = window(time, "_lt", 40, 80, 50, 10)
for i = 10, 0, -1 do
    countdown = i
    timeWnd:CloseWindow()
    timeWnd = window(time, "_lt", 40, 80, 50, 10)
    wait(1)
    if i == 1 then
        tip("时间到，游戏结束")
        wait(1)
        exit()
    end
end
