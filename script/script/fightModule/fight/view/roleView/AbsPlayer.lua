--[[
	战斗场景中活动单位的抽象类
]]
require 'MoveVo'

local TweenSimple 					= require 'TweenSimple'
local RoleDyVo 						= require 'RoleDyVo'
local BuffEffectView 				= require 'BuffEffectView'
local DirUtil 						= require 'DirectionUtil'
local ActionManager 				= require 'ActionUtil'
local YFMath 						= require 'YFMath'
local UpdateRate 					= require 'UpdateRate'
local TimeManager 					= require 'TimeManager'
local GridManager 					= require 'GridManager'
local LayerManager 					= require 'LayerManager'
local Utils 						= require 'framework.helper.Utils'
local RolePlayerManager 			= require 'RolePlayerManager'
local DeadBallManager 				= require 'DeadBallManager'
local EventCenter 					= require 'EventCenter'
local FightEvent 					= require 'FightEvent'
local RoleSelfManager 				= require 'RoleSelfManager'
local RoleView 						= require 'RoleView'
local TimeOutManager 				= require "TimeOut"
local TypeRole 						= require 'TypeRole'
local CallBackManager 				= require "CallBackManager"
local CfgHelper 					= require 'CfgHelper'
local SkinManager 					= require 'SkinManager'
local SkillUtil 					= require 'SkillUtil'
local Global 						= require 'Global'
local ActionUtil 					= require 'ActionUtil'
local CharactorConfigBasicManager 	= require 'CharactorConfigBasicManager'
local GridManager 					= require 'GridManager'

local AbsPlayer=class()

--[[
charactorId
booldType
--]]
function AbsPlayer:ctor( args )
	if Global.Battle_Use_View then
		self._cloth = RoleView.getViewCacheByArgs( args )
	end
	
	-- self._skiilDyManager=SkillDyMananger.new() --该玩家的技能列表
	self._tweenSimple = TweenSimple.new()
	self._activeDirection = ActionManager.Direction_Right
	self._activeAction = ActionManager.Action_Stand

	-- 静态数据  到时候需要配置到人物身上   警戒范围
	-- self._warningArea=100
	self._isDispose = false
	self._moveVo = MoveVo.new()
	self._mapX = 0
	self._mapY = 0

	self._fightTarget = nil -- 当前战斗的目标
	self.bigSkillOnTrigger = false

	self._callBackManager = CallBackManager.new()

	self._buffMap = {}

	self:intBuffContainer()

	self._atkSpdRate = 1
end

function AbsPlayer:initSelectBox()
	-- body
	if self._cloth then
		self._cloth:initSelectBox()
	end
end

function AbsPlayer:getCloth()
	-- body
	return self._cloth
end


function AbsPlayer:initForIsDancer()
	-- body
	self._isDancer = false
	local roleDyVo = self.roleDyVo
	assert(roleDyVo)

	local basicId = roleDyVo.basicId
	local charVo = CfgHelper.getCache('charactorConfig','id', basicId)
	roleDyVo.skill_id = charVo.skill_id
	
	local skillVo = CfgHelper.getCache('skill', 'id', roleDyVo.skill_id)
	if skillVo then
		if skillVo.skilltype == SkillUtil.SkillType_Dance then
			self._isDancer = true
		end
	end
end

function AbsPlayer:initRoleDyVo( roleDyVo )
	if roleDyVo then
		self.roleDyVo=roleDyVo
	else
		self.roleDyVo=RoleDyVo.new()
		self.roleDyVo.hpPercent=100
	end

	self:initForIsDancer()

	assert(self.roleDyVo)

	if self._cloth then
		self._cloth:setRoleDyVo( self.roleDyVo, self:getCareer() )
	end
end

function AbsPlayer:isOwnerTeam()
	-- body
	-- return RolePlayerManager.isHero( self )
	return self.roleDyVo.dyId == RoleSelfManager.dyId
end

--是否处在移动中
function AbsPlayer:isMove()
	if self:isDisposed() then
		return false
	end

	return self._tweenSimple:isStart()
end

-- override 
function AbsPlayer:startAI()
	-- body
	assert(false)
end

function AbsPlayer:stopAI()
	-- body
end

function AbsPlayer:getCareer()
	-- body
	local basicId = self.roleDyVo.basicId
	local charactorConfigBssicVo = CharactorConfigBasicManager.getCharactorBasicVo(basicId)
	return charactorConfigBssicVo.atk_method_system
end


--画面停止

function AbsPlayer:pause(  )
	if self:isDisposed() then
		return false
	end

	self:stopAI()
	self._tweenSimple:stop();
	self:play(ActionManager.Action_Stand)
end

--画面恢复
function AbsPlayer:resume(  )
	if self:isDisposed() then
		return false
	end

	self:startAI()
end

--更新血条ui
function AbsPlayer:updateBloodPercent( newHpP, hurtValue, skillId, isCrit)
	-- newHpP = newHpP or 100
	if self:isDisposed() then
		return false
	end

	if newHpP then
		self.roleDyVo.hpPercent = newHpP
		--减血量上限技能
		local serevrRole = require 'ServerController'.findRoleByDyIdAnyway(self.roleDyVo.playerId)
		self.roleDyVo.hpPercentReal = serevrRole and serevrRole:getHpPCure() or newHpP
		--

		if self._cloth then
			self._cloth:hurtValue(hurtValue, skillId, isCrit)
			self._cloth:setBloodPercentage(newHpP, hurtValue)
		end
	end
end

-- 
function AbsPlayer:setBloodViewVisible( visible )
	-- newHpP = newHpP or 100
	if self._cloth then
		self._cloth:setBloodVisible( visible )
	end
end

function AbsPlayer:setClothVisible( visible )
	-- newHpP = newHpP or 100
	if self._cloth then
		self._cloth:setVisible( visible )
	end
end


function AbsPlayer:updateBloodBar()
	if self:isDisposed() then
		return false
	end

	if self._cloth then
		self._cloth:setBloodPercentage(self.roleDyVo.hpPercent)
	end
end

-- function AbsPlayer:runWithDelay( func,delay )
-- 	-- body
-- 	if self:isDisposed() then
-- 		return false
-- 	end

-- 	self._cloth:runWithDelay(func, delay)
-- end

function AbsPlayer:runWithDelay(func, delay)
	-- body
	if self:isDisposed() then
		return false
	end
	local timeOut = TimeOutManager.getTimeOut(delay,func)
	timeOut:start()
end

function AbsPlayer:lock()
	assert(false)
	self._isLock = true
end
function AbsPlayer:unLock()
	assert(false)
	self._isLock = false
end

function AbsPlayer:isLock()
	return self._isLock
end

function AbsPlayer:addLabel( node )
	-- body
	if self:isDisposed() then
		return false
	end

	if self._cloth then
		self._cloth:addLabel( node )
	end
end

function AbsPlayer:getRootNode()
	return self._cloth and self._cloth:getRootNode()
end

function AbsPlayer:getLuaSet(  )
	return self._cloth and self._cloth:getLuaset()
end

-- @override 
function AbsPlayer:initBlood(  )
	assert(false)
	-- self._cloth:initBloodViewByType('Boss')
end

function AbsPlayer:intBuffContainer( )
	local set = self:getLuaSet()
	if set then
		self._upBuffView = BuffEffectView.new()
		self._upBuffView:setBuffContainer(set['upContainer'])
		self._downBuffView = BuffEffectView.new()
		self._downBuffView:setBuffContainer(set['downContainer'])

		self._cloth:setBuffEffectView(self._upBuffView, self._downBuffView)
	end
end



-- 设置名字
function AbsPlayer:setName( name )
	-- assert(self._cloth:getLuaset(),"函数调用错误")
	if self:isDisposed() then
		return false
	end

	if self._cloth then
		self._cloth:setName(name)
	end
end


function AbsPlayer:getActiveAction(  )	
	return self._activeAction
end

function AbsPlayer:getActiveDirection(  )	
	return self._activeDirection
end

--设置坐标但是不设置这个位置占有格子
function AbsPlayer:setPositionWithoutGrid(mapX,mapY )
	self._moveVo.x = mapX
	self._moveVo.y = mapY

	self:updatePostion()
end

function AbsPlayer:setPosition(mapX,mapY )
	self._moveVo.x = mapX
	self._moveVo.y = mapY

	self:updatePostion()

	self:updateGrid()
end

function AbsPlayer:getMapX( )
 	return self._mapX;

end

function AbsPlayer:getMapY( )
	return self._mapY;
end


function AbsPlayer:getPosition()
	return {x=self._mapX,y=self._mapY}
end


---for override
function AbsPlayer:checkPlayAction( action)
	-- body
end

function AbsPlayer:checkAction( action )
	-- body
	if not self:isMonster() then
		if action == ActionManager.Action_Stand then
			if self.roleDyVo and self.roleDyVo.hpPercent >= 20 then
				action = ActionManager.Action_NoramlStand
			else
				action = ActionManager.Action_XuRuoStand
			end
		end

		if action == ActionManager.Action_Walk then
			if self.roleDyVo and self.roleDyVo.hpPercent >= 20 then
				action = ActionManager.Action_NormalWalk
			else
				action = ActionManager.Action_XuRuoWalk
			end
		end
	else
		if action == ActionManager.Action_Stand then
			action = ActionManager.Action_NoramlStand
		end

		if action == ActionManager.Action_Walk then
			action = ActionManager.Action_NormalWalk
		end
	end

	return action
end


--[[
minForceDelay 秒
--]]
function AbsPlayer:play(action, direction,loop, completeFunc ,reset, forceComplete, minForceDelay)
	if self:isDisposed() then
		return false
	end

	action = self:checkAction( action )

	minForceDelay = minForceDelay or 0

	if loop == nil then
		loop = true
	end

	reset = reset or false

	if direction == nil or direction == -1 then 
		direction = self._activeDirection
	end

	if not reset then
		if action == self._activeAction and self._activeDirection == direction then

			self:runCurrentCallback(completeFunc, 0)
			self:runForceCallback(forceComplete, 0)

			if self._cloth then
				self._cloth:setMoveSpeed(self.roleDyVo.speed)
			end

			return false
		end
	end

	if action ~= ActionManager.Action_NoramlStand and action ~= ActionManager.Action_XuRuoStand then
		self:cleanAllAtkEffectViews()
	end

	self._activeAction = action
	self._activeDirection = direction

	self:onSetDirection( self._activeDirection )

	local time = self:getAnimateTimeByName(action)/1000

 	time = math.max(time, minForceDelay)

 	self:runCurrentCallback(completeFunc, time)
	self:runForceCallback(forceComplete, time)

	if self._cloth then
		self._cloth:play(action, direction, loop, reset)
		self._cloth:setMoveSpeed( self.roleDyVo.speed )
	end

	return true
end


function AbsPlayer:onPlayDead( delay, attacker)
	-- body
end

function AbsPlayer:isPlayDeadCalled()
	-- body
	return self._playDeadCalled
end

--攻击者
--播放 死亡动作
function AbsPlayer:playDead( attacker, delay, completeCall )

	assert( delay>=0 )

	-- self:runWithDelay(function ()
		-- body
		if not self._playDeadCalled then
			self._playDeadCalled = true

			self:cleanAllAtkEffectViews()

			if completeCall then
				local timeOut = TimeOutManager.getTimeOut((200+delay)/1000,function ( )
					completeCall()
				end)
				timeOut:start()
			end

			-- -----死亡能量球
			-- local num = DeadBallManager.getDeadBall( self.roleDyVo.playerId )
			-- print('playDead id = '..self.roleDyVo.playerId..' slot = '.. num)
			-- for i=1,num do
			-- 	local data = {}
			-- 	local pos = self:getPosition()
			-- 	pos = YFMath.logic2physic(pos)
			-- 	pos.x = pos.x - GridManager.getLogicWidth()/2
			-- 	pos.y = pos.y - GridManager.getLogicHeight()/2

			-- 	data.pos = pos

			-- 	EventCenter.eventInput(FightEvent.Pve_DieBall, data)
			-- end

			if self._cloth then
				self._cloth:playDead(delay)
			end

			local dieTime = self:getAnimateTimeByName( ActionUtil.Action_Dead )

			---通知死亡动画完成
			do
				local timeOut = TimeOutManager.getTimeOut((0+delay+dieTime)/1000,function ( )
					EventCenter.eventInput(FightEvent.Pve_DieAnimateFinished , { playerId = self.roleDyVo.playerId } )
				end)
				timeOut:start()
			end

			self:onPlayDead(delay/1000, attacker)
		end
	-- end, 0.4)
end

		
--[[
 @param action  动作
 @param direction 值为  -1 表示采用 先前的方向
 @param delay	函数播放时间轴    delay 的单位是毫秒
 @param playFunc	执行函数
 @param playParam	函数参数
 @completeFunc   playFunc每次执行完成后调用
 @completeParam	playFunc参数

	forceComplete  逻辑回调
 ######@totalTimes  执行的总时间     totalTimes一般大于等于 timesArr[timesArr.length-1]
 ######@totalCompleteFunc  时间到后执行的函数
]]
 
function AbsPlayer:splay(action,direction,loop,delay,completeFunc,forceComplete)
	self:runWithDelay(function ()
		-- body
		self:play(action, direction, loop, completeFunc, true, forceComplete)

	end, delay/1000)
end

--[[
	是否选中了该角色
]]
function AbsPlayer:isInRect( x, y )
	return self._cloth and self._cloth:isInRect( x, y )
end


--[[
停止移动
]]
function AbsPlayer:stopMove(  )
	if self:isDisposed() then
		return false
	end

	self._tweenSimple:stop()
	self:updateGrid()
end

--设置方向
function AbsPlayer:updatePathDirection(x,y)
	if( self._moveVo.x ~=x ) then  ---  这里需要判断下  同一个点 不需要进行方向矫正
		local direction = DirUtil.getDireciton(self._moveVo.x,x)
		-- print('updatePathDirection = '..direction)
		self:play(ActionManager.Action_Walk, direction)
	else
		self:play(ActionManager.Action_Walk)
	end
end


--[[
	map坐标转化为opengl坐标
]]
function AbsPlayer:updatePostion( )
	-- body
	self._mapX = math.floor(self._moveVo.x)   --double  to int 
	self._mapY = math.floor(self._moveVo.y) 

	if self._cloth then
		local conevrtPos = YFMath.getUIPoint({x=self._mapX,y=self._mapY})

		local x = conevrtPos.x - GridManager.getLogicWidth()/2
		local y = conevrtPos.y - GridManager.getLogicHeight()/2
		self._cloth:setPosition(x, y)

		self:onSetClothPos(x, y)
	end
end

function AbsPlayer:onSetClothPos( x, y )
	-- body
end

function AbsPlayer:onSetDirection( dir )
	-- body
end

--添加上层buff
function AbsPlayer:addUpBuff(buffId, negetive)
	-- print('AbsPlayer:addUpBuff()'..buffId)
	if self:isDisposed() then
		return false
	end

	if buffId and not negetive then
		self._buffMap[buffId] = true
	end

	if self._upBuffView then
		self._upBuffView:addBuff(buffId, negetive,self._activeDirection,false)
	end

	if self._downBuffView then
		self._downBuffView:addBuff(buffId, negetive,self._activeDirection,true)
	end
end

--添加下层buff
function AbsPlayer:removeUpBuff( buffId )
	-- print('AbsPlayer:removeUpBuff()'..buffId)

	if buffId and self._buffMap then
		self._buffMap[buffId] = nil
	end

	if self:isDisposed() then
		return false
	end

	if self._upBuffView then
		self._upBuffView:removeBuff(buffId,false)
	end

	if self._downBuffView then
		self._downBuffView:removeBuff(buffId,true)
	end
end

--添加上层buff
function AbsPlayer:addDownBuff( buffId, negetive )
	-- print('AbsPlayer:addDownBuff()'..buffId)
	if self:isDisposed() then
		return false
	end

	if self._downBuffView then
		self._downBuffView:addBuff(buffId, negetive,true)
	end
end

--添加下层buff
function AbsPlayer:removeDownBuff( buffId )
	-- print('AbsPlayer:removeDownBuff()'..buffId)
	if self:isDisposed() then
		return false
	end

	if self._downBuffView then
		self._downBuffView:removeBuff(buffId)
	end
end

--添加上层特效  model_id 特效id 
function AbsPlayer:addFrontEffect( model_id )
	if self:isDisposed() then
		return false
	end

	if self._upBuffView then
		self._upBuffView:addEffect(model_id)
	end
end
-- 添加下层特效 model_id 下层特效id
function AbsPlayer:addBackEffect( model_id )
	-- body
	if self:isDisposed() then
		return false
	end

	if self._downBuffView then
		self._downBuffView:addEffect(model_id)
	end
end
---移动到目标点 

---moveCompleteDir停下来时候站立的方向   changedir   移动的时候 是否根据坐标调整方向 默认为true
function AbsPlayer:moveToPos(pos, func, losttime,moveCompleteDir,changeDir)
	-- body
	if self:isDisposed() then
		return false
	end

	if changeDir== nil then
		changeDir=true
	end

	local selfPos = self:getPosition()
	if changeDir then
		self:updatePathDirection(pos.x, pos.y)
		-- self:play(ActionManager.Action_Walk)
	else
		self:play(ActionManager.Action_Walk)
	end
	self:deleteGrid()

	self._tweenSimple:tweenTo(self.roleDyVo.speed, self._moveVo, pos.x, pos.y, function ( )
		--completed
		-- self:play(ActionManager.Action_Stand,dir)
		self:updateGrid()

		if func ~=nil then
			func()
		end
	end, function(x, y)
		--update
		-- NodeHelper:setPositionInScreen(self._cloth:getRootNode(), ccp(x,y))
			self:updatePostion()
			if changeDir then
				self:updatePathDirection(pos.x, pos.y);
			else
				self:play(ActionManager.Action_Walk)
			end
	end, losttime)
end


--单纯的坐标移动   没有动作的播放
-- fixed speed 7
function AbsPlayer:pureMoveToPos(pos, speed,func, losttime)
	if self:isDisposed() then
		return false
	end

	print("do pure move")
	print(pos)

	local selfPos = self:getPosition()
	-- local dir=self:updatePathDirection(pos.x, pos.y);
	self:deleteGrid()
	self._tweenSimple:tweenTo(speed, self._moveVo, pos.x, pos.y, function ( )
		--completed
		self:updateGrid()
		if func ~= nil  then
			func()
		end

	end, function(x, y)
			self:updatePostion()
	end, losttime)
end

--[[
走进战场
--]]
function AbsPlayer:pureMoveInForBattle( pos1, pos2, speed, func )
	-- body
	if self:isDisposed() then
		return false
	end

	self:play(ActionUtil.Action_Walk)

	self:setPositionWithoutGrid( pos1.x, pos1.y )

	self._tweenSimple:tweenTo(speed, self._moveVo, pos2.x, pos2.y, function ( )
		--completed
		self:updateGrid()
		if func ~=nil  then
			func()
		end
	end, function(x, y)
			self:updatePostion()
	end)

end




--网络驱动 进行移动 
---  netcmd  是 服务端发送过来的数据包
-- function AbsPlayer:moveToPosByNet(netcmd, func)
--  currPos  其他屏幕玩具该对象当前 坐标   destPos 要移动到的目标点    servertime 服务器的当前时间撮 func  移动结束的回调

-- changeDir表示移动的时候是否改变方向 ，一般在 调整站位的时候需要设置为false标示不需要调整方向 当做微调移动的时候
function AbsPlayer:moveToPosByNet(currPos,destPos,servertime, func,changeDir)

	-- assert(false)

	if self:isDisposed() then
		return false
	end
	-- body
	-- local servertime = netcmd.Timestamp
	-- local currPos = {x = netcmd.Msg.currentX, y = netcmd.Msg.currentY}
	servertime = servertime or TimeManager.getCurrentSeverTime()
	
	print("reveTime=="..servertime)

	local heroPos = self:getPosition()

	-- local destPos = {x=netcmd.Msg.x, y=netcmd.Msg.y}

  	local speed = self.roleDyVo.speed
   	local lostTime = 0
   	
   	lostTime = TimeManager.getCurrentSeverTime() - servertime  --网络传输输时间   200 是矫正值

   	lostTime = 0
   	
   	print('网络消耗时间----=='..lostTime) --

   	if lostTime<0 then
     	lostTime=0
   	end
   	-- print('lostTime----=='..lostTime)
  -- 	lostTime =lostTime + 200
    --- 多走出的的距离的时间
   	local moreDif = YFMath.distance(currPos.x,currPos.y, heroPos.x, heroPos.y)
   	-- print("=======moreDif======="..moreDif)

   	local xiangliangJi = (destPos.x-currPos.x)*(heroPos.x-currPos.x)+(destPos.y-currPos.y)*(heroPos.y-currPos.y)
   	-- print("=======lostTIme22======="..lostTime)

   	if xiangliangJi<=0 then
   		lostTime=lostTime + moreDif*1000/(speed*UpdateRate.rate)
   	else 
    	lostTime=lostTime - moreDif*1000/(speed*UpdateRate.rate)
   	end

   	-- print('change:'..(moreDif*1000/(speed*UpdateRate.rate)))

   	if lostTime<0 then
      	lostTime=0
   	end

   	-- print("=======lostTIme======="..lostTime)
   	self:moveToPos( destPos, func, lostTime, nil, changeDir )

end

--更新格子的位置
function AbsPlayer:updateGrid(  )
	-- body
end

function AbsPlayer:deleteGrid()
end

--角色是否已经死亡 
function AbsPlayer:isDead(  )
	if self.roleDyVo.hpPercent<=0 then
	return true
	end
	return false
end

--是否已经释放内存
function AbsPlayer:isDisposed()
	-- body
	return self._isDispose
end

--释放内存
function AbsPlayer:dispose(  )
	self._isDispose = true
	self.roleDyVo.hpPercent=0
	self._tweenSimple:dispose()
	self:deleteGrid()

	GridManager.removePlayerState(self)

	if self._cloth then
		self._cloth:dispose()
	end
end

function AbsPlayer:equalEnd( pos )
	return self._tweenSimple:equalEnd(pos)
end

function AbsPlayer:sendFightMsg( data, delay )
	-- body
	-- self._sendFightMsgHandler = 
	assert(false)
end

function AbsPlayer:cancelFightMsg()
	-- body
end

function AbsPlayer:addAtkEffectView( view )
	-- body

	-- if self.roleDyVo.career ~= TypeRole.Career_ZiLiao then
		self._atkEffectViewArray = self._atkEffectViewArray or {}
		table.insert(self._atkEffectViewArray, view)
	-- end
end

function AbsPlayer:cleanAllAtkEffectViews()
	-- body
	if self._atkEffectViewArray then

		for i,v in ipairs(self._atkEffectViewArray) do
			v:setVisible(false)
		end
		self._atkEffectViewArray = nil
	end 
end

function AbsPlayer:setSkillActionLocked()
	-- body
	self._isSkillLocked = true
end

function AbsPlayer:isSkillActionLocked()
	-- body
	return self._isSkillLocked
end

function AbsPlayer:unLockSkillAction()
	-- body
	self._isSkillLocked = false
end

function AbsPlayer:setBeatbackLocked()
	-- body
	self._beatbackLocked = true
end

function AbsPlayer:unLockBeatback()
	-- body
	self._beatbackLocked = false
end

function AbsPlayer:isBeatbackLocked()
	-- body
	return self._beatbackLocked
end

function AbsPlayer:setFightLocked()
	-- body
	self._fightLocked = true
end

function AbsPlayer:isFightLocked()
	-- body
	return self._fightLocked
end

function AbsPlayer:unLockFight()
	-- body
	self._fightLocked = false
end

function AbsPlayer:isTotalLocked()
	-- body
	return self:isLock() or self:isSkillActionLocked() or self:isBeatbackLocked() or self:isGeDangLocked() or self:isFightLocked()
end

function AbsPlayer:setGeDangLocked()
	-- body
	self._isGeDangLocked = true
end

function AbsPlayer:isGeDangLocked()
	-- body
	return self._isGeDangLocked 
end

function AbsPlayer:unLockGeDang()
	-- body
	self._isGeDangLocked = false
end

function AbsPlayer:resumeQiShi()

end

function AbsPlayer:isAIStarted()
	-- body
	return self._updateHandle ~= nil
end

function AbsPlayer:getLockName()
	-- body
	if self:isGeDangLocked() then
		return 'GeDang'
	elseif self:isBeatbackLocked() then
		return 'Beatback'
	elseif self:isSkillActionLocked() then
		return 'SkillAction'
	elseif self:isFightLocked() then
		return 'FightAction'
	end

	return 'empty'
end

function AbsPlayer:setViewFrozen( enable )
	-- body
	if self:isDisposed() then
		return false
	end
	
	--移除表现特效???
	if self._cloth then
		self._cloth:setFrozen( enable )
	end
end

function AbsPlayer:isBodyVisible()
	-- body
	return true
end

function AbsPlayer:setAtkSpdRate(atkSpdRate)
	-- body
	self._atkSpdRate = atkSpdRate

	print(string.format('AtkSpd Id=%d, %s', self.roleDyVo.playerId, tostring(atkSpdRate)))
	
	if self._cloth then
		self._cloth:setAtkSpdRate(atkSpdRate)
	end
end

function AbsPlayer:getAtkSpdRate()
	-- body
	return self._atkSpdRate
end

function AbsPlayer:runCurrentCallback( callback, time )
	-- body
	if callback then
		local timeOut = TimeOutManager.getTimeOut(time, callback)
		timeOut:start()

		self._callBackManager:setCallback(timeOut)
	end
end

function AbsPlayer:runForceCallback( callback, time )
	-- body
	if callback then
		local timeOut = TimeOutManager.getTimeOut(time, callback)
		timeOut:start()
	end
end

-- 返回毫秒级别的时间
function AbsPlayer:getAnimateTimeByName( name )
	-- body

	-- if name == '大招' then
	-- 	return 2000000
	-- end

	if self._isDancer and name == '大招' then
		return 200
	end

	assert(self.roleDyVo)
	local time = SkinManager.getAnimateTimeByCharactorIdAndName(self.roleDyVo.basicId, name)
	-- print(string.format('获得时间 %s = %s', tostring(name), tostring(time) ))
	return time
end

function AbsPlayer:canMove()
	-- body
	return self.roleDyVo and  self.roleDyVo:canMove()
end

return AbsPlayer
