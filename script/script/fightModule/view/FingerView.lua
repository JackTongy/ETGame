local FightTimer 			= require 'FightTimer'
local RolePlayerManager 	= require 'RolePlayerManager'
local RoleSelfManager 		= require 'RoleSelfManager'
local SelectPlayerProxy 	= require 'SelectPlayerProxy'
local ActionUtil 			= require 'ActionUtil'
local YFMath 				= require 'YFMath'
local GridManager 			= require 'GridManager'
local CfgHelper 			= require 'CfgHelper'
local SelectHeroProxy 		= require 'SelectHeroProxy'
local FightEvent 			= require 'FightEvent'
local EventCenter 			= require 'EventCenter'

local WinSize = CCDirector:sharedDirector():getWinSize()

local FingerView = class()

function FingerView:ctor( luaset )
	-- body
	self._luaset = luaset

	luaset['layer_touchLayer_line']:setVisible(false)
	luaset['layer_touchLayer_circle']:setVisible(false)
	--layer_touchLayerAbove_target
	luaset['layer_touchLayerAbove_target']:setVisible(false)

	--nil, red, green
	self._ShowTargetType = nil
	
	-- self:setPoint(-100,-100)

	self[1] = luaset[1]

	self._selectPlayer=nil

	luaset['layer_touchLayer']:setListener(function ( eventType, eventX, eventY )
		self:onTouch(eventType, eventX, eventY)		
	end)

	self:initEvents()
end


function FingerView:onTouch( eventType, eventX, eventY )
	-- body
	-- debug.catch(true, 'why me!')
	-- print(string.format('onTouch %d : %.2f, %.2f', eventType, eventX, eventY))

	local mapPos = YFMath.physic2logic( {x=eventX, y=eventY} )

	local mapX = mapPos.x
	local mapY = mapPos.y

	if self._selectPlayer and self._selectPlayer:isDisposed() then
		-- self:setPlayerRectVisible(self._selectPlayer)
		self._selectPlayer = nil
	end

	if eventType == 0 then

		-- 用做检测
		-- require 'framework.helper.Utils'.printG()
		
		local player = self:getPlayer(eventX, eventY)

		self:setPlayerRectVisible(self._selectPlayer, false)
		self:setPlayerRectVisible(player, true)

		if player then
			self._selectPlayer = player
			SelectPlayerProxy.setPlayer(self._selectPlayer)
			SelectHeroProxy.setSelectPlayer(self._selectPlayer)
			
			require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.bt_target )

			self._touchPos = { x=eventX, y=eventY }

			self._touchDownPos = { x=eventX, y=eventY }
			self._touchDownMills = SystemHelper:currentTimeMillis()

		else
			-- 维持原状
			if self._selectPlayer then
				self._touchPos = { x=eventX, y=eventY }

				self._touchDownPos = { x=eventX, y=eventY }
				self._touchDownMills = SystemHelper:currentTimeMillis()
			else
				self._touchPos = nil
			end
		end

		return false

	elseif eventType==1 then

		if self._selectPlayer and self._touchPos then
			self._touchPos = { x = eventX, y = eventY }
		else
			self._touchPos = nil
		end

		return false

	elseif eventType==2 then

		if self._selectPlayer and self._touchPos then

			local enemy = self:getEnemy(eventX,eventY)
			local friend = enemy or self:getPlayer(eventX, eventY, self._selectPlayer)

			local mapPos = { x=mapX, y=mapY }
			local centerPos = GridManager.getUICenterByPos( mapPos ) 
			
			if enemy then
				--
				self:goToTarget(self._selectPlayer, enemy, false)

				self:setPlayerRectVisible(self._selectPlayer, false)
				self._selectPlayer = nil
				-- SelectPlayerProxy.setPlayer(self._selectPlayer)
				-- SelectHeroProxy.setPlayer(self._selectPlayer)

			elseif friend then
				self:goToTarget(self._selectPlayer, friend, true)

				self:setPlayerRectVisible(self._selectPlayer, false)
				self._selectPlayer = nil

			elseif centerPos and GridManager.isSelfUICenterValid( self._selectPlayer, centerPos ) and GridManager.isPosInBattleField(centerPos) then
				
				local currentX = self._selectPlayer:getMapX()
				local currentY = self._selectPlayer:getMapY()

				if currentX ~= centerPos.x or currentY ~= centerPos.y then
					self:goToPosition(self._selectPlayer, centerPos )

					print('currentX '..currentX)
					print('currentY '..currentY)
					print('centerPos.x '..centerPos.x)
					print('centerPos.y '..centerPos.y)

					self:setPlayerRectVisible(self._selectPlayer, false)
					self._selectPlayer = nil
					-- SelectPlayerProxy.setPlayer(self._selectPlayer)
					-- SelectHeroProxy.setPlayer(self._selectPlayer)
					print('abcde33333')
				end
				print('abcde22222')
			else
				--do nothing
				if self._touchDownPos then
					local now = SystemHelper:currentTimeMillis()
					self:decodeWipe(self._touchDownPos.x, self._touchDownPos.y, eventX, eventY, (now-self._touchDownMills) )
				end
			end 
		else
			print('abcde')
		end

		self._touchPos = nil

		return false
		
	end
end

function FingerView:initEvents()
	-- body
	EventCenter.addEventFunc('Guider_TouchEvent', function ( data )
		-- body
		assert(data)
		assert(data.eventType)
		assert(data.x)
		assert(data.y)

		-- 逻辑转化?
		-- 不需要转化
		-- data.x = data.x * WinSize.width/1136
		-- data.y = data.y * WinSize.height/640

		self:onTouch(data.eventType, data.x, data.y)

	end, 'Fight')
end

function FingerView:decodeWipe( x1,y1,x2,y2, mills )
	-- body
	if self._selectPlayer and self._touchPos then
		if mills < 1500 and mills > 0 then
			local distance = math.sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) )
			local speed = distance/mills
			print('decodeWipe speed = '..speed)

			if speed > 0.25 then
				local stepX = 50*(x2-x1)/distance
				local stepY = 50*(y2-y1)/distance

				local enemy = self:getEnemyByVector(x2, y2, stepX, stepY)
				if enemy then
					self:goToTarget(self._selectPlayer, enemy, false)
					self:setPlayerRectVisible(self._selectPlayer, false)
					self._selectPlayer = nil
				else
					local uiCenter = self:getSelfUICenter(x2, y2, stepX, stepY, self._selectPlayer)
					if uiCenter then
						self:goToPosition(self._selectPlayer, uiCenter)
						self:setPlayerRectVisible(self._selectPlayer, false)
						self._selectPlayer = nil
					end
				end
			end
		end
	end
	
end


--[[

--]]


function FingerView:goToPosition( player, pos )
	-- body
	if self._touchDownPos and self._touchPos then
		local playerPosX = player:getMapX()
		local playerPosY = player:getMapY()

		local dx = math.abs(playerPosX - self._touchPos.x)
		local dy = math.abs(playerPosY - self._touchPos.y)
		if dx <= 4 and dy <= 4 then
			return
		end 
	end

	EventCenter.eventInput(FightEvent.FingerView_goToPosition, { player=player, pos = pos} )

	-- player:cancelAttack()
	player:setOuterCommand( pos, false )
	-- player:executeOuterCommand()
end

function FingerView:goToTarget( player1, player2, isfriend )
	-- body
	
	if player1 and player2 then
		EventCenter.eventInput(FightEvent.FingerView_goToTarget, {player1=player1, player2=player2, isfriend=isfriend} )

		if not player1:isDisposed() and not player2:isDisposed() then
			if isfriend then
				local pos1 = player1:getPosition()
				local pos2 = player2:getPosition()

				player1:setOuterCommand( pos2, false ) 
				player2:setOuterCommand( pos1, false ) 

				-- player1:executeOuterCommand()
				-- player2:executeOuterCommand()
			else 
				player1:setOuterCommand( player2, true ) 
				
				-- player1:executeOuterCommand()
			end
		end
	end
end


--[[
--]]
function FingerView:detectGesture( p1x, p1y, p2x, p2y, t )
	-- body
	if t < 200 then
		--优先敌人
		

		--其次格子
		
		
	end
end



function FingerView:setPlayerRectVisible( player, visible )
	-- body
	if player and not player:isDisposed() then
		local node = player:getLuaSet()['selectBox']
		local action
		if visible then
			action = self._luaset['ActionSelectRectShow']:clone()
		else
			action = self._luaset['ActionSelectRectHide']:clone()
		end

		node:runElfAction( action )
	end
end

function FingerView:start(  )
	-- body
	self._handler = FightTimer.tick(function ( dt )
		-- body
		self:update(dt)
	end)
end

function FingerView:stop(  )
	-- body
	if self._handler then
		FightTimer.cancel(self._handler)
		self._handler = nil
	end
end

--[[
设置line
--]]
function FingerView:setTwoPoints( pos1, pos2 )
	self._beginPos = {x=pos1.x, y=pos1.y}
	self._endPos = {x=pos2.x, y=pos2.y}

	local ccpos1 = ccp(pos1.x, pos1.y)
	local ccpos2 = ccp(pos2.x, pos2.y)

	-- body
	
	local line = self._luaset['layer_touchLayer_line']

    NodeHelper:setPositionInScreen(line, ccpos1)

    local dx = ccpos1.x-ccpos2.x
    local dy = ccpos1.y-ccpos2.y

    local rotation = math.atan2(dx, dy) * 180 / math.pi

    line:setRotation(90+rotation)

    local size = line:getContentSize()
    local ds = math.sqrt(dx*dx+dy*dy)
    local scaleX = ds/size.width
    line:setScaleX(scaleX)

    if self._beginPos.x < 0 or self._endPos.x < 0 then
    	line:setVisible(false)
    	-- circle:setVisible(false)
	else
		line:setVisible(true)
    	-- circle:setVisible(true)
	end

	-- local circle = self._luaset['layer_touchLayer_circle']
    -- NodeHelper:setPositionInScreen(circle, ccpos2)
end


function FingerView:updateLine( scopePos )
	-- body
	--更新line
	local line = self._luaset['layer_touchLayer_line']
	if self._selectPlayer and self._touchPos then
		local mapPos = { x = self._selectPlayer:getMapX(), y = self._selectPlayer:getMapY() }

		local pos1 = YFMath.logic2physic(mapPos)
		local pos2 = scopePos or self._touchPos

		if pos2.y >= 90 and pos2.y <= 490 then
			line:setVisible(true)
			self:setTwoPoints( pos1, pos2 )
		else
			self._touchPos = nil
			line:setVisible(false)
		end
	else
		line:setVisible(false)
	end
end

--[[
返回是否有target
--]]
function FingerView:updateTarget(  )
	-- body
	local target = self._luaset['layer_touchLayerAbove_target']
	-- target:setVisible(false)

	local enemy
	local friend

	if self._selectPlayer and self._touchPos then
		enemy = self:getEnemy(self._touchPos.x, self._touchPos.y) 

		if not enemy then
			friend = self:getPlayer(self._touchPos.x, self._touchPos.y, self._selectPlayer ) 
		end

		if enemy then
			local pos = YFMath.logic2physic( enemy:getPosition() )
			NodeHelper:setPositionInScreen(target, ccp(pos.x, pos.y + 50))

			-- target:setColorf(1,0,0,1)
			-- target:setVisible(true)
		elseif friend then
			local pos = YFMath.logic2physic( friend:getPosition() )
			NodeHelper:setPositionInScreen(target, ccp(pos.x, pos.y))

			-- target:setColorf(1,1,1,1)
			-- target:setVisible(true)
		end
	end

	local shouldChange = false

	if self._ShowTargetType == nil then
		if enemy or friend then
			shouldChange = true
		end

	elseif self._ShowTargetType == 'green' then
		if enemy or (not friend) then
			shouldChange = true
		end

	elseif self._ShowTargetType == 'red' then
		if friend or (not enemy) then
			shouldChange = true
		end
	end

	if shouldChange then
		if enemy then
			target:setVisible(true)
			target:setColorf(1,0,0,1)
			local action = self._luaset['ActionLockTarget']:clone()
			target:runElfAction(action)
			self._ShowTargetType = 'red'
		elseif friend then
			target:setVisible(true)
			target:setColorf(1,1,1,1)
			local action = self._luaset['ActionLockFriend']:clone()
			target:runElfAction(action)
			self._ShowTargetType = 'green'
		else 
			local action = self._luaset['ActionLockTargetHide']:clone()
			target:runElfAction(action)
			self._ShowTargetType = nil
		end
	end

	-- return (not tolua.isnull(target)) and target:isVisible()
end

function FingerView:updateScope( needUpdate )
	-- body
	--更新circle or rectangle, 是否处在空的格子里面
	
	local circle = self._luaset['layer_touchLayer_circle'] 
	local rectangle = self._luaset['layer_touchLayer_rectangle'] 
	circle:setVisible(false)
	rectangle:setVisible(false)

	--貌似不需要这个needUpdate
	needUpdate = true
	if (not self._selectPlayer) or (not self._touchPos) or (not needUpdate) then
		return
	end

	local player = self._selectPlayer

	local charactorId = player.roleDyVo.basicId
	local charactorVo = CfgHelper.getCache('charactorConfig', 'id', charactorId)

	local isAdvancedSkill = charactorVo.advance_skill ~= 0
	local skillid = ( isAdvancedSkill and charactorVo.advance_skill ) or charactorVo.default_skill

	local mapPos = YFMath.physic2logic(self._touchPos)

	local pos = GridManager.getUICenterByPos(mapPos)
	
	--是否在自己的九宫格的区域
	local isSelfPoint = GridManager.isInSelfCampByPos( pos, player:isOtherPlayer() )

	if (isSelfPoint and GridManager.isSelfUICenterValid( self._selectPlayer, pos )) or ( (not isSelfPoint) and (self:isInHeroRect(player, self._touchPos)) ) then
		--
	else
		--do nothing
		return
	end 

	--range = {1,1},	shapes = 2
	local skillVo = CfgHelper.getCache('skill', 'id', skillid)
	-- print('skillid')
	-- print(skillid)

	--动态的扩大的比例, 比如治疗
	local range = player:getRange( skillVo )

	local shapes = skillVo.shapes

	if shapes == 1 then
		--1矩形
		rectangle:setVisible(true)
		rectangle:setColorf(1,0,0,0.5)

		--range[2]
		local width = rectangle:getWidth()
		local height = rectangle:getHeight()

		local scaleX = range[1] * GridManager.getUIGridWidth() / width
		local scaleY = range[2] * GridManager.getUIGridHeight() / height
		rectangle:setScaleX(scaleX)
		rectangle:setScaleY(scaleY)

		-- circle
		-- local oldPos = NodeHelper:get
		-- rectangle:setPosition(ccp())
		-- pos.x = pos.x / EVENT_TO_LOGIC_X_RATE
		-- pos.y = pos.y / EVENT_TO_LOGIC_Y_RATE

		local screenPos = YFMath.logic2physic(pos)

		NodeHelper:setPositionInScreen( rectangle, ccp(WinSize.width/2, screenPos.y ) )

		return screenPos

	elseif shapes == 2 then
		--2椭圆
		circle:setVisible(true)

		-- local scale 
		local width = circle:getWidth()
		local height = circle:getHeight()

		local scaleX = 2 * range[1] * GridManager.getUIGridWidth() / width
		local scaleY = 2 * range[2] * GridManager.getUIGridHeight() / height

		circle:setScaleX(scaleX)
		circle:setScaleY(scaleY)

		if not isAdvancedSkill then
			circle:setColorf(1,0,0,0.5)
		else 
			circle:setColorf(0,1,0,0.5)
		end

		if (isSelfPoint and GridManager.isSelfUICenterValid( self._selectPlayer, pos )) then
			local screenPos = YFMath.logic2physic(pos)
			NodeHelper:setPositionInScreen( circle, ccp(screenPos.x , screenPos.y ) )
			
			return screenPos

		elseif ( (not isSelfPoint) and (self:isInHeroRect(player, self._touchPos)) ) then

			local x = player:getMapX()
			local y = player:getMapY()
			
			local screenPos = YFMath.logic2physic( {x=x, y=y} )
			NodeHelper:setPositionInScreen( circle, ccp(screenPos.x , screenPos.y ) )
			return screenPos
		end
	else
		print('unexpected shape:'..shapes)
	end

end

--bind
function FingerView:update( dt )
	-- body
	if self:isDisposed() then
		return
	end

	--更新target, always run action
	local isTargetNeed = self:updateTarget()

	--更新范围
	local scopePos = self:updateScope( (not isTargetNeed) )

	--更新line
	-- print('scopePos')
	-- print(scopePos)

	self:updateLine(scopePos)

end

--[[
eventX
--]]
function FingerView:getPlayer( eventX,eventY, current )

	print('eventX = '..eventX..', eventY = '..eventY)

	local mapPos = YFMath.physic2logic( {x=eventX, y=eventY} )

	local mapX = mapPos.x
	local mapY = mapPos.y

	local map = RolePlayerManager.getOwnPlayerMap()

	local myplayer
	local mymin = 10000

	for k, player in pairs(map) do
		if not player:isDead() and player ~= current then
			if player:isInRect(eventX, eventY) then

				local x = player:getMapX()
				local y = player:getMapY()
				local dis = math.sqrt( (mapX-x)*(mapX-x) + (mapY-y)*(mapY-y) )

				if not myplayer then
					mymin = dis
					myplayer = player
				else
					if dis < mymin then
						mymin = dis
						myplayer = player
					end
				end
			end
		end
	end
	return myplayer
end

function FingerView:getSelfUICenter( eventX,eventY, vx, vy, player )
	-- body
	local mapPos = YFMath.physic2logic( {x=eventX, y=eventY} )

	local mapX = mapPos.x
	local mapY = mapPos.y

	local map = RolePlayerManager.getOtherPlayerMap()

	local myUiCenter
	local mymin = 10000

	local arr = GridManager.getSelfIdleUICenterArraySorted( player )

	for k, uiCenter in ipairs(arr) do
		local x = uiCenter.x
		local y = uiCenter.y

		local dis = math.sqrt( (mapX-x)*(mapX-x) + (mapY-y)*(mapY-y) )

		if dis <= 0 then
			return nil
		end

		local vx2 = (x-mapX)/dis
		local vy2 = (y-mapY)/dis

		local xiangliang = vx*vx2 + vy*vy2
		if xiangliang > 0.86 then
			if not myUiCenter then
				mymin = dis
				myUiCenter = uiCenter
			else
				if dis < mymin then
					mymin = dis
					myUiCenter = uiCenter
				end
			end
		end		
	end
	return myUiCenter
end

function FingerView:getEnemy(eventX,eventY)

	local mapPos = YFMath.physic2logic( {x=eventX, y=eventY} )

	local mapX = mapPos.x
	local mapY = mapPos.y

	local map = RolePlayerManager.getOtherPlayerMap()

	local myplayer
	local mymin = 10000

	for k, player in pairs(map) do
		if not player:isDead() then
			if player:isInRect(eventX, eventY) then

				local x = player:getMapX()
				local y = player:getMapY()
				local dis = math.sqrt( (mapX-x)*(mapX-x) + (mapY-y)*(mapY-y) )

				if not myplayer then
					mymin = dis
					myplayer = player
				else
					if dis < mymin then
						mymin = dis
						myplayer = player
					end
				end
			end
		end
	end
	return myplayer
end

function FingerView:getEnemyByVector( eventX,eventY, vx, vy )
	-- body
	local mapPos = YFMath.physic2logic( {x=eventX, y=eventY} )

	local mapX = mapPos.x
	local mapY = mapPos.y

	local map = RolePlayerManager.getOtherPlayerMap()

	local myplayer
	local mymin = 10000

	for k, player in pairs(map) do
		if not player:isDead() then
			local x = player:getMapX()
			local y = player:getMapY()

			local dis = math.sqrt( (mapX-x)*(mapX-x) + (mapY-y)*(mapY-y) )

			if dis <= 0 then
				return player
			end

			local vx2 = (x-mapX)/dis
			local vy2 = (y-mapY)/dis

			local xiangliang = vx*vx2 + vy*vy2
			if xiangliang > 0.86 then
				if not myplayer then
					mymin = dis
					myplayer = player
				else
					if dis < mymin then
						mymin = dis
						myplayer = player
					end
				end
			end

			
		end
	end
	return myplayer
end

function FingerView:isInHeroRect( player, touchpos )
	-- body
	if player and touchpos and not player:isDead() then
		if player:isInRect(touchpos.x, touchpos.y) then
			return true
		end
	end
end

function FingerView:isDisposed(  )
	-- body
	return self._luaset == nil or self._luaset[1] == nil or tolua.isnull( self._luaset[1] )
end


return FingerView
