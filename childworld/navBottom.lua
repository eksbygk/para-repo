local bottom = [[
    <span onclick="onClickNav" param="square" style="display:inline-block;width:110;height:60;background: url(images/navigation/8.png)"></span>
    <span onclick="onClickNav" param="code" style="display:inline-block;margin-left:10;width:110;height:60;background: url(images/navigation/7.png)"></span>
]]

local bottomWnd = window(bottom, "_lb", 10, -70, 300, 100)

function onClickNav(_, mcmlNode)
    local nav = mcmlNode:GetAttribute("param")
    if nav == "code" then
        tip("正在前往代码方块")
        wait(0.5)
        cmd("/goto 19273,1,19434")
    elseif nav == "square" then
        tip("正在前往广场")
        wait(0.5)
        cmd("/goto 18171,1,19725")
    end
end

registerBroadcastEvent("hideWindows", function(msg)
    bottomWnd:hide()
end)

registerBroadcastEvent("movieOver", function(msg)
    bottomWnd:show()
end)
