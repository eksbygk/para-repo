local function OnClickTest()
    print(12345)
end

local beginBtn = window(
    [[<div style="width: 100px;height: 100px;background: url(images/1.png);" onclick="OnClickTest"></div>]], "_ct", 50,
    50, 100, 100)
