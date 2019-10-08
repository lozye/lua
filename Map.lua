--meta classs
Map={}
function Map:new()
    result={};
    setmetatable(result, self)
    self.__index = self;
    return result;
end
return Map;