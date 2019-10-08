--require("filter")

-- 模式 当value==flag时通过
local flag = true
local pattern = {}
-- 填加，status为真时忽略
local Add = function(name, status, value)
    if (not status) then
        return
    end
    table.insert(pattern, filter.Create(name, value))
    print("filter loaded " .. name)
end

-- 创建项-排除
local Build = function()
    --Add("标题1", 是否生效, "A^X|X^C") ^并且；|或
    Add("飞机", true, "血色飞机|凄凉飞机|航空|血色教堂|航班|专机|刷屏|位面|血色机票|XS飞机|XS机票|私人飞机")
    Add("收货", true, "支持邮寄|长期无限收|/组收|Y收|符文布|魔纹布|铁锭|青铜宝箱")
    Add("公会", true, "公会招人||公会和谐|友爱公会|和谐公会|上班族公会|DKP|GKP|怀旧公会|老公会|新公会|招收稳定|招收|散人|休闲公会|和平饭店|加入我们|入会")
    Add("低级FB", true, "血色教堂|血色墓地|血色武器|奥达曼|ADM|ZUL|剃刀|MLD|TD高地|祖尔法拉|XS墓地")
    Add("低级FB2", true, "XS图书馆|黑暗深渊|拉顿|血色图书馆|死矿|死亡矿|带监狱|带血色|矮子本|诺莫|带教堂|ZUL|武器库|暴风城监狱|神庙")
    Add("各种无聊队", true, "AA|菜刀队|潜行队|任务队|刷刷队")
    Add("低级任务", true, "通缉|激流堡|重铸秩序|达隆郡的战斗|藏尸者|安多哈尔|温德索尔|护送元帅|大地的震颤|破碎岭好战者|救元帅|摩本特|捕捉皇后|一丝希望")
    Add("低级任务2", true, "大地公主|打开钥匙之石")
    Add("低级地图", true, "凄凉之地|诅咒之地|湿地")
    Add("金币交易", true, "小米|收G|大米|大饼|金币交易中心")
    Add("血色组合", true, "血色^教堂|血色^图书|血色^武器|血色^墓地|XS^教堂|XS^图书|XS^武器|XS^墓地")
end

-- 创建项-显示
local Build2 = function()
    flag = false
    --不能多次Add，多次Add不能正常运作
    Add("组队", true, "STSM|黑上|黑下|MC")
end

-- 消息view事件
local chatMessageFilter = function(self, event, message, from, t1, t2, t3, t4, t5, chnum, chname, ...)
    --print(chname)
    for k, v in ipairs(pattern) do
        if (flag == filter.FindAll(message, v.value)) then
            return true
        end
    end
    return false, message, from, t1, t2, t3, t4, t5, chnum, chname, ...
end

-- 短频道
local ChannelShort = function()   
    -- 不晓得怎么写了，强制替换掉大脚世界频道 反正其他频道都安静
    for i = 1, NUM_CHAT_WINDOWS do
        if (i ~= 2) then
            local f = _G["ChatFrame" .. i]            
            local am = f.AddMessage
            f.AddMessage = function(frame, text, ...)               
                return am(frame, string.gsub(text," 大脚世界频道]", " 世]"), ...)
            end
        end
    end
end

-- 启动方法
local Start = function()
    Build()
    ChannelShort()
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", chatMessageFilter)
end

-- 执行开始
Start()
