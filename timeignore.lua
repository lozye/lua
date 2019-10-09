-- 日期忽略
timeignore = {}
function timeignore:new(expire_s)
    _temp = {}
    setmetatable(_temp, self)
    self.__index = self
    --wow 获取世界方法
    self.time = GetTime()    
    self.hash = {}
    self.expire = expire_s
    return _temp
end

-- 尝试添加，为false表示拦截
function timeignore:add(text)
    local tick = GetTime()   
    if (tick - self.time > self.expire) then
        self.hash = {}
        self.time = tick
    end
    if (self.hash[text]) then
        return false
    else
        self.hash[text] = true
        return true
    end
end
