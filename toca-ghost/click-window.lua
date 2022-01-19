local booksHtml = {[[<div style="width: 750px;height: 500px;background: url(images/book01.png);"></div>]],
                   [[<div style="width: 750px;height: 500px;background: url(images/book02.png);"></div>]],
                   [[<div style="width: 750px;height: 500px;background: url(images/book03.png);"></div>]],
                   [[<div style="width: 750px;height: 500px;background: url(images/book04.png);"></div>]],
                   [[<div style="width: 750px;height: 500px;background: url(images/book05.png);"></div>]],
                   [[<div style="width: 750px;height: 500px;background: url(images/book06.png);"></div>]]}  

-- 点击事件，打开书,书静态属性为 图片编号
registerBroadcastEvent("onClickCreateWindow", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local bookIndex = tonumber(entity:GetStaticTag())
    wnd = window(booksHtml[bookIndex], "_ct", -375, -250, 750, 500)
    wnd:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            wnd:CloseWindow()
        end
    end)
end)
