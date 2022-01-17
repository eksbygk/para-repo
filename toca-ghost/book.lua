local bookHtml = [[<div style="width: 300px;height: 200px;background: url(images/book1.png);"></div>]]

registerBroadcastEvent("onClickCreateWindow", function(msg)
    window(bookHtml, "_lt", 100, 100, 200, 200)
    wnd:registerEvent("onmouseup", function(event)
        if (event:button() == "right") then
            wnd:CloseWindow()
        end
    end)
end)
