-- 2楼故障灯
local flag2 = true
local function flicker2()
    while (flag2) do
        setBlock(19579, 15, 19372, 270)
        wait(0.1)
        setBlock(19579, 15, 19372, 0)
        wait(0.1)
        setBlock(19579, 15, 19372, 270)
        wait(0.1)
        setBlock(19579, 15, 19372, 0)
        wait(0.1)
        setBlock(19579, 15, 19372, 270)
        wait(0.5)
        setBlock(19579, 15, 19372, 0)
        wait(0.5)
    end
end

registerBroadcastEvent("clickStopFlicker2", function(msg)
    if (flag2) then
        flag2 = false
        flicker2()
        wait(0.5)
        setBlock(19579, 15, 19372, 0)
        setBlock(19579, 15, 19372, 270)
    else
        flag2 = true
        flicker2()
    end
end)
flicker2(flag2)
