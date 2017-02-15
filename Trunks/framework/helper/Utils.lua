local print = print
local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep
local type = type
local pairs = pairs
local tostring = tostring
local next = next
local coroutine = coroutine

-- print('require utils!')
-- print(debug.traceback())

local utils = {}

utils.dump = function ( root )
	-- body
	assert(type(root) == "table")

	local cache = {  [root] = "." }
	local function _dump(t,space,name)
		local temp = {}
		for k,v in pairs(t) do
			local key = tostring(k)
			if cache[v] then
				tinsert(temp,"+" .. key .. " {" .. cache[v].."}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
			else
				if type(v) == 'string' then
					tinsert(temp,"+" .. key .. " ['" .. tostring(v).."'']")
				else
					tinsert(temp,"+" .. key .. " [" .. tostring(v).."]")
				end
				
			end
		end
		return tconcat(temp,"\n"..space)
	end

	return _dump(root, "","")
end

utils.print = function ( root )
	local myType = type(root)

	if myType == 'table' then
		print( '\n'..utils.dump(root) )
	elseif myType == 'userdata' then
		print( 'userdata:'..tolua.type(root) )
	elseif myType ~= 'string' then
		print( tostring(root) )
	else
		print(root)
	end
end

utils.sleep = function( delay)
	local co = coroutine.running()
	local handler
	local continueFunc
	
	continueFunc = function()
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handler)
		coroutine.resume(co)
	end
	
	handler = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(continueFunc, delay, false)
	
	coroutine.yield()
end

utils.delay = function(func, delay, node)
	local action = ElfDelay:create(delay or 0)
	action:setListener(func)
	
	if not node then
		node = CCDirector:sharedDirector():getRunningScene()
	end
	
	if node and not tolua.isnull(node) then
		node:runAction(action)
	end
	
end

local abnormal_types = {
	['manifest'] = 'ElfLayer',
	['CCActionData'] = 'ElfAction',
	[''] = 'ElfAction',
	['ListScrollNode'] = 'BarNode'
	-- ['InputTextNode'] = 'ElfEditBox', 
}

setmetatable(abnormal_types, {__index = function (t,k)
		return k
	end})

utils.toluaSet = function ( ccset )
	-- body
	assert(tolua.type(ccset) == 'NodeSet')

	local luaset = {}

	local array = ccset:getKeys()
	local count = array:count()

	for i=0,count-1 do
		local cckey = array:objectAtIndex(i)
		tolua.cast(cckey, 'CCString')
		local key = cckey:getCString()
		
		local type = ccset:getType(key)

		local expression = 'get'..tostring(abnormal_types[type])

		if not ccset[expression] then print('unexpression:'..expression) end
		assert(ccset[expression]~=nil, expression)

		local obj = ccset[expression](ccset, key)

		assert(obj~=nil, key..':'..type..':'..debug.traceback())

		luaset[key] = obj
	end

	local rootType = ccset:getRootType()
	local rootExpression = 'getRoot'..tostring(abnormal_types[rootType])

	assert(ccset[rootExpression]~=nil, rootExpression)

	local rootObj = ccset[rootExpression](ccset)

	assert(rootObj~=nil, rootType..':'..rootExpression..':'..debug.traceback())
	
	luaset[1] = rootObj
	luaset[2] = ccset

	return luaset
end

utils.toluaset = utils.toluaSet

utils.getUUID = function ()
	
end

utils.writeTableToFile = function ( ptable, filename, abs)
	-- body
	local getTableArray
	getTableArray = function (ptable, parray, ptableset) 
		if type(ptable) == 'table' then
			if not ptableset[ptable] then
				ptableset[ptable] = true

				for i, v in pairs(ptable) do 
					getTableArray(v, parray, ptableset)
				end

				table.insert(parray, ptable)
				ptableset[ptable] = #parray
			end
		end
	end

	local table_array = {}
	local table_set = {}

	getTableArray(ptable, table_array, table_set)

	local output = {}
	-- table.insert(output, 'local ret = {}')

	for i, v in ipairs(table_array) do 

		table.insert(output, string.format('local _tab_%d = {}', i))

		for ii, vv in pairs(v) do
			local iitype = type(ii)
			local vvtype = type(vv)

			local iistring 
			local vvstring

			if iitype == 'string' then
				iistring = '\''..tostring(ii)..'\''
			elseif iitype == 'number' or iitype == 'boolean' then
				iistring = tostring(ii)
			else
				error('unexpected type: '..iitype..' on writeTableToFile!')
			end

			if vvtype == 'string' then
				vvstring = '\''..tostring(vv)..'\''
			elseif vvtype == 'number' or vvtype == 'boolean' then
				vvstring = tostring(vv)
			elseif vvtype == 'table' then
				local index = table_set[vv]
				assert(index < i)
				vvstring = string.format('_tab_%d', index)
			else
				error('unexpected type: '..iitype..' on writeTableToFile!')
			end

			table.insert(output, string.format('_tab_%d[%s] = %s', i, iistring, vvstring))
		end
		table.insert(output, '\n')
	end

	table.insert(output, string.format('return _tab_%d', #table_array))

	local content = table.concat(output, '\n')
	print('------write-------')
	print(content)
	print('------------------')

	require 'framework.sync.FileHelper'.write(filename, content, abs)
end

utils.readTableFromFile = function ( filename, abs)
	-- body
	local content = require 'framework.sync.FileHelper'.read(filename, abs)

	print('-------read-------')
	print(content)
	print('------------------')
	
	if content then
		return loadstring(content)()
	end
end


local copyTable
copyTable = function ( data )
	-- body
	assert( type(data) == 'table' )

	local ret = {}

	for i,v in pairs(data) do
		if type(v) == 'table' then
			ret[i] = copyTable(v)
		else
			ret[i] = v
		end
	end

	return ret
end

utils.copyTable = copyTable

--[[
计算运行时间差值
--]]
utils.calcDeltaTime = function ( func, message )
	-- body
	print('------------------准备计算时间--------------------')
	local a = SystemHelper:currentTimeMillis()
	local ret = func()
	local b = SystemHelper:currentTimeMillis()
	print(string.format('%s = %d (ms)!', tostring(message), (b-a)))
	return ret
end

utils.dumpSnapShot = function ()
	-- body
	local Snapshot = require 'snapshot'
	return Snapshot.snapshot()
end

utils.printSnapShot = function ( s1, s2 )
	-- body
	print('------------------------SnapShot----------------------')
	for k,v in pairs(s2) do
		if s1[k] == nil then
			print( string.format('key=%s, value=%s', tostring(k),tostring(v)))
		end
	end
	print('-------------------------------------------------------')
end

utils.printG = function ()
	-- body
	print('----------------------------G--------------------------')
	for i, v in pairs( _G ) do
		print(string.format('Key:t=%s,v=%s, Value:t=%s,v=%s.', type(i), tostring(i), type(v), tostring(v)))
	end
	print('-------------------------------------------------------')
end


return require 'framework.basic.MetaHelper'.createShell( utils )