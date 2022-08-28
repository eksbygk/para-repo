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

local clickTime = 1 -- 记录第几次点击

function clickNumber(i, mcmlNode)
    local num = tonumber(mcmlNode:GetAttribute("param"))
    tip(num)
end
