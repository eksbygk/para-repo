local html = [[
    <div style="margin:200px;margin-top:0;">
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/1.png);" onclick="clickNumber" param="1"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/2.png);" onclick="clickNumber" param="2"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/3.png);" onclick="clickNumber" param="3"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/4.png);" onclick="clickNumber" param="4"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/5.png);" onclick="clickNumber" param="5"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/6.png);" onclick="clickNumber" param="6"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/7.png);" onclick="clickNumber" param="7"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/8.png);" onclick="clickNumber" param="8"></span>
        <span style="margin-left:10;width: 159;height: 238;background: url(images/number/9.png);" onclick="clickNumber" param="9"></span>
    </div>
]]
-- (159 + 10)* 9 = 1521,1521 + 200 * 2 = 1921 (如修改尺寸，需要改这个)
local numbersWnd = window(html, "_ctb", 0, -20, 1921, 238)
numbersWnd:SetDesignResolution(1921, 238)
numbersWnd:hide()
-- Fisher–Yates shuffle 洗牌
function getRandomNums()
    local nums = {1, 2, 3, 4, 5, 6, 7, 8, 9}
    for i = 9, 1, -1 do
        local randomIndex = math.random(1, i)
        nums[randomIndex], nums[i] = nums[i], nums[randomIndex]
    end
    return nums
end

local randomNums = {}
local randomNumsWnd = {}
local started = false
function initGame()
    started = false
    randomNums = getRandomNums()
    local randomNumsHtml = ''
    for i = 1, 4 do
        randomNumsHtml = randomNumsHtml ..
                             [[<span style="margin-left:20px;width: 159px;height: 238px;background: url(images/number/]] ..
                             randomNums[i] .. [[.png);"></span>]]
    end
    -- (159 + 20)* 4 = 716, /2 = 358 (需要改这个)
    -- 238/2 = 119 (需要改这个)
    randomNumsWnd = window(randomNumsHtml, "_ct", -358, -119, 1600, 238)
    randomNumsWnd:SetDesignResolution(1600, 238)
    time = 3
    local html = [[
        <div style="color:red;">将在 <%=time%>秒后消失</div>
    ]]

    local wnd = window(html, "_ct", 0, 100, 100, 50)
    numbersWnd:hide()
    for i = 2, 0, -1 do
        wait(1)
        time = i
        wnd:CloseWindow()
        wnd = window(html, "_ct", 0, 100, 100, 50)
    end
    wnd:CloseWindow()
    numbersWnd:show()
    randomNumsWnd:CloseWindow()
    started = true
end

initGame()

local clickTime = 1 -- 记录第几次点击
function clickNumber(i, mcmlNode)
    if not started then
        return
    end
    local num = tonumber(mcmlNode:GetAttribute("param"))
    tip(num)
    if randomNums[clickTime] == num then
        tip('正确')
        if clickTime == 4 then
            broadcast("score", "")
            clickTime = 1
            initGame()
        else
            clickTime = clickTime + 1
        end
    else
        tip('错了')
        clickTime = 1
        initGame()
    end
end
