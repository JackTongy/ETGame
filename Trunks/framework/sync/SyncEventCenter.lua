local center = {}
center.map = {}
center.group = {}

function center.addEventFunc( event, func, group )
	-- body
	assert(event)
	assert(func)

	center.map[event] = center.map[event] or {}

	local array = center.map[event]
	array[func] = true

--	assert(group == 'Fight')

	if group then
		center.group[group] = center.group[group] or {}
		local map = center.group[group]
		table.insert(map, {event=event, handle = func} )
	end

	return func
end

function center.removeEventFunc( event, handle )
	-- body
	assert(event)
	assert(handle)
	center.map[event] = center.map[event] or {}

	local array = center.map[event]
	array[handle] = nil
end

function center.eventInput( event, ... )
	-- body
	assert(event)

	local mymap = center.map[event]
	if mymap then
		for func,v in pairs(mymap) do
			local ret = func(...)
			if ret then
				return ret
			end
		end
	else
		-- assert(event)
		print('No handle to deal with this event '.. tostring(event))
	end
end

function center.resetGroup( group )
	-- body
	
	assert(group)
	
	-- print('-----------center.resetGroup------------')
	-- print(debug.traceback())
	local map = center.group[group]

	if map then
		for i, item in ipairs(map) do
			center.removeEventFunc(item.event, item.handle)
		end

		center.group[group] = {}
	end
end

function center.getEvents( group )
	return center.group[group]
end

return center