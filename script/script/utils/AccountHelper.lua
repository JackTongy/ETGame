local Indicator = require 'DIndicator'
require 'framework.net.Net'
local AccountInfo = require 'AccountInfo'

-- local mode = require 'script.gvc.GVCPublish'.mode
-- local ACCONFIG

-- if mode == 'develop' then
-- 	ACCONFIG = 
-- 	{
-- 		SKEY='c9d7614ae19a6021d227b114d6c4f31a',
-- 		AUTHURL='http://192.168.1.213:81',
-- 		INFOURL='http://192.168.1.213:82',
-- 		-- AUTHURL='http://dev.api.server.rk.pk.mosoga.net:8080',
-- 		-- INFOURL='http://dev.api.server.rk.pk.mosoga.net',
-- 		PlatformId=1,
-- 		ChannelId=1,
		
-- 		ChannelName="rekoo",
-- 		Rk_Channel = 9
-- 	}
-- else
-- 	ACCONFIG = 
-- 	{
-- 		SKEY='c9d7614ae19a6021d227b114d6c4f31a',
-- 		AUTHURL='http://center.server.api.mrglee.net:8080',
-- 		INFOURL='http://center.server.api.mrglee.net',
-- 		-- AUTHURL='http://dev.api.server.rk.pk.mosoga.net:8080',
-- 		-- INFOURL='http://dev.api.server.rk.pk.mosoga.net',

-- 		PlatformId=require "AndroidUtil".getPlatformID(),
-- 		ChannelId=require "AndroidUtil".getChannelID(),
-- 		ChannelName=require "AndroidUtil".getChannelName(),
-- 		Rk_Channel = require "AndroidUtil".getRkChannelID()
-- 		-- ChannelName = "rekoo"
-- 	}
-- end

-- print(ACCONFIG)		

-- local ACCONFIG = 
-- {
-- 	SKEY='c9d7614ae19a6021d227b114d6c4f31a',
-- 	AUTHURL='http://localhost:8888',
-- 	INFOURL='http://localhost:8888',
-- 	-- AUTHURL='http://api2.server.rk.pk.mosoga.net',
-- 	-- INFOURL='http://api2.server.rk.pk.mosoga.net',

-- 	PlatformId=1,
-- 	ChannelId=1,

-- 	ChannelName='rekoo',
-- }

local ACCONFIG = require 'script.info.Info'.ACCONFIG
assert(ACCONFIG)

local AccountHelper = {}

function ACSErrorCath( datatable )
	if not datatable then
		GleeCore:toast(require "Res".locString("Network$NetworkError"))
		return true
	end
	if datatable and datatable.ResponseStatus and datatable.ResponseStatus.ErrorCode then
		GleeCore:toast(string.format("%s",tostring(datatable.ResponseStatus.Message)))
		return true
	end
	return false
end

function AccountHelper.ACSAuth( uid,token,callback,errorcallbck )
	local timestamp = tostring(os.time())
	local sign = GleeUtils:MD5Lua(string.format('%s%s%s%s',tostring(uid),tostring(token),timestamp,ACCONFIG.SKEY),false)

	local m = NetModel.new()
	m:setGCookie(nil) --切换帐号时的cookie可能是前一个帐号
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.AUTHURL,'/auth/rekoo?format=json'))
	m:addArg('uid',tostring(uid))
	m:addArg('token',tostring(token))
	m:addArg('sign',sign)
	m:addArg("channel",tostring(ACCONFIG.Rk_Channel))
	m:addArg('t',timestamp)
	m:addArg('deviceid',AccountHelper.getDeviceId())
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
	  print('ACSAuthRecv:')
	  print(datatable)
	  AccountInfo.setSdkUid(uid)
	  AccountInfo.setSdkToken(token)
	  Indicator.hide()

	  if ACSErrorCath(datatable) then
	  	return errorcallbck and errorcallbck()
	  end

	  return callback and callback(datatable)
	end)

end

function AccountHelper.ACSGetServer( s,id,callback ,errorcallbck)
	assert(s,'ACSGetServer sessionid is nil')
	assert(id,'ACSGetServer id is nil')

	local tail = string.format('/game/info/%s/%s/%s?format=json',tostring(ACCONFIG.PlatformId),tostring(ACCONFIG.ChannelId),AccountHelper.getBundleVersion())
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpGet)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:setGCookie(string.format('Cookie: ss-id=%s; X-UAId=%s',tostring(s),tostring(id)))
	m:clearGHeaders()
	m:addGHeaders('Accept-Language',string.lower(require 'script.info.Info'.LANG_NAME))
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACSGetServerRecv:')
		print(datatable)

		Indicator.hide()
		if ACSErrorCath(datatable) then
			return errorcallbck and errorcallbck()
		end

		AccountInfo.setServerInfo(datatable)
		return callback and callback(datatable)
	end)  
end

function AccountHelper.ACSGetVersionInfo( callback,errorcallbck )
	local tail = string.format('/channel/%s/%s?format=json',tostring(ACCONFIG.ChannelId),AccountHelper.getBundleVersion())
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpGet)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACSGetVersionInfoRecv:')
		print(datatable)

		Indicator.hide()
		if ACSErrorCath(datatable) then
			return errorcallbck and errorcallbck()
		end
		
		return callback and callback(datatable)
	end)  
end

function AccountHelper.ACSGetRoleInfo( server,callback )
	assert(server,'ACSGetRoleInfo server is nil')

	local tail = string.format('/role/login/%s/%s/%s?format=json',tostring(ACCONFIG.ChannelId),tostring(server.Id),AccountHelper.getBundleVersion())
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpGet)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACSGetRoleInfoRecv:')
		print(datatable)

		Indicator.hide()
		if ACSErrorCath(datatable) then
			return
		end
		AccountInfo.setCurrentServer(server)
		AccountInfo.setRoleInfo(datatable)
		AccountHelper.appStoreTs()
		require 'AppData'.setInitAnnoucne(datatable and datatable.Msgs)
		require 'AppData'.setSysNotifyList(datatable.MsgsSr)
		return callback and callback(datatable)
	end)
end

function AccountHelper.ACSFeedBack(C, content, callback)
	local userInfo = require 'AppData'.getUserInfo()
	local name = userInfo.getName()
	local rid = userInfo.getId()

	local sid = AccountInfo.getCurrentServerID()
	local tail = string.format('/feedback?format=json')
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:addArg('Sid',sid)
	m:addArg('Msg',tostring(content))
	m:addArg('C',C)
	m:addArg('Name', name)
	m:addArg('Rid', rid)
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('code:  '..tostring(code))
		print('ACSFeedBack:')
		print(datatable)

		Indicator.hide()
		if ACSErrorCath(datatable) then
			return
		end
		return callback and callback(datatable,tag,code,errorBuf)
	end)
end

function AccountHelper.sendPlayerName()
	local userInfo = require 'AppData'.getUserInfo()
	local name = userInfo.getName()
	local rid = userInfo.getId()

	local sid = AccountInfo.getCurrentServerID()
	local tail = string.format('/role/updatename?format=json')
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:addArg('Sid',sid)
	m:addArg('Name', name)
	m:setGZipEnable(false)
	--Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('code:  '..tostring(code))
		print('updatename:')
		--print(datatable)
		--Indicator.hide()
		--return callback and callback(datatable,tag,code,errorBuf)
	end)
end

function AccountHelper.ACSFeedBackMylist(callback)
	local userInfo = require 'AppData'.getUserInfo()
	local rid = userInfo.getId()

	local sid = AccountInfo.getCurrentServerID()
	local tail = string.format('/feedback/mylist/%s/%d?format=json',tostring(sid),rid)
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpGet)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACSFeedBackMylistRecv:')
		print(datatable)
		Indicator.hide()
		if ACSErrorCath(datatable) then
			return
		end
		return callback and callback(datatable,tag,code,errorBuf)
	end)
end

function AccountHelper.ACSMsgList( callback )
	local sid = AccountInfo.getCurrentServerID()
	local tail = string.format('/msg/list/%s?format=json',tostring(sid))
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpGet)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function (datatable,tag,code,errorBuf)
		print('ACSMsgList:')
		print(datatable)
		Indicator.hide()
		if ACSErrorCath(datatable) then
			return
		end
		return callback and callback(datatable,tag,code,errorBuf)
	end)
end

function AccountHelper.ACSQS( callback )
	if AccountInfo.getCurrentServerID and AccountInfo.getCurrentServerID() == 0 then
		return callback and callback()
	end

	local sid = AccountInfo.getCurrentServerID()
	local rid = AccountInfo.getRoleId()
	local tail = string.format('/q/isok/rekoo/%s/%s?format=json',tostring(sid),tostring(rid))
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpGet)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:setGZipEnable(false)

	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACSQSRecv:')
		print(datatable)
		if datatable and datatable.R then
			AccountInfo.setQsDone(datatable.R)
			require 'EventCenter'.eventInput('EventQs',datatable.R)
		end
		if ACSErrorCath(datatable) then
			return
		end
		return callback and callback( datatable,tag,code,errorBuf )
	end)
end

function AccountHelper:ACInviteCode( Code,callback )
	local tail = string.format('/game/bindinvitecode?format=json')
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:addArg('Code',Code)
	m:addArg('PlatformId',ACCONFIG.PlatformId)
	m:setGZipEnable(false)
	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACInviteCode:')
		print(datatable)
		Indicator.hide()
		if ACSErrorCath(datatable) then
			return
		end
		return callback and callback(datatable,tag,code,errorBuf)
	end)
end


function AccountHelper.isQsEnable( ... )
	return not AccountInfo.getQsDone()
end

function AccountHelper:getQsUrl( ... )
	local roleinfo = AccountInfo.getRoleInfo()
	local qsurl = AccountInfo.getServerInfo().Questionnaire
	if roleinfo and qsurl then
		local rid = roleinfo.Id
		local timestamp = os.time()
		local sign = GleeUtils:MD5Lua(string.format('%s%s%s',tostring(rid),timestamp,tostring(roleinfo.AccessToken)),false)

		return string.format('%s?Rid=%s&T=%s&Sign=%s',qsurl,tostring(rid),tostring(timestamp),tostring(sign))
	end
end

function AccountHelper.getMsgUrl( msgid )
	return string.format('%s/msg/html/%s',ACCONFIG.INFOURL,tostring(msgid))
end

function AccountHelper.getSdkToken( ... )
	return AccountInfo.getSdkToken()
end

function AccountHelper.setSdkToken( token )
	AccountInfo.setSdkToken( token )
end
function AccountHelper.getSdkUid( ... )
	return AccountInfo.getSdkUid()
end

function AccountHelper.getClientVersion( ... )
	local v = math.max(tonumber(require 'GVCHelper'.getServerVersion()),tonumber(require 'GVCHelper'.getLocalVersion() or 0))
	return string.format('%s.%s',AccountHelper.getBundleVersion(),tostring(v))
end

function AccountHelper.getBundleVersion( ... )
	return require 'script.info.Info'.PUBLISH_VERSION
end

function AccountHelper.getChannelName( ... )
	return ACCONFIG.ChannelName
end

function AccountHelper.getRoleInfoToken( ... )
	local roleinfo = AccountInfo.getRoleInfo and AccountInfo.getRoleInfo()
	return roleinfo and roleinfo.Token
end

--[[
+OffItems+1 ['PetName'']
|        +2 ['CityChange'']
|        +3 ['Voice'']
|        +4 ['CD_keyRUK'']
|        +5 ['Vip'']
|        +6 ['MCardName'']
|        +7 ['VipPack'']
			Ad
]]
function AccountHelper.isItemOFF( itemname )
	local roleinfo = AccountInfo.getRoleInfo()
	local OffItems = roleinfo and roleinfo.OffItems
	if OffItems then

		for k,v in pairs(OffItems) do
			if v == itemname then
				return true
			end
		end
	end
	return false
end

--[[
	提审时 部分lua config的数据修改
]]
function AccountHelper.appStoreTs( ... )
	local off = AccountHelper.isItemOFF('CityChange')
	if off then
		local _table = require 'TownConfig'
		for i,v in ipairs(_table) do
			v.Name = v.Name2
		end

		_table = require 'StageConfig'
		for i,v in ipairs(_table) do
			v.Name = v.Name2
		end

		_table = require 'PubNameConfig'
		for i,v in ipairs(_table) do
			if v.PubName and v.Name2 then
				v.PubName= v.Name2
			end
		end
	end

	off = AccountHelper.isItemOFF('PetName')
	if off then
		local _table = require 'charactorConfig'
		for i,v in ipairs(_table) do
			v.name= v.name2
		end

		_table = require 'BattleStoryA'
		for i,v in ipairs(_table) do
			v.name = v.name2
		end
		-- local _fetters = require 'FetterConfig'
		-- for i,v in ipairs(_fetters) do
		-- 	local Description2 = nil
		-- 	local tail = nil
		-- 	local tmps = string.split(v.Description,']')
		-- 	tail = tmps[#tmps]
		-- 	if v.Keys then
		-- 		for i,petid in ipairs(v.Keys) do
		-- 			local dbpet = require 'DBManager'.getCharactor(tonumber(petid))
		-- 			if dbpet then
		-- 				Description2 = string.format('%s%s[%s]',Description2 or '',(Description2 and '、') or '', dbpet.name)	
		-- 			end
		-- 		end
		-- 		v.Description = (Description2 and tostring(Description2)..tostring(tail)) or v.Description
		-- 		-- print(v.Description)
		-- 	end
		-- end
	end

end

function AccountHelper.getAServersNoticeUrl( ... )
	local tail = string.format('/pfmsg/html/%s',tostring(ACCONFIG.PlatformId))
	return string.format('%s%s',ACCONFIG.INFOURL,tail)
end

function AccountHelper.ACSDevInviteCode( DeviceId,callback )
	local tail = string.format('/pf/devinvitecode/%s/%s?format=json',tostring(ACCONFIG.PlatformId),tostring(DeviceId))
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpGet)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:setGZipEnable(false)

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACSDevInviteCode:')
		print(datatable)
		Indicator.hide()
		if ACSErrorCath(datatable) then
			return
		end
		return callback and callback(datatable,tag,code,errorBuf)
	end)
end

function AccountHelper.ACSBindDevInviteCode( Code,DevId,callback )
	local tail = string.format('/pf/binddevinvitecode?format=json')
	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.INFOURL,tail))
	m:addArg('Code',Code)
	m:addArg('PlatformId',ACCONFIG.PlatformId)
	m:addArg('DevId',DevId)

	m:setGZipEnable(false)
	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('ACSBindDevInviteCode:')
		print(datatable)
		Indicator.hide()
		if ACSErrorCath(datatable) then
			return
		end
		return callback and callback(datatable,tag,code,errorBuf)
	end)
end

--返利
function AccountHelper.ACSGetCZRewardUrl( ... )
	local tail = string.format('/beta/czreward')
	local url  = string.format('%s%s',ACCONFIG.INFOURL,tail)
	local roleinfo = AccountInfo.getRoleInfo()
	if roleinfo and url then
		local rid = roleinfo.Id
		local timestamp = os.time()
		local sign = GleeUtils:MD5Lua(string.format('%s%s%s',tostring(rid),timestamp,tostring(roleinfo.AccessToken)),false)

		return string.format('%s?Rid=%s&T=%s&Sign=%s',url,tostring(rid),tostring(timestamp),tostring(sign))
	end
end

--回馈 
function AccountHelper.ACSGetHKRewardUrl( ... )
	local tail = string.format('/beta/hkreward')
	local url  = string.format('%s%s',ACCONFIG.INFOURL,tail)
	local roleinfo = AccountInfo.getRoleInfo()
	if roleinfo and url then
		local rid = roleinfo.Id
		local timestamp = os.time()
		local sign = GleeUtils:MD5Lua(string.format('%s%s%s',tostring(rid),timestamp,tostring(roleinfo.AccessToken)),false)

		return string.format('%s?Rid=%s&T=%s&Sign=%s',url,tostring(rid),tostring(timestamp),tostring(sign))
	end
end

function AccountHelper.isCZEnable( ... )
	local roleinfo = AccountInfo.getRoleInfo()
	return roleinfo and roleinfo.Cz
end

function AccountHelper.isHKEnable( ... )
	local roleinfo = AccountInfo.getRoleInfo()
	return roleinfo and roleinfo.Hk
end

function AccountHelper.ACSCZ( enable )
	local roleinfo = AccountInfo.getRoleInfo()
	if roleinfo then
		roleinfo.Cz = enable
	end
	require 'EventCenter'.eventInput('EventCZ')
end

function AccountHelper.ACSHK( enable )
	local roleinfo = AccountInfo.getRoleInfo()
	if roleinfo then
		roleinfo.Hk = enable
	end
	require 'EventCenter'.eventInput('EventHK')
end

function AccountHelper.ACSAuthFacebook( uid,token,action,otherargs,callback)
	AccountInfo.setGuest(false)
	
	local timestamp = tostring(os.time())
	local deviceid 	= AccountHelper.getDeviceId()
	action = AccountInfo.isBindAction() and 'BIND' or 'LOGIN'
	local sign = GleeUtils:MD5Lua(string.format('%s%s%s%s%s%s',tostring(uid),tostring(token),timestamp,deviceid,action,'0dd6e0238e7f4f118d278289d4b92604'),false)

	local m = NetModel.new()
	m:setGCookie(nil) --切换帐号时的cookie可能是前一个帐号
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.AUTHURL,'/auth/facebookv2?format=json'))
	m:addArg('uid',tostring(uid))
	m:addArg('token',tostring(token))
	m:addArg('sign',sign)
	m:addArg("channel",tostring(ACCONFIG.Rk_Channel))
	m:addArg('t',timestamp)
	m:addArg('deviceid',deviceid)
	m:addArg('action',action)
	m:setGZipEnable(false)
	if otherargs then
		for k,v in pairs(otherargs) do
			m:addArg(k,tostring(v))
		end
	end

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
	  print('ACSAuthFacebookRecv:')
	  print(datatable)
	  AccountInfo.setSdkUid(uid)
	  AccountInfo.setSdkToken(token)
	  Indicator.hide()

	  if ACSErrorCath(datatable) then
	  	return errorcallbck and errorcallbck()
	  end

	  return callback and callback(datatable)
	end)
end

function AccountHelper.ACSAuthGoogle( uid,token,action,otherargs,callback)
	AccountInfo.setGuest(false)

	local timestamp = tostring(os.time())
	local deviceid 	= AccountHelper.getDeviceId()
	action = AccountInfo.isBindAction() and 'BIND' or 'LOGIN'
	local sign = GleeUtils:MD5Lua(string.format('%s%s%s%s%s%s',tostring(uid),tostring(token),timestamp,deviceid,action,'fb1e32f69ab8f8e71a6a0f7704318bfb'),false)

	local m = NetModel.new()
	m:setGCookie(nil) --切换帐号时的cookie可能是前一个帐号
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.AUTHURL,'/auth/googlev2?format=json'))
	m:addArg('uid',tostring(uid))
	m:addArg('token',tostring(token))
	m:addArg('sign',sign)
	m:addArg("channel",tostring(ACCONFIG.Rk_Channel))
	m:addArg('t',timestamp)
	m:addArg('deviceid',deviceid)
	m:addArg('action',action)
	
	m:setGZipEnable(false)
	if otherargs then
		for k,v in pairs(otherargs) do
			m:addArg(k,tostring(v))
		end
	end

	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
	  print('ACSAuthGoogleRecv:')
	  print(datatable)
	  AccountInfo.setSdkUid(uid)
	  AccountInfo.setSdkToken(token)
	  Indicator.hide()

	  if ACSErrorCath(datatable) then
	  	return errorcallbck and errorcallbck()
	  end

	  return callback and callback(datatable)
	end)
end

function AccountHelper.ACSAuthGuest(callback)
	AccountInfo.setGuest(true)

	local deviceid = AccountHelper.getDeviceId()
	local timestamp = tostring(os.time())
	local sign = GleeUtils:MD5Lua(string.format('%s%s%s',tostring(deviceid),timestamp,'9f3edf328333f29df3940c230b9cb904'),false)

	local m = NetModel.new()
	m:setGCookie(nil) --切换帐号时的cookie可能是前一个帐号
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.AUTHURL,'/auth/visitor?format=json'))
	m:addArg('deviceid',deviceid)
	m:addArg('t',timestamp)
	m:addArg('sign',sign)
	m:setGZipEnable(false)
	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
	  print('ACSAuthGuestRecv:')
	  print(datatable)
	  Indicator.hide()

	  if ACSErrorCath(datatable) then
	  	return errorcallbck and errorcallbck()
	  end

	  return callback and callback(datatable)
	end)
end

function AccountHelper.ACSReset( callback )

	local m = NetModel.new()
	m:setGCookie(nil) --切换帐号时的cookie可能是前一个帐号
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl(string.format('%s%s',ACCONFIG.AUTHURL,'/auth2/reset?format=json'))
	-- m:addArg('deviceid',deviceid)
	m:setGZipEnable(false)
	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
	  print('ACSResetRecv:')
	  print(datatable)
	  Indicator.hide()

	  if ACSErrorCath(datatable) then
	  	return errorcallbck and errorcallbck()
	  end

	  return callback and callback(datatable)
	end)
end

function AccountHelper.ACSUpdateAuthData( authdata )
	local m = NetModel.new()
	m:setGCookie(string.format('Cookie: ss-id=%s; X-UAId=%s',tostring(authdata.SessionId),tostring(authdata.UserId)))
end
-------------

local ServerColor = 
{
	[0]=ccc4f(0.458824,1.000000,0.462745,1.0),--新
	[1]=ccc4f(1.000000,0.874510,0.192157,1.0),--维
	[2]=ccc4f(0.988235,0.376471,0.239216,1.0),--火
	[4]=ccc4f(0.988235,0.376471,0.239216,1.0),--抢
}

function AccountHelper.getState( server )
	local Res = require 'Res'
	local ServerStates = 
	{
		{C=0,N=Res.locString('Login$ServerStaus0')},
		{C=1,N=Res.locString('Login$ServerStaus1')},
		{C=2,N=Res.locString('Login$ServerStaus2')},
		{C=4,N=Res.locString('Login$ServerStaus4')},
	}
	local Ss = ServerStates
	if server and Ss then
		for i,v in ipairs(Ss) do
		  if tonumber(server.S) == tonumber(v.C) then
		    return tostring(v.N),ServerColor[tonumber(v.C)]
		  end
		end
	end
	return '',ServerColor[0]
end

function AccountHelper.getDeviceId( ... )
	if require "framework.basic.Device".platform == "android" then
		return require 'AndroidUtil'.getUUID()
	else
		return require 'RoleLogin'.getIOSDeviceID()
	end
end

return AccountHelper