filter = {}
-- 判断是否包含，pattern支持正则
local Find = function(input, pattern)
    local _match = string.find(input, pattern)
    return _match ~= nil
end
-- 字符串分割
local Split = function(input, ch)
    local _temp = {}
    for item in string.gmatch(input, "([^'" .. ch .. "']+)") do
        table.insert(_temp, item)
    end
    return _temp
end
-- 判断是否包含，pattern支持正则
local FindAnd = function(input, pattern)
    local _lst = Split(pattern, "^")
    for k, v in ipairs(_lst) do
        if (Find(input, v) ~= true) then
            return false
        end
    end
    return true
end
-- 创建一个匹配模型
filter.Create = function(name, value)
    local _temp = {name = name, value = value}
    return _temp
end
-- 判断是否包含，pattern支持正则
filter.FindAll = function(input, pattern)
    local _lst = Split(pattern, "|")
    for k, v in ipairs(_lst) do
        if (FindAnd(input, v)) then
            return true
        end
    end
    return false
end
return filter
