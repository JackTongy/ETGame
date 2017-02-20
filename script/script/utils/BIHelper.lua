local AccountInfo = require 'AccountInfo'
local AppData = require 'AppData'
local ACCONFIG = require 'script.info.Info'.ACCONFIG
require 'framework.net.Net'

local BIHelper = {}
local commArg = {}

local _Enable = require 'framework.basic.Device'.platform == 'android' and ACCONFIG.Rk_Channel == 9

function BIHelper.setEnable( enable )
	if enable and not _Enable then
		_Enable = true
	end
end

function BIHelper.initBI( channelID,gameversion,gamename )
	assert(channelID and gameversion and gamename,'initBI arg inviald!')
	BIHelper.setCommonArg(channelID,gameversion,gamename)
	if _Enable then
		-- print('initBI:')
		-- print(RKStatisticsManager)
		RKStatisticsManager:getInstance():runAThreadWithChannelID(channelID,gameversion,'login','0',gamename)
	end
end

function BIHelper.record(pagename,action,staytime)
	local roleid = AccountInfo.getRoleId()
	if _Enable and roleid then
		local userlv = (AppData.getUserInfo().isValid() and AppData.getUserInfo().getLevel()) or 0
		local serverid = AccountInfo.getCurrentServerID()
		local actionstr = string.format('%s,%s,%s,%s',tostring(serverid),tostring(roleid),tostring(userlv),tostring(action))
		staytime = staytime or 0
		if require 'framework.basic.Device'.platform == 'android' then
			require "AndroidUtil".recordEvent(pagename,actionstr,staytime)
		else
			RKStatisticsManager:getInstance():rkStatisticsWithChannelID(commArg.channelID,commArg.gameversion,pagename,actionstr,tostring(staytime),commArg.gamename)
		end
	end
end

function BIHelper.setCommonArg( channelID,gameversion,gamename )
	commArg.channelID = channelID
	commArg.gameversion = gameversion
	commArg.gamename = gamename
end

function BIHelper.scribeLog( action,channel)
	if not _Enable then
		return
	end

	commArg.channelID = channel or commArg.channelID
	commArg.platform  = commArg.platform or require 'framework.basic.Device'.platform
	if commArg.platform == "android" then
		commArg.deviceid  = commArg.deviceid  or require 'AndroidUtil'.getUUID()
		commArg.osversion = commArg.osversion or require 'AndroidUtil'.getOsVersion()
		commArg.phonetype =	commArg.phonetype or require 'AndroidUtil'.getDeviceName()
		commArg.netstatus =	commArg.netstatus or require 'AndroidUtil'.getNetType()
	else
		commArg.deviceid  = commArg.deviceid  or require 'RoleLogin'.getIOSDeviceID()
		commArg.osversion = commArg.osversion or (GleeUtils.getOsVersion and GleeUtils:getOsVersion())
		commArg.phonetype = commArg.phonetype or (GleeUtils.getDeviceName and GleeUtils:getDeviceName())
		commArg.netstatus = commArg.netstatus or (GleeUtils.getNetStatus and GleeUtils:getNetStatus())
		if type(commArg.netstatus) == 'number' and commArg.netstatus == 1 then
			commArg.netstatus = '2G/3G'
		elseif type(commArg.netstatus) == 'number' and commArg.netstatus == 2 then  
			commArg.netstatus = 'WiFi'
		end
	end

	local m = NetModel.new()
	m:setType(CCHttpRequest.kHttpPost)
	m:setUrl("http://scribe.rk.pk.mosoga.net/ScribeLog.ashx")
	m:addArg('action',tostring(action))
	m:addArg('deviceid',tostring(commArg.deviceid))
	m:addArg('platform',tostring(commArg.platform))
	m:addArg('osversion',tostring(commArg.osversion))
	m:addArg('phonetype',tostring(commArg.phonetype))
	m:addArg('channel',tostring(commArg.channelID))
	m:addArg('net',tostring(commArg.netstatus))
	m:addArg('uid',tostring(AccountInfo.getSdkUid()))
	m:setGZipEnable(false)

	m:callNet(function ( datatable,tag,code,errorBuf )
		print('scribe...'..tostring(action))
	end)

end

return BIHelper