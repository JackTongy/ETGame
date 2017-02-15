local settings = {}

local function setErrHandle(func)
	settings._errHandle = func
end

local function getErrHandle()
	-- body
	return settings._errHandle
end

local function catchErr( datatable, tag, code, errorBuf)
	-- body
	local errHandle = settings._errHandle
	if errHandle then
		return errHandle(datatable, tag, code, errorBuf)
	end

	return nil
end

settings.setErrHandle = setErrHandle
settings.getErrHandle = getErrHandle
settings.catchErr = catchErr

return require 'framework.basic.MetaHelper'.createShell(settings)