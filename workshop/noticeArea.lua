-- noticeArea 根据章节开启区域
section = 1
if section == 1 then
    local dialog = window([[
    <div style="width: 1834px;height: 337px;background: url(images/dialog8.png);"></div>
]], "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
        end
    end)
end

registerBroadcastEvent("section", function(msg)
    section = msg
end)