local Record = {}
Record._data = {}

-- Record
Record.reset = function ()
	-- body
	Record._data = {}
end

Record.setServerVersion = function ( name, version )
	-- body
	Record._data[name] = Record._data[name] or {}

	Record._data[name].serverVersion = version

	Record._data[name].time = os.time()
end

Record.setLocalVersion = function ( name, version )
	-- body
	Record._data[name] = Record._data[name] or {}

	Record._data[name].localVersion = version
end

Record.getServerVersion = function ( name )
	-- body
	Record._data[name] = Record._data[name] or {}

	return Record._data[name].serverVersion
end

Record.getLocalVersion = function ( name )
	-- body
	Record._data[name] = Record._data[name] or {}

	return Record._data[name].localVersion
end

Record.toString = function (  )
	-- body
	local array = {}

	for i,v in pairs(Record._data) do
		local str = string.format('%s:s=%d, l=%d, t=%s.', i, v.serverVersion, v.localVersion, tostring(v.time))
		table.insert(array, str)
	end

	return table.concat(array, '\n')
end

return Record