local Setting = {}
local userdefault = CCUserDefault:sharedUserDefault()

function Setting.getBoolForKey( key )
	return userdefault:getBoolForKey(key)
end

function Setting.getIntegerForKey( key )
	return userdefault:getIntegerForKey(key)
end

function Setting.getFloatForKey( key )
	return userdefault:getFloatForKey(key)
end

function Setting.getDoubleForKey( key )
	return userdefault:getDoubleForKey( key )
end

function Setting.getStringForKey( key )
	return userdefault:getStringForKey(key)
end

function Setting.setBoolForKey( key, value )
	return userdefault:setBoolForKey(key, value)
end

function Setting.setIntegerForKey( key, value )
	return userdefault:setIntegerForKey(key, value)
end

function Setting.setFloatForKey( key, value )
	return userdefault:setFloatForKey(key, value)
end

function Setting.setDoubleForKey( key, value )
	return userdefault:setDoubleForKey(key, value)
end

function Setting.setStringForKey( key, value )
	return userdefault:setStringForKey(key, value)
end

function Setting.flush( )
	return userdefault:flush()
end

return require 'framework.basic.MetaHelper'.createShell(Setting)
