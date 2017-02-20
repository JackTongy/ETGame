local client = require 'SocketClientPvp'
local roleSelfManager = require "RoleSelfManager"
local fightEvent = require "FightEvent"
local eventCenter = require "EventCenter"
local manage = {}
local timeManager = require 'TimeManager'
-- moveCompleteDir是移动完成后站立的方向 因为 回归站位的移动最终停下来的方向可能和移动的方向不一致，所以这里需要加一个方向标志一下  他是可选的只有回归站位时才发送
manage.updatePos = function ( player, dest, freq,moveCompleteDir,changeDir)
	
	if roleSelfManager.isPvp then
				-- body
		moveCompleteDir= moveCompleteDir or -1
		local now = SystemHelper:currentTimeMillis() 
		player._pretime = player._pretime or now
		local playerId = player.roleDyVo.playerId
		freq = freq or 1000
		if now - player._pretime >= freq then

			local cpos = player:getPosition()
			cpos.x=math.floor(cpos.x)
			cpos.y=math.floor(cpos.y)
			-- local message = { C="Move",T=playerId, Msg= { x=dest.x, y=dest.y,currentX=cpos.x,currentY=cpos.y}, Name="walk"}
			dest={x=dest.x,y=dest.y}
			dest.x=math.floor(dest.x)
			dest.y=math.floor(dest.y)


			local osTime =timeManager.getCurrentSeverTimeByOs()  --os.time()*1000  -- C++时间的毫秒获取有问题 
			print("osTime=="..osTime)

			local message = { C="Move", D={Hid=playerId, Pf={[1]=cpos.x,[2]=cpos.y},Pt={[1]=dest.x,[2]=dest.y} ,T=osTime }}  --  T== now

			if moveCompleteDir ~=-1  then  			--设置站立的方向  因为 角色回归站位时候需要方向 
				message.D.Dir=moveCompleteDir
			end

			message.D.ChangeDir=changeDir
	    	client:send(message,nil)

	    	player._pretime = now
	    	
				-- print(playerId..'在移动中....'..now)
				-- print('lua time:'..os.time()*1000)
		end

		-- pvp  歌舞
		if player.roleDyVo.isGeWu then
			print("处理PVP歌舞")
			eventCenter.eventInput(fightEvent.Pvp_removeGeWuBuff,player)   --- pvp  buff解除处理在fightController 进行

		end

	else  --- pve 
		if player.roleDyVo.isGeWu then
			print("处理PVe歌舞")
			eventCenter.eventInput(fightEvent.Pve_removeGeWuBuff,player)
		end
	end
end

manage.sendProtect = function ( hid, dur )
	-- body
	local msg = {}
	msg.C = 'HProtect'
	msg.D = {}
	msg.D.Hid = hid
	msg.D.Dur = dur

	client:send(msg)
end

manage.sendUpdatePos = function ( playerId,pos )
	-- body
	local msg= {}
	msg.C = 'Position'

	local k = tostring(playerId)

	msg.D = {}
	msg.D.S = {}
	msg.D.S[1] = {}
	msg.D.S[1][k] = { math.floor(pos.x), math.floor(pos.y) }

	client:send(msg,nil)
end

manage.sendRemoveDance = function ( playerId, skillId )
	-- body
	local msg = {}
	msg.C = 'Remove_Dance_Buff'
	msg.D = { Hid = playerId, Sid = skillId }

	client:send(msg, nil)
end

--发送socket消息
--发送战斗消息
manage.sendFight=function (cmsg )
	-- body
	-- cmsg.T=SystemHelper:currentTimeMillis()
	local message = {C="Action",D=cmsg}
	if roleSelfManager.isPvp then  -- pvp 

		cmsg.isCrit = nil   --去掉信息里的暴击字段
		local osTime = require 'TimeManager'.getCurrentSeverTimeByOs() --os.time()*1000  -- C++时间的毫秒获取有问题 
		cmsg.T=osTime

		print('---------PVP 发送战斗协议----------')
		print(message)

		client:send(message,nil)
		print('直接开始战斗....'..osTime)
	else		
		print('pve请求战斗....')
		eventCenter.eventInput(fightEvent.Pve_SendAction,message)
	end


end
return manage