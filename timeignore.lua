-- 日期忽略
timeignore = {}
function timeignore:new(expire_s)
    expire_s = expire_s or 30
    _temp = {time = os.time(), hash = {}, expire = expire_s}
    setmetatable(_temp, self)
    self.__index = self
    return _temp
end

-- 尝试添加，为false表示拦截
function timeignore:add(text)
    local tick = os.time()
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
