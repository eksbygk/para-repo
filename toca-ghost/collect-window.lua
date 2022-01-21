-- split
function split(str, sep)
    local res = {}
    if str ~= nil then
        if sep == nil then
            sep = "%s"
        end
        for s in string.gmatch(str, "([^" .. sep .. "]+)") do
            table.insert(res, s)
        end
    end
    return res
end

function randerCollectWindows()
    local itemsHtml = {[[<div style="width: 50px;height: 50px;background: url(images/001.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/002.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/003.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/004.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/005.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/006.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/007.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/008.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/009.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/010.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/011.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/012.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/013.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/014.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/015.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/016.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/017.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/018.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/019.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/020.png);"></div>]]}

    local itemsCollected = {[[<div style="width: 50px;height: 50px;background: url(images/01.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/02.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/03.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/04.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/05.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/06.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/07.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/08.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/09.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/10.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/11.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/12.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/13.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/14.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/15.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/16.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/17.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/18.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/19.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/20.png);"></div>]]}

    -- local PositionsA = {10, 65, 120, 175, 230, 285, 340, 395, 450, 505, 560, 615, 670, 725, 780, 835, 890, 945, 1000,
    --                     1055}
    local PositionsA = {110, 165, 220, 275, 330, 385, 440, 495, 550, 605, 660, 715, 770, 825, 880, 935, 990, 1045, 1100,
                        1155}

    local itemWindows = {window(itemsHtml[1], "_lt", PositionsA[1], 15, 70, 70),
                         window(itemsHtml[2], "_lt", PositionsA[2], 15, 70, 70),
                         window(itemsHtml[3], "_lt", PositionsA[3], 15, 70, 70),
                         window(itemsHtml[4], "_lt", PositionsA[4], 15, 70, 70),
                         window(itemsHtml[5], "_lt", PositionsA[5], 15, 70, 70),
                         window(itemsHtml[6], "_lt", PositionsA[6], 15, 70, 70),
                         window(itemsHtml[7], "_lt", PositionsA[7], 15, 70, 70),
                         window(itemsHtml[8], "_lt", PositionsA[8], 15, 70, 70),
                         window(itemsHtml[9], "_lt", PositionsA[9], 15, 70, 70),
                         window(itemsHtml[10], "_lt", PositionsA[10], 15, 70, 70),
                         window(itemsHtml[11], "_lt", PositionsA[11], 15, 70, 70),
                         window(itemsHtml[12], "_lt", PositionsA[12], 15, 70, 70),
                         window(itemsHtml[13], "_lt", PositionsA[13], 15, 70, 70),
                         window(itemsHtml[14], "_lt", PositionsA[14], 15, 70, 70),
                         window(itemsHtml[15], "_lt", PositionsA[15], 15, 70, 70),
                         window(itemsHtml[16], "_lt", PositionsA[16], 15, 70, 70),
                         window(itemsHtml[17], "_lt", PositionsA[17], 15, 70, 70),
                         window(itemsHtml[18], "_lt", PositionsA[18], 15, 70, 70),
                         window(itemsHtml[19], "_lt", PositionsA[19], 15, 70, 70),
                         window(itemsHtml[20], "_lt", PositionsA[20], 15, 70, 70)}

    local collectItemsName = {"杯子", "糖果", "便便", "蝙蝠", "药丸", "硬糖", "挂画", "零食", "花",
                              "苹果", "鸡蛋", "吃剩的苹果", "黑猫玩具", "电池", "鱼骨头", "音符",
                              "金币", "一支笔", "叶子", "害羞的南瓜"}

    registerBroadcastEvent("onclickCollectItem", function(msg)
        msg = commonlib.LoadTableFromString(msg)
        local entity = GameLogic.EntityManager.GetEntity(msg.name)
        local staticTagTable = split(entity:GetStaticTag(), ',')
        if (staticTagTable and staticTagTable[1] == "collect") then
            local index = tonumber(staticTagTable[2])
            itemWindows[index]:CloseWindow()
            itemWindows[index] = window(itemsCollected[index], "_lt", PositionsA[index], 15, 70, 70)
            say("获得：" .. collectItemsName[index])
        end
        wait(1)
        entity:Destroy()
    end)
end

function OnClickBegin()
    -- wait(0.5)
    randerCollectWindows()
    wait(0.2)
    -- stopMovie()
    beginImg:CloseWindow()
    beginBtn:CloseWindow()
    helpBtn:CloseWindow()
end

function OnClickShowHelp()
    helpImg = window([[
    <div style="width: 700px;height: 700px;background: url(images/help-desc.png);"></div>
    ]], "_ct", -350, -350, 700, 700)
    helpImg:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            helpImg:CloseWindow()
        end
    end)
end

beginImg = window([[
<div> 
    <div style="width: 800px;height: 759px;background: url(images/begin.png);"></div>
</div> 
]], "_ct", -400, -380, 800, 759)

beginBtn = window([[
<div> 
    <div style="width: 155px;height: 90px;background: url(images/start.png);" onclick="OnClickBegin"></div>
</div> 
]], "_ct", -290, 80, 155, 90)

helpBtn = window([[
<div> 
    <div style="width: 155px;height: 90px;background: url(images/help.png);" onclick="OnClickShowHelp"></div>
</div> 
]], "_ct", 180, -190, 155, 90)

