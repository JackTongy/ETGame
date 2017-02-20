local GVCHelper = {}
local self = {}

GVCHelper.setLocalVersion = function ( localVersion )
	-- body
	self._localVersion = localVersion
end

GVCHelper.getLocalVersion = function ()
	-- body
	return self._localVersion or 0
end

GVCHelper.setServerVersion = function ( localVersion )
	-- body
	self._serverVersion = localVersion
end

GVCHelper.getServerVersion = function ()
	-- body
	return self._serverVersion or 0
end

return GVCHelper