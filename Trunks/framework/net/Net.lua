local listCreator = require "framework.basic.List"
local json = require "framework.basic.Json"

local netHandleManager = require "framework.net.NetHandleManager"

--[[
error 

--]]
local _gCookie = nil
local _gHeaders = {}
NetModel = class()

function NetModel:ctor()
	self._args = nil
	self._args_array = {}
	
	self._url = nil
	self._type = CCHttpRequest.kHttpPost
	self._args = nil
	self._argsFormat = nil
	self._tag = nil
	self._Cookie = nil
	self._GZip = true
	self._Headers = nil
	self._listenerList = listCreator('new')
end

function NetModel:callNet( userlistener, syslistener )
	if not self._args and not self._argsFormat then
		self._args = table.concat(self._args_array, '&')
		self._args_array = {}
	elseif not self._args and self._argsFormat == 'json' then
		self._args = json.encode(self._args_array)
		self._args_array = {}
	end
	
	local hc = CCHttpClient:getInstance()

	local shr = ScriptHttpRequest:new()

	self._Cookie = self._Cookie or _gCookie
	self._Headers = self._Headers or _gHeaders
	-- print('_Cookie:')
	-- print(tostring(self._Cookie))
	if self._Cookie then
		shr:addHeader(tostring(self._Cookie))
	end 
	
	if self._Headers and #self._Headers > 0 then
		for k,v in pairs(self._Headers) do
			shr:addHeader(v)
		end
	end

	if shr.setHeaderGzipEnable and self._GZip then
		shr:setHeaderGzipEnable(SystemHelper:getPlatFormID() ~= 13)
	end

	shr:setUrl(self._url)
	shr:setRequestType(self._type) --setRequestType()
	shr:setRequestData(self._args, string.len(self._args)) --setRequestData()

	if self._tag then
		shr:setTag(self._tag) 
	end

	shr:setResponseScriptCallback(function ( tag, code, errorBuf, data )
		-- body
		local datatable = json.decode(data)

		self._listenerList('for_each', function (func)
			-- body
			func(datatable, tag, code, errorBuf)
		end)

		if syslistener then
			syslistener(datatable, tag, code, errorBuf)
		end

		if not netHandleManager.catchErr(datatable, tag, code, errorBuf) then
			if userlistener then
				userlistener(datatable, tag, code, errorBuf,data)
			end
		end
	end)
	
	hc:send( shr )
	-- print(string.format("luaNetSendRequest:%s%s",shr:getUrl(),tostring(shr:getRequestData())))
	print(string.format("luaNetSendRequest:%s",shr:getUrl()))
	-- hc:packageHttpRequestScript(self._url, self._type, self._args,string.len(self._args), self._tag, self._wait, function(tag, code, errorBuf, data)
	-- end)
end

function NetModel:removeAllListeners()
	self._listenerList('clear')
end

function NetModel:removeListener(listener)
	self._listenerList('remove', listener)
	--table.remove(self._listener, listener)
end

function NetModel:addListener(listener)
	self._listenerList('add', listener)
	--table.insert(self._listener, listener)
end

function NetModel:setUrl(url)
	self._url = url
end

function NetModel:getUrl()
	return self._url
end

function NetModel:setType(pType)
	self._type = pType
end

function NetModel:getType()
	return self._type
end

function NetModel:setTag(tag)
	self._tag = tag
end

function NetModel:getTag()
	return self._tag
end

function NetModel:addArg(key, value)
	print(string.format("Arg:%s=%s",key,value))
	if not self._argsFormat then
		table.insert(self._args_array, string.format('%s=%s', key, string.urlencode(tostring(value))))
	elseif self._argsFormat == 'json' then
		self._args_array[key] = value
	end
end

function NetModel:setArgsFormat( format )
	self._argsFormat = format
end

function NetModel:setCookie( content )
	self._Cookie = content
end

function NetModel:setGCookie( content )
	_gCookie = content
end

function NetModel:setGZipEnable( enable )
	self._GZip = enable
end

function NetModel:clearGHeaders( ... )
	_gHeaders = {}
end

function NetModel:addGHeaders( key,value )
	_gHeaders = _gHeaders or {}
	table.insert(_gHeaders,string.format('%s:%s',key,value))
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(NetModel, 'NetModel')