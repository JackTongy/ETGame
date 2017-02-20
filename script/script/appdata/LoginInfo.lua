local LoginInfo = {}

local _data

function LoginInfo.setData( data )
	_data = data
end

function LoginInfo.getData( ... )
	return _data
end

function LoginInfo.cleanData( ... )
	_data = nil
end

function LoginInfo.updateNDInfo( Nd )
	if _data and Nd then
		_data.Nd = Nd
	end
end

function LoginInfo.updateNEInfo( Ne )
	if _data and Ne then
		_data.Ne = Ne
	end
end

function LoginInfo.getTaskMain( ... )
	return _data and _data.TaskMainList
end

function LoginInfo.updateTaskMain( tasks )
	if _data then
		_data.TaskMainList = tasks
	end
end

return LoginInfo