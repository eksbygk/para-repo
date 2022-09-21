local navs = {{
    index = 1,
    name = "认读",
    switch = "19238,3,19341"
}, {
    index = 2,
    name = "拓展",
    switch = "19233,3,19343"
}, {
    index = 3,
    name = "找朋友",
    clickEvent = "onHideNum"
}, {
    index = 4,
    name = "学计数",
    position = "18155,1,19758"
}, {
    index = 5,
    name = "考记忆",
    position = "18336,8,19486",
    switch = "19267,2,19436"
}, {
    index = 6,
    name = "讲故事",
    position = "19232,2,19500"
}}

function getNavs()
    return navs
end

function getStyle(index)
    local styleStr = string.format("width:73;height:40;margin-right:8;background: url(images/navigation/%s.png)", index)
    return styleStr
end

local html = [[
<div>
    <div style="font-size:16;margin-bottom:3"></div>
    <pe:repeat DataSource="<%=getNavs()%>">
        <pe:repeatitem style="float:left;">
            <div style='<%=getStyle(Eval("index"))%>' onclick="onClickNav" name='<%=Eval("index")%>'>
            </div> 
        </pe:repeatitem>
    </pe:repeat>
</div>
]]

local currentSwitch = ''
local wnd = window(html, "_lt", 20, 20, 800, 100)

function onClickNav(name, mcmlNode)
    local nav = navs[name]
    tip(nav.name)
    local currentSwitch = nav.switch
    local clickEvent = nav.clickEvent
    local position = nav.position
    if currentSwitch then
        -- wnd:hide() -- 隐藏top navigation
        -- broadcast("hideWindows", "") -- 隐藏bottom navigation
        wait(1)
        cmd("/setblock " .. currentSwitch .. " 0")
        cmd("/setblock " .. currentSwitch .. " 192")
    end
    if clickEvent then
        broadcast(clickEvent)
    end
    if position then
        tip("正在前往")
        cmd("/goto " .. position)
    end
end

registerBroadcastEvent("movieOver", function(msg)
    wnd:show()
    cmd("/setblock " .. currentSwitch .. " 0")
end)

