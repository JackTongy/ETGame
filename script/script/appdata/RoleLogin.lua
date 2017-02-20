local socketC = require "SocketClient"
local netModel = require "netModel"
local gameFunc = require "AppData"
local AccountHelper = require 'AccountHelper'
local EventCenter 	= require 'EventCenter'
local Utils = require 'framework.helper.Utils'
local TimerHelper = require 'framework.sync.TimerHelper'

local RoleLogin = {}

function RoleLogin.roleLoginV2( roleId,serverId,callback,errorCallback,pwd,progressCallback )
	require 'DIndicator'.setIgnoreEnabled( true )

	local doErrorCallback = function ( errMsg )
		if errorCallback then
			errorCallback(errMsg)
		end

		require 'DIndicator'.setIgnoreEnabled( false )
	end

	socketC:send(netModel.getModelRoleLoginV2(RoleLogin.getRoleLoginArgs(roleId,serverId,pwd)), function ( data )
		if data and data.D then
			if data.D.A then
				gameFunc.getUserInfo().setTimeZone(data.D.A)
			end
			gameFunc.getUserInfo().setData(data.D.Role)
			gameFunc.getTaskLoginInfo().setData(data.D.TaskLogin)
			gameFunc.getBagInfo().setEgg(data.D.Egg)
			gameFunc.getUserInfo().setCoinWell(data.D.Well)
			if data.D.ServerOpenVersion == 0 then
				gameFunc.getActivityInfo().setOther('UpgradeAct',data.D.IsLvActive)
			elseif data.D.ServerOpenVersion == 1 then
				gameFunc.getActivityInfo().setOther("UpgradeRankAct",data.D.IsLvActive)
				gameFunc.getActivityInfo().setOther("UpgradeRewardAct",{CloseAt = data.D.LvArriveEndAt})
			end
			gameFunc.getActivityInfo().setOther('V6Notice',data.D.V6Notice)
			if gameFunc.getTempInfo().getLastAreaId() == nil then		-- 须在setAreaId前判断
				gameFunc.getTempInfo().setLastAreaId(data.D.AreaId)
			end
			gameFunc.getTempInfo().setAreaId(data.D.AreaId)
			gameFunc.getItemMallInfo().setBuyRecord(data.D.BuyRecord)
			gameFunc.getGuildInfo().clear()
			gameFunc.getGuildInfo().setGuildMember(data.D.GuildMember)
			gameFunc.getNapkinInfo().setData(data.D.Napkin)
			print("RoleLoginV2 data")
			print(data)
			--	服务器时间校准
			require "TimeManager".serverTimeAdjust(socketC)

			local networkList = {}
			networkList.PetGetList = false
			networkList.GemGetList = false
			networkList.MaterialGetList = false
			networkList.EqGetList = false
			networkList.RuneGetList = false
			networkList.TownGetList = false
			networkList.PetCollectGet = false
			networkList.LogonInfo = false
			networkList.MibaoGetList = false
			networkList.MibaoPieceGetList = false
			networkList.BooksGet = false
			networkList.PerlsGet = false
			networkList.BookPiecesGet = false

			local checkNetworkList = function ( ... )

				local allFlags = 0
				local validFlags = 0

				for k,v in pairs(networkList) do
					allFlags = allFlags + 1
					if v then
						validFlags = validFlags + 1
					end
				end

				if progressCallback then
					progressCallback(validFlags, allFlags)
				end

				for k,v in pairs(networkList) do
					if not v then
						return false
					end
				end
				return true
			end

			local doNetworkFinishCallback = function (  )
				if checkNetworkList() then
					require 'DIndicator'.setIgnoreEnabled( false )

					callback()
					RoleLogin.rolePush()
				end
			end

			socketC.send0(netModel.getModelPetGetList(), function ( data )
				if data and data.D then
					gameFunc.getPetInfo().setPetList(data.D.Pets)
					networkList.PetGetList = true
					doNetworkFinishCallback()
				else
					doErrorCallback("PetGetList")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelGemGetList(), function ( data )
				if data and data.D then
					gameFunc.getGemInfo().setGemAll(data.D.Gems)
					networkList.GemGetList = true
					doNetworkFinishCallback()
				else
					doErrorCallback("GemGetList")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelMaterialGetList(), function ( data )
				if data and data.D then
					gameFunc.getBagInfo().setItems(data.D.Materials)
					networkList.MaterialGetList = true
					print("MaterialGetList")
					doNetworkFinishCallback()
				else
					doErrorCallback("MaterialGetList")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelEqGetList(), function ( data )
				if data and data.D then
					gameFunc.getEquipInfo().setEquipList(data.D.Eqs)
					networkList.EqGetList = true
					doNetworkFinishCallback()
				else
					doErrorCallback("EqGetList")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelRuneGetList(), function ( data )
				if data and data.D then
					gameFunc.getRuneInfo().setRuneList(data.D.Runes)
					networkList.RuneGetList = true
					doNetworkFinishCallback()
				else
					doErrorCallback("RuneGetList")
				end
			end, nil, nil, nil, nil, false)


			socketC.send0(netModel.getModelMibaoGetAll(), function ( data )
				if data and data.D then
					gameFunc.getMibaoInfo().setMibaoList(data.D.List)
					networkList.MibaoGetList = true
					doNetworkFinishCallback()
				else
					doErrorCallback("MibaoGetList")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelMibaoGetPieces(), function ( data )
				if data and data.D then
					gameFunc.getMibaoInfo().setMibaoPieceList(data.D.List)
					networkList.MibaoPieceGetList = true
					doNetworkFinishCallback()
				else
					doErrorCallback("MibaoPieceGetList")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelTownGet(0), function ( data )
				if data and data.D then	
					gameFunc.getTownInfo().setTowns(data.D.Towns)
					networkList.TownGetList = true
					doNetworkFinishCallback()
				else
					doErrorCallback("TownGet")
				end
			end, nil, nil, nil, nil, false)

			local funcBossAtkGet
			funcBossAtkGet = function ( isLogin )
				socketC:send(netModel.getBossAtkGet(),function ( data )
					print("BossAtkGet")
					print(data)
					print("BossAtkGet_end")
					if data and data.D then
						gameFunc.getUserInfo().setBossAtkBossId(data.D.BossAtk.BossId)
						local timeManager = require "TimeListManager"
						local seconds = 3600 - timeManager.getTimeUpToNow(data.D.BossAtk.OpenTime)
						print(seconds)
						if seconds > 0 then
							require 'EventCenter'.eventInput("UpdateBossBattleAnimation")
							timeManager.addToTimeList(timeManager.packageTimeStruct("BossBattle", seconds, function ( delta )
								if delta <= 0 then
									require 'framework.helper.Utils'.delay(function (  )
										funcBossAtkGet(false)
									end, 2)
								end
							end))
						end
						if isLogin then
					--		networkList.BossAtkGet = true
							doNetworkFinishCallback()
						end
					else
						doErrorCallback('BossAtkGet')
					end
				end)
			end
	--		funcBossAtkGet(true)

			socketC.send0(netModel.getModelPetCollectGet(), function ( data )
				print("PetCollectGet")
				print(data)
				if data and data.D then
					gameFunc.getPetInfo().setPetIdCollectionList(data.D.Collects)
					gameFunc.getPetInfo().setPetArchivedDict(data.D.Pets)

					networkList.PetCollectGet = true
					doNetworkFinishCallback()
				else
					doErrorCallback("PetCollectGet")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelLogonInfo(), function ( data )
				if data and data.D then
					gameFunc.getActivityInfo().setData(data.D.Acs)
					gameFunc.getPartnerInfo().setPartnerList(data.D.Partners)
					gameFunc.getTeamInfo().setTeamList(data.D.Teams)

					local rechargeInfo = {}
					rechargeInfo.ChargeTotal = data.D.ChargeTotal
					rechargeInfo.Vip = data.D.Vip
					rechargeInfo.Charges = data.D.Charges
					rechargeInfo.MCard = data.D.MCard
					rechargeInfo.MCardLux = data.D.MCardLux
					rechargeInfo.FcRewardGot = data.D.FcRewardGot
					gameFunc.getRechargeInfo().setData(rechargeInfo)

					gameFunc.getUserInfo().setBossAtkBossId(data.D.BossAtk.BossId)
					local timeManager = require "TimeListManager"
					local seconds = 3600 - timeManager.getTimeUpToNow(data.D.BossAtk.OpenTime)
					print(seconds)
					if seconds > 0 then
						require 'EventCenter'.eventInput("UpdateBossBattleAnimation")
						timeManager.addToTimeList(timeManager.packageTimeStruct("BossBattle", seconds, function ( delta )
							if delta <= 0 then
								require 'framework.helper.Utils'.delay(function (  )
									funcBossAtkGet(false)
								end, 2)
							end
						end))
					end

					gameFunc.getBroadCastInfo().set("boss_down", data.D.BossDown == true)
					gameFunc.getBroadCastInfo().set("tuangou", true)
					gameFunc.getUserInfo().setBossDownPlay(data.D.BossDownPlay)
					gameFunc.getExploreInfo().setExploreData(data.D.Explores)

					gameFunc.getLoginInfo().setData(data.D)

					networkList.LogonInfo = true
					doNetworkFinishCallback()
				else
					doErrorCallback("LogonInfo")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelBooksGet(), function ( data )
				if data and data.D then
					gameFunc.getPerlBookInfo().setBooks(data.D.Books)
					networkList.BooksGet = true
					doNetworkFinishCallback()
				else
					doErrorCallback("BooksGet")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelPerlsGet(), function ( data )
				if data and data.D then
					gameFunc.getPerlBookInfo().setPerls(data.D.Perls)
					networkList.PerlsGet = true
					doNetworkFinishCallback()
				else
					doErrorCallback("PerlsGet")
				end
			end, nil, nil, nil, nil, false)

			socketC.send0(netModel.getModelBookPiecesGet(), function ( data )
				if data and data.D then
					gameFunc.getPerlBookInfo().setBookPieces(data.D.Pieces)
					networkList.BookPiecesGet = true
					doNetworkFinishCallback()
				else
					doErrorCallback("BookPiecesGet")
				end
			end, nil, nil, nil, nil, false)
		else
			doErrorCallback("RoleLoginV2")
		end
	end)
	
	if LabelNode.setFontSizeScale and require 'script.info.Info'.LANG_NAME == 'Arabic' then
        LabelNode:setFontSizeScale(1)
    end
end

function RoleLogin.getRoleLoginArgs( roleId,serverId,pwd )
	local Token 		= AccountHelper.getRoleInfoToken()
	local Uid 			= AccountHelper.getSdkUid()
	local V = AccountHelper.getClientVersion()
	local Channel		= AccountHelper.getChannelName()

	local OsVersion 	= GleeUtils.getOsVersion and GleeUtils:getOsVersion()
	local DeviceId 		= RoleLogin.getIOSDeviceID()
	local Idfa 			= GleeUtils.getIDFA and GleeUtils:getIDFA()
	local PhoneType 	= GleeUtils.getDeviceName and GleeUtils:getDeviceName()
	local netstatus 	= GleeUtils.getNetStatus and GleeUtils:getNetStatus()
	local Imei			= nil
	if netstatus == 1 then
		netstatus = '2G/3G'
	elseif netstatus == 2 then
		netstatus = 'WiFi'
	end

	if require "framework.basic.Device".platform == "android" then
		OsVersion 	=	require 'AndroidUtil'.getOsVersion()
		DeviceId	=  	require 'AndroidUtil'.getUUID()
		PhoneType	=	require 'AndroidUtil'.getDeviceName()
		netstatus 	=	require 'AndroidUtil'.getNetType()
		Imei 		=	require 'AndroidUtil'.getImei()
	end

	local Culture = RoleLogin.getCulture()
	return {Rid = roleId, ServerId = serverId,Pwd=pwd,
		Token=Token,
		V=V,
		Uid=Uid,
		OsVersion=OsVersion,
		DeviceId=DeviceId,
		Idfa=Idfa,
		PhoneType=PhoneType,
		Channel=Channel,
		Net=netstatus,
		Imei=Imei,
		Culture=Culture,
	}
end

function RoleLogin.getIOSDeviceID( ... )
	if GleeUtils.getIDFA then
		local deviceinfo = Utils.readTableFromFile("deviceinfo") or {}
		local idfa = deviceinfo['idfa']
		if not idfa then
			idfa = GleeUtils:getIDFA()
			if (not idfa or idfa == '00000000-0000-0000-0000-000000000000') and GleeUtils.getOpenIDFA then
				idfa = GleeUtils:getOpenIDFA()
			end
			deviceinfo['idfa'] = idfa
			Utils.writeTableToFile(deviceinfo,"deviceinfo")
		end
		return idfa
	end
end

function RoleLogin.getCulture(  )
	local t = {
		thai=[[th-TH]],
		vn=[[vi-VN]],
		tra_ch=[[zh-TW]],
		HKTW=[[zh-TW]],
		english=[[en-US]],
		kor=[[ko-KR]],
		sim_ch=[[zh-CN]],
		sim_ch2=[[zh-CN]],
		singapore=[[zh-CN]],
		ES=[[es]],
		Arabic=[[ar]],
		Indonesia=[[id-ID]],
		German=[[de]],
	}
	local langname = require 'script.info.Info'.LANG_NAME
	local Culture = t[langname]
	return Culture or langname
end

function RoleLogin.roleLoginV2_1( roleId, serverId, callback, errorCallback,pwd)
	local doErrorCallback = function ( errMsg )
		if errorCallback then
			errorCallback(errMsg)
		end
	end

	socketC:send(netModel.getModelRoleLoginV2_1(RoleLogin.getRoleLoginArgs(roleId,serverId,pwd)), function ( data )
		if data and data.D then
			--	服务器时间校准
			-- require "TimeManager".serverTimeAdjust(socketC)
			callback()
		else
			doErrorCallback()
		end
	end)
end

function RoleLogin.rolePush( ... )
	local Channel		= AccountHelper.getChannelName()
	local devicetoken

	if require "framework.basic.Device".platform == "android" then
		devicetoken = require "AccountInfo".getPushToken()
	else
		devicetoken	= GleeUtils.getDeviceToken and GleeUtils:getDeviceToken()
	end

	socketC:send(netModel.getRolePush( Channel,devicetoken ),function ( data )
		-- body
	end)
end


local syncRechargeInfo
local startTick
local releaseTick
local _synchandle

syncRechargeInfo = function ( ... )
	startTick(function ( ... )
		socketC:send(netModel.getModelRoleCoin(),function ( data )
			require 'AppData'.getUserInfo().setCoin(data.D.Coin)
			EventCenter.eventInput("UpdateVipLevel")
			EventCenter.eventInput('UpdateRechargeInfo')
		end)
	end)
end

startTick = function (callback)
	if not _synchandle then
		local count = 0
		local update2s = function ( ... )
			if count == 3 then
				releaseTick()
				return
			end
			count = count + 1
			return callback and callback()
		end

		_synchandle = TimerHelper.tick(update2s,3)
		update2s()
	end
end

releaseTick = function ()
	if _synchandle then
		TimerHelper.cancel(_synchandle)
		_synchandle = nil
	end
end

EventCenter.resetGroup('RoleLogin')
EventCenter.addEventFunc("OnAppStatChange", function ( state )
	-- print('relogin OnAppStatChange:'..state)
	-- if state == 1 then
	-- 	local broadCastFunc = require 'AppData'.getBroadCastInfo()
	-- 	broadCastFunc.set('ReloginSyncData',true)
	-- 	print(broadCastFunc.get('ReloginSyncData'))
	-- end
end,'RoleLogin')

EventCenter.addEventFunc('syncRechargeInfo',function ( data )
	syncRechargeInfo()
end,'RoleLogin')

EventCenter.addEventFunc('charge_ok',function ( data )
	socketC:send(netModel.getModelRoleCoin(),function ( data )
		require 'AppData'.getUserInfo().setCoin(data.D.Coin)
		EventCenter.eventInput("UpdateVipLevel")
		EventCenter.eventInput('UpdateRechargeInfo')
	end)
end,'RoleLogin')

--回馈
EventCenter.addEventFunc('betareward_hk',function ( data )
	socketC:send(netModel.getModelRoleCoin(),function ( data )
		require 'AppData'.getUserInfo().setCoin(data.D.Coin)
		EventCenter.eventInput("UpdateVipLevel")
		EventCenter.eventInput('UpdateRechargeInfo')
	end)

	AccountHelper.ACSHK(false)

end,'RoleLogin')

--返利
EventCenter.addEventFunc('betareward_cz',function ( data )
	socketC:send(netModel.getModelRoleCoin(),function ( data )
		require 'AppData'.getUserInfo().setCoin(data.D.Coin)
		EventCenter.eventInput("UpdateVipLevel")
		EventCenter.eventInput('UpdateRechargeInfo')
	end)
	AccountHelper.ACSCZ(false)
end,'RoleLogin')

return RoleLogin