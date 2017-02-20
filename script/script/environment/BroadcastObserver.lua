local Broadcast = require 'framework.net.Broadcast'
local EventCenter = require 'EventCenter'
local FightEvent = require 'FightEvent'
local handlerManager = require 'framework.net.SocketHandleManager'
local Res = require 'Res'

handlerManager.setErrHandler(function ( data )
	print(data)
	local dataType = type(data)
	local msg = nil
	if dataType == 'table' then
		local broadCastFunc = require 'AppData'.getBroadCastInfo()
		broadCastFunc.set('ReloginSyncData',false)
		if data.Code and tonumber(data.Code) ~= 200 then

			EventCenter.eventInput(string.format('SERVERERRORCODE',tostring(data.Code)),data)
			if data.Code == 702 then
				require "Toolkit".showDialogOnCoinNotEnough()
				return true	
			elseif data.Code >= 21000 and data.Code <= 21002 then -- 冠军联赛
				msg = nil
				return true
			elseif data.Code >= 600 then
				msg = tostring(data.Msg)
			elseif data.Code == 413 then --帐号在其它设备登录
				require 'AccountHelper'.setSdkToken(nil)
				GleeCore:reLogin()
				msg = data.Msg
			else
				msg = string.format('%s Code:%s C:%s',tostring(data.Msg),tostring(data.Code),tostring(data.C))
			end
		end
	elseif dataType == 'string' then
		--错误处理
		msg = tostring(data)
		if string.find(msg,'closed') or string.find(msg,'timeout') then
			if not GleeCore:isRunningLayer('DDisconnectNotice') then
				GleeCore:showLayer('DDisconnectNotice')
			end
			return true
		end

	else
		msg = 'Unknown'		
	end

	if msg then
		GleeCore:toast(msg)
		return true
	end
end)


Broadcast.check("PvpInvite", function ( data )
	EventCenter.eventInput("EventPvpInvite", data)
end)

Broadcast.check("PvpAccept", function ( data )
	EventCenter.eventInput("EventPvpAccept", data)
end)

Broadcast.check("PvpCancel", function ( data )
	EventCenter.eventInput("EventPvpCancel", data)
end)

local EventMap = {
	friend_invite='EventFriendInvite',
	friend_receiveAP='EventFriendReceiveAP',
	friend_verify='EventFriendVerify',
	letter_sys='EventLetterSystem',
	letter_friend='EventLetterFriend',
	task_reward='EventTaskReward',
	daily_task='EventDailyTask',
	boss_reload='EventBossReload',
	sign_verify='EventSignVerify',
	seven_days='EventSevenDays',
	training='EventActivity',
	roast_duck='EventActivity',
	daily_charge='EventActivity',
	onece_charge='EventActivity',
	total_charge='EventActivity',
	total_consume='EventActivity',
	lv_top='EventActivity',
	time_pet='EventActivity',
	first_charge = 'EventFirstRecharge',
	boss_down = "EventBossDown",
	guild_apply = "EventGuildApply",
	boss_over = "EventBossDownPlay",
	task_main = "EventTaskMain",
	arena = "EventArena",
	res_copy = "EventResCopy",
	pet_piece = "EventPetPiece",
	pray = "EventActivity",
	coin_well = "EventCoinWell",
	luxury_sign = "EventLuxurySign",
}

Broadcast.check("News", function ( data )
	print("News____")
	print(data)
	if data and data.D and data.D.Key then
		local gameFunc = require "AppData"
		local broadCastFunc = gameFunc.getBroadCastInfo()

		local event = EventMap[data.D.Key] or data.D.Key
		broadCastFunc.set(data.D.Key,true)
		EventCenter.eventInput(event,data)
	end
end)

Broadcast.check("GuildMember",function ( data )
	print("-----------Guild Agree------------")
	print(data)
	EventCenter.eventInput('GuildMember',data.D)
	require "GuildInfo".setGuildMember(data.D)
end)

Broadcast.check("FriendDetail",function ( data )
	print("-----------FriendDetail------------")
	print(data)
	require "FriendsInfo".addFriendToList(data.D)
	EventCenter.eventInput('EventFriendApplySuc',data.D)
end)

local chatFunc = require "ChatInfo"

Broadcast.check("Chat",function ( data )
	print("-----------new chat------------")
	print(data)
	EventCenter.eventInput("NewBroadcastChatGet", data.D)
	if data.D.ShareType~=4 then
		EventCenter.eventInput("NewChatGet",data.D)
	end
end)

----------------------------------战斗-----------------------------
Broadcast.check('Start', function ( data )
	-- body
	print('Start')
	print(data)

	-- local luaLayerManager = require "framework.interface.LuaLayerManager"
	-- luaLayerManager.closeAll()
	GleeCore:closeAllLayers() -- modify by te
	GleeCore:pushController('GameStart', data, nil, res.getTransitionFade())
end)

Broadcast.check('Go', function ( data )
	-- body
	print('recv Go!')
	EventCenter.eventInput(data.B, data)
end)

Broadcast.check('Move', function ( data )
	EventCenter.eventInput(data.B, data)
end)


Broadcast.check('Action',function(data )
	print('---------PVP 收到战斗协议----------')
	print(data)
	EventCenter.eventInput(data.B, data)
end)

Broadcast.check('Buff', function ( data )
	EventCenter.eventInput(data.B, data)
end)

Broadcast.check('Rbuff',function(data)
	EventCenter.eventInput(data.B, data)
end)

Broadcast.check('Finish', function ( data )
	EventCenter.eventInput(data.B, data)
end)

Broadcast.check("NHero",function( data )
	EventCenter.eventInput(data.B, data)
end)

Broadcast.check('Slot', function ( data )
	print('广播增加能量球...')
	print(data)
	EventCenter.eventInput(FightEvent.Pve_Slot, data)
end)	

Broadcast.check('PetRefresh',function ( data )
	EventCenter.eventInput('PetRefresh',data)
end)
