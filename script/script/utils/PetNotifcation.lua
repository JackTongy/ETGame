local EventCenter = require 'EventCenter'
local Notifcation = require 'Notifcation'
local Utils = require 'framework.helper.Utils'
local AppData = require 'AppData'
local TimeManager = require 'TimeManager'
local Res = require 'Res'
local UnlockManager = require 'UnlockManager'

local settingfile = 'notificationMap'
local bgtime

local function getTimeOffset(hour,mm )
	return require 'Toolkit'.getTimeOffset(hour,mm)
end

--[[
体力领取提醒（可设置开关）
体力回满提醒（可设置开关）  
Boss战开启通知（可设置开关）
离线24小时召回
离线72小时召回
]]
local function registerLocalNotification()
	local setting = Utils.readTableFromFile(settingfile) or {notify_PushApRec=true,notify_PushApFull =true,notify_PushBossBattle=true}
	
	if setting.notify_PushApRec then
		--11点 17点
		Notifcation.localNotification(getTimeOffset(11,0),Res.locString('Notifaction$ApGet'))
		Notifcation.localNotification(getTimeOffset(17,0),Res.locString('Notifaction$ApGet'))

		if AppData.getUserInfo().getVipLevel() and AppData.getUserInfo().getVipLevel() >= 3 then
			Notifcation.localNotification(getTimeOffset(21,0),Res.locString('Notifaction$ApGet'))
		end
	end

	local UserInfo = AppData.getUserInfo() 
	if setting.notify_PushApFull and UserInfo and UserInfo.isValid() then
		local seconds = UserInfo.getApTotalResume()
		if seconds and seconds > 0 then
			Notifcation.localNotification(seconds,Res.locString('Notifaction$ApRestore'))
		end
	end

	if setting.notify_PushBossBattle and UserInfo and UserInfo.isValid() and UnlockManager:isUnlock('BossBattle') then
		--12点 21点
		Notifcation.localNotification(getTimeOffset(12,0),Res.locString('Notifaction$Boss'))
		Notifcation.localNotification(getTimeOffset(21,0),Res.locString('Notifaction$Boss'))
	end

	--print('msg:--------------------------setting.notify_PushExplorationOver:  '..tostring(setting.notify_PushExplorationOver))
	if setting.notify_PushExplorationOver then
		local completTime = require 'ExploreInfo'.getEarliestCompleteTime()
		--print('msg:--------------------completTime:  '..tostring(completTime))
		if completTime > 0 then
			Notifcation.localNotification(completTime, Res.locString('Explore$_Complete_Toast'))
		end
	end

	local BagInfo = AppData.getBagInfo()
	if BagInfo then
		local seconds = BagInfo.getPetEggLastTime()
		if seconds > 0 then
			Notifcation.localNotification(seconds,Res.locString('Notifaction$EGG'))
		end
	end


	Notifcation.localNotification(24*3600,Res.locString('Notifaction$offline24'))
	Notifcation.localNotification(72*3600,Res.locString('Notifaction$offline72'))

end

EventCenter.resetGroup('PetNotif')
EventCenter.addEventFunc('OnAppStatChange',function ( state )
	if state == 1 then 
		--print('App OnBackground petnotif')
		Notifcation.cancelLocalNotification()
		registerLocalNotification()
		bgtime = os.time()
	elseif state == 2 then
		Notifcation.cancelLocalNotification()
		
		--游戏退出后台超过15分钟，回到游戏后自动 返回登陆，返回到登陆界面
		if bgtime and os.time()-bgtime > 60*15 then
			GleeCore:reLogin()
		end
	end
end,'PetNotif')


return setting