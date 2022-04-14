say("我是一只老鼠")
local position = 1
registerClickEvent(function()
    if (position == 1) then
        move(-1, 0, 5, 0.5)
        position = 2
    elseif (position == 2) then
        move(1, 0, 7, 0.5)
    end

end)
