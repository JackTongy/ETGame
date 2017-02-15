-- print('abcdefg')
local handlerManage = {}

local function setResponseHandler( handler )
	-- body
	handlerManage._responseHandler = handler
end

local function catchResponse( data )
	-- body
	local handler = handlerManage._responseHandler
	if handler then
		return handler(data)
	end
end

local function setErrHandler( handler )
	-- body
	handlerManage._errHandler = handler
end

local function catchErr( data )
	-- body
	local handler = handlerManage._errHandler
	if handler then
		return handler(data)
	end
end

handlerManage.setResponseHandler = setResponseHandler
handlerManage.catchResponse = catchResponse

handlerManage.setErrHandler = setErrHandler
handlerManage.catchErr = catchErr

return handlerManage