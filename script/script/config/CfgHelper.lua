local CfgHelper = {}

local Cache = {}
local ArrayCache = {}

local LogCache = {}

local function err( tablename, keym, valuem, key )
	-- body
	local msg = string.format('Not found t=%s, km=%s, vm=%s, k=%s', tostring(tablename), tostring(keym), tostring(valuem), tostring(key))
	error(msg)
end

local function out( tablename, keym, valuem, key  )
	-- body
	local msg = string.format('Not found t=%s, km=%s, vm=%s, k=%s', tostring(tablename), tostring(keym), tostring(valuem), tostring(key))
	if not LogCache[msg] then
		LogCache[msg] = true
		print(msg)
	end
end

function CfgHelper.get( tablename, keym, valuem, key )
	-- body
	local cfg = require(tablename)
	if not cfg then
		return err( tablename, keym, valuem, key )
	end

	for i,v in ipairs(cfg) do
		if v[keym] == valuem then
			if key then
				return v[key]
			else
				return v
			end
		end
	end

	return err( tablename, keym, valuem, key )
end

function CfgHelper.getCache( tablename, keym, valuem, key )
	-- body
	local cfg = require(tablename)
	if not cfg then
		return err( tablename, keym, valuem, key )
	end

	Cache[tablename] = Cache[tablename] or {}

	--make Cache
	if not Cache[tablename][keym] then
		local map = {}
		Cache[tablename][keym] =  map
		for i,v in ipairs(cfg) do
			local myvaluem = v[keym]
			if myvaluem then
				map[myvaluem] = v
			end
		end
	end

	local item =  Cache[tablename][keym][valuem]

	-- item = item or Cache[tablename][keym][valuem]

	if item then
		if key then
			return item[key]
		else
			return item
		end
	end

	return out( tablename, keym, valuem, key )
end

--[[
return Vo Array
--]]
function CfgHelper.getCacheArray( tablename, keym, valuem )
	local cfg = require(tablename)
	if not cfg then
		return err( tablename, keym, valuem, key )
	end

	ArrayCache[tablename] = ArrayCache[tablename] or {}

	--make Cache
	if not ArrayCache[tablename][keym] then
		local map = {}
		ArrayCache[tablename][keym] =  map

		for i,v in ipairs(cfg) do
			local myvaluem = v[keym]
			if myvaluem then
				local array = map[myvaluem] or {}
				map[myvaluem] = array

				table.insert(array, v)

				if myvaluem == valuem then
					item = array
					-- break
				end
			end
		end
	end

	local item = ArrayCache[tablename][keym][valuem]

	if item then
		return item
	end

	return out( tablename, keym, valuem )
end

function CfgHelper.makeCache( tablename, keym )
	-- body
	local cfg = require(tablename)
	if not cfg then
		return err( tablename, keym, valuem, key )
	end

	Cache[tablename] = Cache[tablename] or {}
	Cache[tablename][keym] = Cache[tablename][keym] or {}

	local t = Cache[tablename][keym]
	for i,v in ipairs(cfg) do
		local kv = v[keym] 
		if kv then
			t[kv] = v
		end
	end

end

return CfgHelper