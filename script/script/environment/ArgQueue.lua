local ArgQueue = {}
local data = {}

local _lastArg = nil

function ArgQueue.getHead( ... )
	return data[1]
end

function ArgQueue.getTail( ... )
  
	local size = #data
	if size > 0 then
		return data[size]
	end
	return nil
  
end

function ArgQueue.enqueue( arg )
	-- print('ArgQueue.enqueue '..#data)
	-- print(arg)
	table.insert(data,arg)
end

function ArgQueue.dequeue( ... )
	-- print('ArgQueue.dequeue '..#data)
	-- print(debug.traceback())
  
	local arg = data[1]
	if arg then
		_lastArg = arg
		table.remove(data,1)
	end
	return arg
  
end

function ArgQueue.clear( ... )
	-- print('ArgQueue.clear ' ..#data)
	data = {}
end

function ArgQueue.getData( ... )
	return data
end

function ArgQueue.getLast( ... )
	return _lastArg
end

return ArgQueue