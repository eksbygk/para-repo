local bookHtml = [[<div style="width: 750px;height: 500px;background: url(images/book1.png);"></div>]]

registerBroadcastEvent("onClickCreateWindow", function(msg)
    wnd = window(bookHtml, "_ct", -375, -250, 750, 500)
    wnd:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            wnd:CloseWindow()
        end
    end)
end)