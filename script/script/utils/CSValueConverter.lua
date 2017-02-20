local CSValueConverter = {}

function CSValueConverter.toC( serverValue )
	-- body
	-- assert(serverValue)
	assert( type(serverValue) == 'nil' or type(serverValue) == 'number' )

	return (serverValue and serverValue * 13 + 17)

	-- return serverValue
end

function CSValueConverter.toCDefault( serverValue, default )
	-- body
	-- assert(serverValue)
	assert( type(serverValue) == 'nil' or type(serverValue) == 'number' )
	serverValue = serverValue or default

	return (serverValue and serverValue * 13 + 17)

	-- return serverValue or default
end

function CSValueConverter.toS( clientValue )
	-- body
	-- assert(clientValue)
	assert( type(clientValue) == 'nil' or type(clientValue) == 'number' )

	return (clientValue and ((clientValue - 17) / 13))

	-- return clientValue
end

function CSValueConverter.toCHp( serverValue )
	-- body
	-- assert(serverValue)
	assert( type(serverValue) == 'nil' or type(serverValue) == 'number',  tostring( serverValue ) )

	return (serverValue and serverValue * 2)

	-- return serverValue
end

function CSValueConverter.toSHp( clientValue )
	-- body
	-- assert(clientValue)
	assert( type(clientValue) == 'nil' or type(clientValue) == 'number', tostring( clientValue ) )

	return (clientValue and ((clientValue) / 2))

	-- return clientValue
end


function CSValueConverter.shouldConvert( isOhter )
	-- body
	local ServerRecord = require 'ServerRecord'

	if ServerRecord.isArenaMode() or ServerRecord.getMode() == 'guildboss' then
		return false
	end

	local mode = ServerRecord.getMode()

	if mode == 'guider' then
		return false
	end

	return not isOhter
end


return CSValueConverter

