local Config 		= require 'Config'
local Global 		= require 'Global'
local EventCenter 	= require 'EventCenter'
local FightEvent 	= require 'FightEvent'
local TimeOut 		= require 'TimeOut'

local BossKillLayer = class(require 'BasicView')

function BossKillLayer:ctor( luaset, document )
	-- body
	self._luaset 	= luaset
	self._document 	= document

	self._delegate1 = DelegateDrawNode:create()
	self._delegate2 = DelegateDrawNode:create()

	self._luaset['bossKillLayer']:addChild(self._delegate2)
	self._luaset['bossKillLayer']:addChild(self._delegate1)

	self._luaset['bossKillLayer_delegate1'] = self._delegate1
	self._luaset['bossKillLayer_delegate2'] = self._delegate2

	-- self._luaset['bossKillLayer_delegate1']:setDebug(true)
	self._luaset['bossKillLayer_delegate1']:setPosition(ccp(-25,-25))
	self._luaset['bossKillLayer_delegate2']:setPosition(ccp(-25,-25))

	-- self._luaset['bossKillLayer_delegate1']:setDelegateNode( self._luaset['bossKillLayer_#label0'] )

	EventCenter.addEventFunc(FightEvent.Pve_KillBoss, function ( data )
		-- body
		local boss 			= data.boss
		local attacker 		= data.attacker
		local delay         = data.delay

		local scaleX = require 'LayerManager'.roleLayer:getScaleX()
		local scaleY = require 'LayerManager'.roleLayer:getScaleY()
		
		self._luaset['bossKillLayer']:setScaleX(scaleX)
		self._luaset['bossKillLayer']:setScaleY(scaleY)

		self:startBossKill(delay, false, boss, attacker) 
	end, 'Fight')


	-- 
end

function BossKillLayer:startBossKill( delay, hasCatched, boss, attacker )
	assert(boss)
	-- if boss then
	-- 	local bossCloth = boss:getCloth()
	-- 	local bossRootNode = bossCloth:getRootNode()
	-- 	self._delegate2:setDelegateNode(bossRootNode)
	-- end

	-- if attacker then
	-- 	local attackerCloth = attacker:getCloth()
	-- 	local attackerRootNode = attackerCloth:getRootNode()
	-- 	self._delegate1:setDelegateNode(attackerRootNode)
	-- end

	local timeout0 = TimeOut.getTimeOut(delay, function ()
		-- body
		local action = self._luaset['ActionWhiteOut']:clone()
		self._luaset['bossKillLayer_white']:runElfAction(action)

		if boss then
			local bossCloth = boss:getCloth()
			local bossRootNode = bossCloth:getRootNode()
			self._delegate2:setDelegateNode(bossRootNode)
		end

		if attacker then
			local attackerCloth = attacker:getCloth()
			local attackerRootNode = attackerCloth:getRootNode()
			self._delegate1:setDelegateNode(attackerRootNode)
		end

		NodeHelper:setTouchable(self._luaset['uiLayer'], false)
	end)
	timeout0:start()

	local timeout1 = TimeOut.getTimeOut(delay+1, function ()
		-- body
		self._delegate1:setDelegateNode(NULL)
		self._delegate2:setDelegateNode(NULL)

		NodeHelper:setTouchable(self._luaset['uiLayer'], true)
	end)
	timeout1:start()
	
	-- do
	-- 	--变慢
	-- 	local timeout1 = TimeOut.getTimeOut(delay+4/20, function ()
	-- 		-- body
	-- 		CCDirector:sharedDirector():getScheduler():setTimeScale(0.1)
	-- 	end)
	-- 	timeout1:start()
	-- 	--恢复
	-- 	local timeout2 = TimeOut.getTimeOut(delay+1, function ()
	-- 		-- body
	-- 		CCDirector:sharedDirector():getScheduler():setTimeScale(1)
	-- 	end)
	-- 	timeout2:start()
	-- end	

	self:slow(delay)
end

function BossKillLayer:slow(delay)
	-- body
	-- 
	local isAcce = require 'FightSettings'.getAccelerate()
	local rate = (isAcce and 1.5) or 1

	local timescale1 = 1 * rate
	local timescale2 = 0.15 * rate
	local timescale3 = 1 * rate

	local step1 = 4
	for i=1,step1 do
		local timeout = TimeOut.getTimeOut(delay+i/20, function ()
			-- body
			CCDirector:sharedDirector():getScheduler():setTimeScale(timescale1 + (timescale2-timescale1)*i/step1 )
		end)
		timeout:start()
	end

	local step1 = 4
	for i=1,step1 do
		local timeout = TimeOut.getTimeOut(delay+(8+i)/20, function ()
			-- body
			CCDirector:sharedDirector():getScheduler():setTimeScale(timescale2 + (timescale3-timescale2)*i/step1 )
		end)
		timeout:start()
	end

end


return BossKillLayer