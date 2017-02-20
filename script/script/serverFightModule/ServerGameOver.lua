local EventCenter 	= require 'EventCenter'
local FightEvent 	= require 'FightEvent'

local ServerGameOver = class()

function ServerGameOver:ctor( luaset, document )
	-- body
	self._catchBossDone 		= true

	self._lastDieDone 			= false
	self._gameOverData 			= nil
	self._lastDiePlayerId 		= nil

	self._gameOverSended 		= false

	self._dropBoxFinishedMap 	= {}

	self:initEvents()
end

function ServerGameOver:initEvents()
	-- body

	--[[
	如果胜利, 是否有捕捉动画, 有的话, 必须等捕捉动画完成才结束
	--]]

	--[[
	胜利条件:
	1.产生了GameOverData win, 同时标记最后的单位id
	2.最后敌方角色死亡动画播放完成
	3.如果有捕捉动画, 捕捉动画播放完成
	--]]

	--[[
	1.产生了GameOverData lose, 同时标记最后的单位id
	2.我方最后的角色死亡动画, 播放完成
	--]]
	EventCenter.addEventFunc(FightEvent.Pve_NeedDropBox, function ( data )
		-- body
		assert(data)
		assert(data.playerId)

		self._dropBoxFinishedMap[data.playerId] = false
	end,'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_DropBoxAnimateFinished, function ( data )
		-- body
		assert(data)
		assert(data.playerId)

		assert( self._dropBoxFinishedMap[data.playerId] == false )
		self._dropBoxFinishedMap[data.playerId] = true

		self:check()
	end,'Fight')
	
	EventCenter.addEventFunc(FightEvent.Pve_NeedCatchBoss, function ( data )
		-- body
		if data then
			self._catchBossDone = false
		else
			self._catchBossDone = true
		end
	end,'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_IgnoreCatchBoss, function ( data )
		-- body
		-- assert(not self._catchBossDone)
		self._catchBossDone = true

		-- self:check()
		
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_DieAnimateFinished, function ( data )
		-- body
		local playerId = data.playerId
		assert(playerId)

		if self._gameOverData then
			local ServerRecord = require 'ServerRecord'
			local role
			
			if self._gameOverData.isWin then
				role = ServerRecord.getLastEnemyDeadRole()
				assert(role)
			else
				role = ServerRecord.getLastHeroDeadRole()
				assert(role)
			end

			if role:getDyId() == playerId then
				assert(not self._lastDieDone)
				self._lastDieDone = true
				self:check()
			end
		end
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_CatchBossFinished, function ( data )
		-- body
		assert(not self._catchBossDone)
		self._catchBossDone = true
		self:check()
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_PreGameOverData, function ( data )
		-- body
		if not self._gameOverData then
			-- print(debug.traceback())
			assert(not self._gameOverData)
			assert(data)
			self._gameOverData = data
			self:check()
		end
	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_GameOverQuick, function ( data )
		-- body
		assert(data)
		self._gameOverData = data

		self:sendGameOver()
	end, 'Fight')
end

function ServerGameOver:check()
	-- body
	if self:checkWin() or self:checkLost() then
		self:sendGameOver()
	end
end

function ServerGameOver:sendGameOver()
	-- body
	if (not self._gameOverSended) and self._gameOverData then
		self._gameOverSended = true
		EventCenter.eventInput( FightEvent.GameOver, self._gameOverData )
	end
end

function ServerGameOver:checkWin()
	-- body
	for i,v in pairs( self._dropBoxFinishedMap ) do
		if not v then
			return false
		end
	end

	return (self._gameOverData and self._gameOverData.isWin) and self._lastDieDone and self._catchBossDone
end

function ServerGameOver:checkLost()
	-- body
	return (self._gameOverData and not self._gameOverData.isWin) and self._lastDieDone
end


return ServerGameOver