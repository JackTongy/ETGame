function table.nums(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

function table.keys(t)
    local keys = {}
    for k, v in pairs(t) do
        keys[#keys + 1] = k
    end
    return keys
end

function table.values(t)
    local values = {}
    for k, v in pairs(t) do
        values[#values + 1] = v
    end
    return values
end

function table.merge(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
end

--[[--

insert list.

**Usage:**

    local dest = {1, 2, 3}
    local src  = {4, 5, 6}
    table.insertTo(dest, src)
    -- dest = {1, 2, 3, 4, 5, 6}
	dest = {1, 2, 3}
	table.insertTo(dest, src, 5)
    -- dest = {1, 2, 3, nil, 4, 5, 6}


@param table dest
@param table src
@param table begin insert position for dest
]]
function table.insertTo(dest, src, begin)
	begin = tonumber(begin)
	if begin == nil then
		begin = #dest + 1
	end

	local len = #src
	for i = 0, len - 1 do
		dest[i + begin] = src[i + 1]
	end
end

--[[
search target index at list.

@param table list
@param * target
@param int from idx, default 1
@param bool useNaxN, the len use table.maxn(true) or #(false) default:false
@param return index of target at list, if not return -1
]]
function table.indexOf(list, target, from, useMaxN)
	local len = (useMaxN and #list) or table.maxn(list)
	if from == nil then
		from = 1
	end
	for i = from, len do
		if list[i] == target then
			return i
		end
	end
	return -1
end

function table.indexOfKey(list, key, value, from, useMaxN)
	local len = (useMaxN and #list) or table.maxn(list)
	if from == nil then
		from = 1
	end
	local item = nil
	for i = from, len do
		item = list[i]
		if item ~= nil and item[key] == value then
			return i
		end
	end
	return -1
end

function table.removeItem(t, item, removeAll)
    for i = #t, 1, -1 do
        if t[i] == item then
            table.remove(t, i)
            if not removeAll then break end
        end
    end
end

function table.map(t, fun)
    for k,v in pairs(t) do
        t[k] = fun(v, k)
    end
end

function table.walk(t, fun)
    for k,v in pairs(t) do
        fun(v, k)
    end
end

function table.filter(t, fun)
    for k,v in pairs(t) do
        if not fun(v, k) then
            t[k] = nil
        end
    end
end

function table.find(t, item)
    return table.keyOfItem(t, item) ~= nil
end

function table.unique(t)
    local r = {}
    local n = {}
    for i = #t, 1, -1 do
        local v = t[i]
        if not r[v] then
            r[v] = true
            n[#n + 1] = v
        end
    end
    return n
end

function table.keyOfItem(t, item)
    for k,v in pairs(t) do
        if v == item then return k end
    end
    return nil
end

function table.clone( t )
    local ret = {}
    for k,v in pairs(t) do
        if type(v) == "table" then
            ret[k] = table.clone(v)
        else
            ret[k] = v
        end
    end
    return ret
end