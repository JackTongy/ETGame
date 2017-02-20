local AccountInfo = {}

local _serverInfo
local _curServer
local _roleInfo
local _sdkToken
local _sdkUid
local _QsDone = false
local _authData
local _pushToken
local _Guest = false
local _BindAction = false
local _loginoutFunc = false

function AccountInfo.setServerInfo( serverinfo )
	_serverInfo = serverinfo
end

function AccountInfo.getServerInfo( ... )
	return _serverInfo
end

function AccountInfo.setCurrentServer( server )
	_curServer = server
end

function AccountInfo.getCurrentServer( ... )
	return _curServer
end

function AccountInfo.getCurrentServerID( ... )
	return (_curServer and _curServer.Id) or 0
end

function AccountInfo.getCurrentServerUTCOffset( ... )
	return (_roleInfo and _roleInfo.UtcOffSet) or 8*60*60
end

function AccountInfo.isValid( ... )
	return _curServer
end

function AccountInfo.setRoleInfo( roleinfo )
	_roleInfo = roleinfo
end

function AccountInfo.getRoleInfo( ... )
	return _roleInfo
end

function AccountInfo.getRoleId( ... )
	return _roleInfo and _roleInfo.Id
end

function AccountInfo.setSdkToken( token )
	_sdkToken = token
end

function AccountInfo.setSdkUid( Uid )
	_sdkUid = Uid
end

function AccountInfo.getSdkToken( ... )
	return _sdkToken
end

function AccountInfo.getSdkUid( ... )
	return _sdkUid
end

function AccountInfo.setQsDone( enable )
	_QsDone = enable
end

function AccountInfo.getQsDone( ... )
	return _QsDone
end

function AccountInfo.getAuthData( ... )
	return _authData
end

function AccountInfo.setAuthData( authData )
	_authData = authData
end

function AccountInfo.setPushToken( token )
	_pushToken = token
end

function AccountInfo.getPushToken( ... )
	return _pushToken
end

function AccountInfo.setGuest( flag )
	_Guest = flag
end

function AccountInfo.isGuest( )
	return _Guest
end

function AccountInfo.setBindAction( flag )
	_BindAction = flag
end

function AccountInfo.isBindAction( ... )
	return _BindAction
end

function AccountInfo.setLogOutFunc( callback )
	_loginoutFunc = callback
end

function AccountInfo.getLogOutFunc( ... )
	return _loginoutFunc	
end

return AccountInfo