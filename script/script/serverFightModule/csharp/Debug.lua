local raw_require 	= require
local raw_print 	= print
local raw_assert 	= assert
local raw_error 	= error
local raw_type 			= type

local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep


local PrintEnable = true

local function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local RequireMap
local function setRequireMap( requireMap )
	-- body
	RequireMap = requireMap
end

local function getFullRequire( name )
	-- body
	return (RequireMap and (RequireMap[name] or name)) or name
end

local Dump
Dump = function ( root )
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

	return '\n'.._dump(root, "","")
end

local PrintTable
PrintTable = function ( root )
	if PrintEnable then
		local myType = type(root)

		if myType == 'table' then
			-- raw_print('\n')
			raw_print( Dump(root) )
		elseif myType == 'userdata' then
			raw_print( 'userdata:'..tolua.type(root) )
		elseif myType ~= 'string' then
			raw_print( tostring(root) )
		else
			raw_print(root)
		end

	end
end

-- local MainPrint = function ( ... )
-- 	-- body
-- 	local arg = {...}

-- 	for i,v in ipairs( arg ) do
-- 		PrintTable(v)
-- 	end
-- end

local RequireTimeStack 		= {}
local RequireTimeCountStack = {}

local function setDebug(enable)
	if enable then
		require = function ( name )
			-- body
			name = getFullRequire(name)

			local loaded = package.loaded[name]
			if loaded then
				return loaded
			else

				table.insert(RequireTimeStack, SystemHelper:currentTimeMillis())
				table.insert(RequireTimeCountStack, 0)

				-- core load
				print(string.format('load %d:%s', #RequireTimeStack, name))
				local raw_ret = raw_require(name)

				local deep = #RequireTimeStack

				local t1 = RequireTimeStack[deep]
				table.remove(RequireTimeStack, deep)

				local t2 = SystemHelper:currentTimeMillis()

				local total = (t2-t1)
				local count = RequireTimeCountStack[deep]
				local cost = (total-count)

				for i=1, deep do
				 	RequireTimeCountStack[i] = RequireTimeCountStack[i] + cost
				end

				-- print(string.format('load %s cost = %d.', name, cost))
				-- print(string.format('load %s total = %d.', name, total))

				table.remove(RequireTimeStack, deep)
				table.remove(RequireTimeCountStack, deep)

				if raw_ret then
					return raw_ret
				else
					print('============load track=============')
					print('load:'..name..' failed!')
					print(debug.traceback())
					print('=====================================')
				end

			end
		end

		print = PrintTable

		assert = function (condition, msg)
			-- body
			if not condition then
				print('============assert track=============')
				print(debug.traceback())
				print('=====================================')

				print(msg)

				raw_assert(condition, tostring(msg))
			end
		end

		error = function ( message, level )
			-- body
			print('=============error track=============')
			print(debug.traceback())
			raw_error(message, level)
			print('=====================================')
		end
	else
		require = raw_require
		print = raw_print
		assert = raw_assert
		error = raw_error
	end
end

setDebug(true)

debug.catch = function ( condition, msg )
	-- body
	if condition then
		print('----cacth-----')
		print(msg)
		print(debug.traceback())
	end
end

debug.setPrintOpen = function ( enable )
	-- body
	PrintEnable = enable
end

return { setDebug = setDebug, setRequireMap = setRequireMap }
