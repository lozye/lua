require("filter")

-- 模式 当value==flag时通过
local flag = true
local pattern = {}
-- 填加，status为真时忽略
local Add = function(name, status, value)
    if (not status) then
        return
    end
    table.insert(pattern, filter.Create(name, value))
end
-- 创建项
local Build = function()
    --Add("标题1", 是否生效, "A^X|X^C") ^并且；|或
    Add("标题2", true, "ABC")
end
-- 启动方法
local Start = function()
    Build()
    local body = function(message)
        for k, v in ipairs(pattern) do
            if (flag == filter.FindAll(message, v.value)) then
                return true
            end
        end
        return false
    end
    print(body("ACBACB"))
end
-- 执行开始
Start()
