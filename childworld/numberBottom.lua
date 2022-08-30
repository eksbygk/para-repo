local cardSize = {
    width = 159,
    height = 238
}
local numCards = {}
for i = 1, 9 do
    numCards[i] = {
        index = i,
        bottom = 0,
        left = 10,
        width = cardSize.width,
        height = cardSize.height
    }
end

function getNumCards()
    return numCards
end

function getStyle(index)
    local card = numCards[index]
    local styleStr = string.format(
        "margin-left:%s;margin-bottom:%s;width:%s;height:%s;background: url(images/number/%s.png)", card.left,
        card.bottom, card.width, card.height, card.index)
    return styleStr
end

local numbersWnd = window([[ 
<div style="margin:200px;margin-top:0;">
<pe:repeat DataSource="<%=getNumCards()%>">
    <pe:repeatitem style="float:left;">
        <div name='<%=Eval("name")%>' style='<%=getStyle(Eval("index"))%>' onclick="OnClickTest2" value='<%=Eval("name")%>'></div> 
    </pe:repeatitem>
</pe:repeat>
</div>
]], "_ctb", 0, -20, 1921, 238)
numbersWnd:SetDesignResolution(1921, 238)

function OnClickTest2(name, mcmlNode)
    tip(name)
end
