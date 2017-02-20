local BloodView 		= require 'BloodView'
local ActionView 		= require 'ActionView'
local ActionUtil 		= require 'ActionUtil'
local GridManager 		= require "GridManager"
local Config 			= require 'Config'
local CfgHelper 		= require 'CfgHelper'
local TypeRole 			= require 'TypeRole'
local RoleSelfManager 	= require "RoleSelfManager"
local LayerManager 		= require 'LayerManager'
local FightTimer 		= require 'FightTimer'
local SkillUtil 		= require 'SkillUtil'
local FaceType 			= require 'FaceType'
local XmlCache 			= require 'XmlCache'
local SwfActionFactory 	= require 'framework.swf.SwfActionFactory'
local TimeOutManager 	= require "TimeOut"
local EventCenter 		= require 'EventCenter'
local FightEvent 		= require 'FightEvent'

local ActionToFaceMap = {

	['待机'] = FaceType.Face_Type_Normal,
	['虚弱待机'] = FaceType.Face_Type_Normal,

	['移动'] = FaceType.Face_Type_Normal,
	['虚弱移动'] = FaceType.Face_Type_Normal,

	['近战攻击'] = FaceType.Face_Type_Atk,
	['近战暴击'] = FaceType.Face_Type_Atk,
	['远程攻击'] = FaceType.Face_Type_Atk,
	['远程暴击'] = FaceType.Face_Type_Atk,
	['大招'] = FaceType.Face_Type_Atk,

	['治疗'] = FaceType.Face_Type_Normal,
	['格挡'] = FaceType.Face_Type_Hurt,
	['歌舞'] = FaceType.Face_Type_Normal,
	['击退'] = FaceType.Face_Type_Hurt,
	['受击'] = FaceType.Face_Type_Hurt,
	['死亡'] = FaceType.Face_Type_Dead,

}

local ActionNames = {
	-- 'ActionTwinkle',
	'ActionSelectRectShow',
	-- 'ActionLockTarget',
	'ActionSelectRectHide',
	-- 'ActionHurtValue',
	'ActionHurtRed',
	'ActionDeadHide',
	'Blink2Invisible',
	'Blink2Visible'
}


local Hero_Normal_fsh	
local Hero_Hurt_fsh 	
local Enemy_Normal_fsh 	
local Enemy_Hurt_fsh 	

local Device = require 'framework.basic.Device'
if Device.platform == "ios" then
	Hero_Normal_fsh 	= 'elf_hero.fsh'
	Hero_Hurt_fsh 		= 'elf_hero_red.fsh'
	Enemy_Normal_fsh 	= 'elf_enemy.fsh'
	Enemy_Hurt_fsh 		= 'elf_enemy_red.fsh'

	print('shader ios!')
else
	Hero_Normal_fsh 	= 'elf_hero_etc.fsh'
	Hero_Hurt_fsh 		= 'elf_hero_red_etc.fsh'
	Enemy_Normal_fsh 	= 'elf_enemy_etc.fsh'
	Enemy_Hurt_fsh 		= 'elf_enemy_red_etc.fsh'

	print('shader android!')
end


local ActionCache

local MakeActionCache = function ()
	-- body
	if not ActionCache then
		ActionCache = {}
		for i,name in ipairs(ActionNames) do
			local luaset = XmlCache.createDyLuaset( name, 'HeroSet', 'Fight' )
			local action = luaset[1]
			action:retain()

			ActionCache[name] = action
		end
	end
end

local function value2key( args )
	-- body
	args.isMonster = (args.isMonster and true) or false
	args.isBoss = (args.isBoss and true) or false

	local sb = {}
	table.insert(sb, tostring(args.charactorId))
	table.insert(sb, tostring(args.isMonster))
	table.insert(sb, tostring(args.bloodType))
	table.insert(sb, tostring(args.isBoss))

	return table.concat(sb, '-')
end

local RoleViewCache = {}


local RoleView = class(require 'AbsView')

function RoleView:ctor(args)
	
	-- assert(false)

	-- body
	--main luaset shell
	assert(args)
	assert(args.charactorId)
	assert(args.bloodType)

	self._key = value2key(args)

	--args.isBoss, args.isMonster
	-- assert(args.isBoss)

	self:setXmlName('HeroSet')
	self:setXmlGroup('Fight')
	
	--select box

	local luaset = self:createDyLuaset(((args.isBoss and '@boss') or '@hero'))

	MakeActionCache()	

	self._isMonster = args.isMonster
	self._isBoss = args.isBoss

	self._luaset = luaset
	
	-- self._luaset['checkCircle']:setVisible(false)
	-- self._luaset['attackCircle']:setVisible(false)
	-- self._luaset['point']:setVisible(false)

	--actionView
	-- if charactorid then
	self:initActionViewById(args.charactorId, 1)
	-- end
	--bloodView
	-- if bloodType then
	self:initBloodViewByType(args.bloodType)
	-- end
	-- self:setRectSelect(false)

	if args.isMonster then
		self:setAsEnemyStyle()
	else
		self:setNormalSkin()
	end

	-- self._luaset['beattack_animate']:setLoops(1)
	-- self._luaset['beattack_animate']:stop()
	local labelScale = self._luaset['label']:getScaleX()
	self._luaset['label']:setScaleX( (RoleSelfManager.getFlipX()>0 and labelScale) or -labelScale )

	self:setFaceType(FaceType.Face_Type_Normal)

	if self._isMonster then
		local labelNode = self:createDyLuaset('@showName')[1]
		self._luaset['label']:addChild(labelNode)
		self._luaset['showName'] = labelNode

		local charVo = CfgHelper.getCache('charactorConfig', 'id', args.charactorId) 

		local name = charVo and charVo.name or 'MONSTER'

		labelNode:setString(name)
		labelNode:setVisible(false)
	end

	self._playLocked = false

	assert(self._bloodView)
end

function RoleView:getKey()
	-- body
	return self._key
end

function RoleView:retain()
	-- body
	assert( not tolua.isnull(self._luaset[1]) )
	self._luaset[1]:retain()
end

function RoleView:release()
	-- body
	assert( not tolua.isnull(self._luaset[1]) )
	self._luaset[1]:release()
end

function RoleView:initSelectBox()
	-- body
	assert(not self._initSelectBox)
	self._initSelectBox = true

	local selectBox = self._luaset['selectBox']
	
	if not self._isMonster then
		assert(not tolua.isnull(selectBox))
		selectBox:retain()
		selectBox:removeFromParent()
		
		LayerManager.bgLayer:addChild(selectBox)
		
		selectBox:release()

		self:setRectSelect(false)

		self._handler = FightTimer.tick(function ( dt )
			-- body
			if self:isDisposed() then
				local mySelectBox = self._luaset['selectBox']
				if not tolua.isnull(mySelectBox) then
					mySelectBox:setVisible(false)
					mySelectBox:removeFromParent()
				end

				return true
			end

			local node = self._luaset[1]
			local pos = NodeHelper:getPositionInScreen(node)
			
			NodeHelper:setPositionInScreen(self._luaset['selectBox'], pos)
		end)
	end

end

function RoleView:setRoleDyVo( dyVo, career )
	-- body
	self._roleDyVo = dyVo

	self._isDancer = false
	if dyVo then
		local basicId = dyVo.basicId

		local charVo = CfgHelper.getCache('charactorConfig','id', basicId)
		dyVo.skill_id = charVo.skill_id
		
		local skillVo = CfgHelper.getCache('skill', 'id', dyVo.skill_id)
		if skillVo then
			if skillVo.skilltype == SkillUtil.SkillType_Dance then
				self._isDancer = true
			end
		end
	end

	assert(self._bloodView)

	if self._bloodView then
		if not self._isMonster then
			self._bloodView:setCareer(career)
			self._bloodView:setAwakenIndex( dyVo.awaken )
		end
	else
		-- assert(false)
	end
end


function RoleView:addLabel( node )
	-- body
	if not self:isDisposed() then
		if self._luaset and not tolua.isnull(self._luaset['label']) then
			self._luaset['label']:addChild(node)
		end
	end
end

function RoleView:setCharactorId( charactorid ,scaleRate)
	-- body
	if charactorid then
		-- print('charactorid')
		-- print(charactorid)
		scaleRate = scaleRate or 1

		self._scaleRate = scaleRate

		local charVo = CfgHelper.getCache('charactorConfig', 'id', charactorid)
		assert(charVo, 'id = '..tostring(charactorid))
		local checkRange = charVo.checkRange

		local defaultSkillId = charVo.default_skill
		local skillVo = CfgHelper.getCache('skill', 'id', defaultSkillId)
		local attackRange = skillVo.range

		local width = GridManager.getUIGridWidth()
		local height = GridManager.getUIGridHeight()

		-- self:setCheckCircle( checkRange[1] * width * 2, checkRange[2] * height * 2 )
		-- self:setAttackCircle( attackRange[1] * width * 2, attackRange[2] * height * 2 )
		
		self:setCareer(charVo.atk_method_system)
	end

	if self._charactorid ~= charactorid then
		self._charactorid = charactorid

		local actionView = ActionView.createActionViewById( charactorid ) 

		if self._actionView then
			local node = self._actionView[1]
			node:removeFromParent()
			self._actionView = nil
		end

		self._actionView = actionView

		-- ShaderIndex = ShaderIndex + 1
		-- if ShaderIndex > #Shaders then
		-- 	ShaderIndex = 1
		-- end
		-- self._actionView:getRootNode():setShaderVertFrag(Shaders[ShaderIndex].vsh, Shaders[ShaderIndex].fsh);

		self._luaset['sb_hero']:addChild( actionView:getRootNode() )
		self._luaset['sb_hero']:setScale( self._scaleRate )
	end
end

function RoleView:setCheckCircle( width, height )
	-- body
	-- local node = self._luaset['checkCircle']
	-- local mywidth = node:getWidth()
	-- local myheight = node:getHeight()

	-- node:setScaleX(width / mywidth)
	-- node:setScaleY(height / myheight)
end

function RoleView:setAttackCircle( width, height )
	-- body
	-- local node = self._luaset['attackCircle']
	-- local mywidth = node:getWidth()
	-- local myheight = node:getHeight()

	-- node:setScaleX(width / mywidth)
	-- node:setScaleY(height / myheight)
end

--[[
根据bloodtype 初始化 bloodview
bloodtype = 'Boss', 'Hero', 'Monster', 'NotFriend', 'Friend'
--]]
function RoleView:initBloodViewByType( bloodType )
	-- body
	-- print('RoleView:initBloodViewByType '..tostring(bloodType))
	-- print(debug.traceback())
	bloodType = bloodType or 'Hero'

	if not bloodType then
		return 
	end

	if self._bloodType ~= bloodType then
		self._bloodType = bloodType

		local bloodView = BloodView.createBloodViewByType( bloodType )

		if self._bloodView then
			-- local node = self._bloodView[1]
			-- if node then
			-- 	node:removeFromParent()
			-- end
			assert(false)
			self._bloodView:dispose()
			self._bloodView = nil
		end

		self._bloodView = bloodView
		local rootnode = bloodView:getRootNode()
		-- rootnode:setPosition(ccp(0, 70))
		if rootnode then
			rootnode:setScaleX(RoleSelfManager.getFlipX())
			self._luaset['#bloodbar']:addChild( rootnode )
		end
	else
		assert(false)
	end

	assert(self._bloodView)

	print('bloodView called!')
end

-- --战士（红） = 1，骑士（蓝） =2 ，远程（黄） = 3，治疗（绿） = 4
-- --战士
-- TypeRole.Career_ZhanShi=1
-- -- 奇士
-- TypeRole.Career_QiShi=2
-- -- 远程
-- TypeRole.Career_YuanCheng=3
-- -- 治疗
-- TypeRole.Career_ZiLiao=4
local Select_ResMap = {
	[TypeRole.Career_ZhanShi] = 'ZD_RWXKH.png',
	[TypeRole.Career_QiShi] = 'ZD_RWXKL2.png',
	[TypeRole.Career_YuanCheng] = 'ZD_RWXKH2.png',
	[TypeRole.Career_ZiLiao] = 'ZD_RWXKL.png'
}

function RoleView:setCareer( career )
	-- body
	local resid = Select_ResMap[career]
	self._luaset['selectBox']:setResid(resid)
end

--[[
根据charactorid 生成角色动作和皮肤
--]]
function RoleView:initActionViewById( charactorid,scaleRate )
	-- body
	if not charactorid then
		return 
	end

	self:setCharactorId(charactorid,scaleRate)
end


--[[
touchX, touchY
--]]
function RoleView:isInRect( x, y )
	if not self:isDisposed() then

		local luaSet = self._luaset
		local pos = NodeHelper:getPositionInScreen(luaSet['shape'])

		-- pos.y = pos.y - 20

		local width = luaSet['shape']:getWidth() * 1
		local height = luaSet['shape']:getHeight() * 1

		-- print('x:'..pos.x..','..x..',width='..width)
		-- print('y:'..pos.y..','..y..',height='..height)
		-- return math.abs(pos.x-x) < width/2 and math.abs(pos.y-y) < height/2
		if x >= pos.x-width*0.5 and x <= pos.x+width*0.5 and y>= pos.y-height*0.5 and y <= pos.y+height*0.5 then
			return true
		end
	end
	return false
end

--[[
设置移动速度 -> 控制移动动作快慢
--]]
function RoleView:setMoveSpeed( speed )
	-- body
	self._actionView:setMoveSpeed( speed )
end

--[[
	播放动作接口
		action, 动作名称
		direction, 朝向
		loop, 是否循环
		completeCall, 回调  可被其他动作打断
		reset, 动作强制刷新
--]]
function RoleView:play( action, direction, loop, reset )

	if self._playLocked then
		return false
	end

	minForceDelay = minForceDelay or 0

	local face = ActionToFaceMap[action]
	self:setFaceType(face)

	self._currentAction = action

 	if not direction or  direction == -1 then
 		direction = self._activeDirection 
 	end

 	self:setDirection(direction)

	if not reset then
		if action == self._activeAction and self._activeDirection == direction then
			return false
		end
	end

 	self._activeAction = action
 	self._activeDirection = direction

 	assert(self._activeDirection==1 or self._activeDirection==2, 'dir ='..tostring(self._activeDirection))
 	
 	if action == '格挡' then
 		require 'framework.helper.MusicHelper'.playEffect(require 'Res'.Sound.bt_tank_block)
 	end

	if action == ActionUtil.Action_BigSkill then
		-- 特殊处理
		if self._isDancer then
			--歌舞类技能 特殊处理
			print('playDance')
			self._actionView:playDance()

			self._currentAction = '歌舞'

			return
		end		 
	end

	-- print(string.format('p=%d -> %s', self._roleDyVo.playerId, action))

	self._actionView:play(action, loop, nil)
	return 
 end

function RoleView:doNotPlayWalk()
	-- body
	if not self._playLocked and not self._playDeadCalled then
		-- assert(false)
		-- print('doNotPlayWalk:'..tostring(self._activeAction))
		-- print('Id:'..self._roleDyVo.playerId)

		if self._activeAction == '移动' or self._activeAction == '虚弱移动' then
			self:play( '待机', nil, nil, true )
		end

		self._playLocked = true
	else
		-- print('else doNotPlayWalk:'..tostring(self._activeAction))
	end
end

--  播放死亡动画  delay 为 延迟的时间
function RoleView:playDead( delay  )
	print("准备死亡! 延迟="..tostring(delay))

	if not self._playDeadCalled then
		self._playDeadCalled = true

		local timeOut = TimeOutManager.getTimeOut((0+delay)/1000,function ( )
			print('播放死亡动画')
			self:setFaceType(FaceType.Face_Type_Dead)
			self:setDead()

			self._playLocked = false

			self:play( ActionUtil.Action_Dead, self._activeDirection, false, true)

			self._playLocked = true
		end)
		timeOut:start()
	end
end

--[[
设置role血量百分比
--]]
function RoleView:setBloodPercentage( percentage, value )
	-- body
	if not percentage then
		return
	end

	if self._bloodView then
		value = value or 0

		if percentage <= 0 then
			self:redHurt()

		elseif self._lastPercentage and self._lastPercentage > percentage then
			self:redHurt()
		elseif value and value < 0 and self._lastPercentage == percentage then
			self:redHurt()
		end

		self._lastPercentage = percentage

		self._bloodView:setPercentage( percentage, value )
	else
		print('warning : bloodView not ready')
	end
end

local NumberView = require 'NumberView'
function RoleView:hurtValue( value, skillId, isCrit )
	if not value then
		return 
	end
	print('HpD = '..value)

	local function finalShow(  )
		-- body
		if self:isDisposed() then
			return
		end

		NumberView.showNumber(self._luaset['label'], value, skillId, isCrit)
	end

	finalShow()
end

function RoleView:setBloodVisible( visible )
	-- body
	if self._bloodView then
		local rootnode = self._bloodView:getRootNode()
		-- rootnode:setPosition(ccp(0, 70))
		if rootnode then
			rootnode:setVisible(visible)
		end
	end
end

function RoleView:setActionVisible( visible )
	-- body
	if self._actionView then
		local rootnode = self._actionView:getRootNode()
		-- rootnode:setPosition(ccp(0, 70))
		if rootnode then
			rootnode:setVisible(visible)
		end
	end
end

function RoleView:setVisible( visible )
	-- body
	self:setActionVisible(visible)
	self:setBloodVisible(visible)
end

function RoleView:dispose()
	-- body
	self:runWithDelay(function ( ... )
		-- body
		local root = self:getRootNode()
		if root then
			if not tolua.isnull(root) then
				self._actionView:getRootNode():resetListener()
				root:removeFromParentAndCleanup(true)
			end
		end

	end, 2)

	if self._handler then
		if self._luaset then
			local mySelectBox = self._luaset['selectBox']
			if not tolua.isnull(mySelectBox) then
				mySelectBox:setVisible(false)
				mySelectBox:removeFromParent()
			end
		end

		FightTimer.cancel(self._handler)
		self._handler = nil
	end
end

function RoleView:getActionNode()
	-- body
	return self._actionView:getRootNode()
end

function RoleView:setDisposed()
	-- body
	self:dispose()
end

--[[
mode
0.不可释放
1.可释放
2.连锁
--]]
function RoleView:setBloodMode( mode )
	-- body
	self._bloodView:setMode(mode)
end

function RoleView:getBloodView()
	-- body
	return self._bloodView
end

--[[
被攻击效果, 红色闪烁 + 振动
--]]
function RoleView:redHurt()
	if self:isDisposed() then
		return
	end

	self:delay(function ()
		-- body
		local action = self:getActionCloneByName('ActionHurtRed')

		action:setListener(function ()
			-- body
			self:setNormalSkin()
			self:setFaceType(FaceType.Face_Type_Normal)
		end)

		local node = self._actionView:getRootNode()
		if node then
			node:runElfAction(action)
		end

		self:setRedSkin()
		self:setFaceType(FaceType.Face_Type_Hurt)
	end)
end

function RoleView:setDead()
	-- body
	if not self._roleDead and not self:isDisposed() then
		local actionRoot = self._actionView:getRootNode()

		if not tolua.isnull(actionRoot) then
			self._actionView:getRootNode():stopAllActions()
			self._actionView:getRootNode():setColorf(1,1,1,1)

			self:setNormalSkin()

			local action = self:getActionCloneByName('ActionDeadHide')

			self._luaset['#bloodbar']:runElfAction(action:clone())
			self._luaset['shader']:runElfAction(action:clone())
			self._luaset['selectBox']:runElfAction(action:clone())

			self._luaset['downContainer']:runElfAction(action:clone())
			self._luaset['upContainer']:runElfAction(action:clone())

		end

		self._roleDead = true
	end
end

function RoleView:isDead( )
	-- body
	return self._roleDead
end

function RoleView:setNormalSkin()
	-- body
	if not self:isDead() then
		if self._isEnemyStyle then
			self:setShader( Enemy_Normal_fsh )
		else
			self:setShader( Hero_Normal_fsh )
		end
	end
end

function RoleView:setRedSkin()
	-- body
	if not self:isDead() then
		if self._isEnemyStyle then
			self:setShader( Enemy_Hurt_fsh )
		else
			self:setShader( Hero_Hurt_fsh )
		end
	end
end

--[[
--加到downContainer or upContainer
--]]
function RoleView:addChild( child, isUpLayer )
	-- body
	if not self:isDisposed() then
		if isUpLayer then
			local scaleX = self._luaset['upContainer']:getScaleX()
			assert(scaleX>0.9 and scaleX<1.1)
			self._luaset['upContainer']:addChild( child )
		else 
			local scaleX = self._luaset['downContainer']:getScaleX()
			assert(scaleX>0.9 and scaleX<1.1)
			self._luaset['downContainer']:addChild( child )
		end
	end
end

function RoleView:addEffectNode( node, isUpLayer )
	-- body
	assert(node )
	if not self:isDisposed() then
		if isUpLayer then
			self._luaset['upContainer']:addChild( node )
		else 
			self._luaset['downContainer']:addChild( node )
		end
	end
end

function RoleView:setRectSelect( rectselect )
	-- body
	if self._rectSelect ~= rectselect then
		self._rectSelect = rectselect

		local node = self._luaset['selectBox']
		local action = self:getActionCloneByName( (rectselect and 'ActionSelectRectShow') or 'ActionSelectRectHide')
		node:runElfAction(action)
	end
end

function RoleView:setAsEnemyStyle()
	-- body
	local node = self._luaset['selectBox']
	node:stopAllActions()
	node:setVisible(false)

	-- self._isEnemyStyle = true
	-- shaders
	self:setNormalSkin()
end

function RoleView:setShader( shader )
	-- body
	local node = self._actionView:getRootNode()
	if node then
		node:setShaderVertFrag(NULL, 'shaders/'..shader)
	end
end

--[[
设置显示的角色名称， 用于debug
--]]
function RoleView:setName( name )
	-- body
	if require 'Default'.Debug.state and not self:isDisposed() then
		self._luaset['name']:setString( name )
		self._luaset['name']:setScaleX(RoleSelfManager.getFlipX())
	end
end


--[[
--]]
function RoleView:setFaceType( faceType )
	-- body
	if not self:isDisposed() and faceType then
		--ignore
		-- if faceType == FaceType.Face_Type_Hurt and self._faceType == FaceType.Face_Type_Atk then
		-- 	return
		-- end

		self._faceType = faceType
		self._actionView:setFaceType(faceType)
	end
end

function RoleView:setBuffEffectView( upView, downView )
	-- body
	self._buffUpView 	= upView
	self._buffDownView	= downView
end

--[[
	设置方向
	dir 方向, true->左到右, false->右到左
--]]
function RoleView:setDirection( dir )
	if not self:isDisposed() then

		local rate = 1
		if self._isBoss then
			rate = 0.8125
		else
			rate = 0.625
		end

		local node = self._luaset['sb_hero']
		if dir==ActionUtil.Direction_Right then
			node:setScaleX(-rate*self._scaleRate/GridManager.getScaleX())
			node:setScaleY(rate*self._scaleRate)
		else 
			node:setScaleX(rate*self._scaleRate/GridManager.getScaleX())
			node:setScaleY(rate*self._scaleRate)
		end

		if self._buffUpView then
			self._buffUpView:setDirection(dir)
			self._buffDownView:setDirection(dir)
		end
	end
end

--[[
设置role位置
--]]
function RoleView:setPosition( x, y )
	-- body
	local node = self:getRootNode()
	-- assert(node)
	if node then
		node:setPosition( ccp(x,y) )
	end
	--近大远小?
	-- local 
end

--[[
得到role位置
--]]
function RoleView:getPosition(  )
	-- body
	-- assert(false)
	-- return { x=x, y=y } 
	local node = self:getRootNode()
	-- assert(node)
	if node then
		local x, y = node:getPosition()
		return { x=x, y=y }
	end
end

function RoleView:setDebug( flag )
	-- body
	self._debugFlag = flag
end


function RoleView:setFrozen( enable )
	-- body
	self._actionView:setFrozen(enable)
end

function RoleView:setAtkSpdRate( rate )
	-- body
	self._actionView:setAtkSpdRate(rate)
end

function RoleView:blink2visible()
	-- body
	if not self:isDead() and not self:isDisposed() then
		local rootnode = self._luaset['sb_hero']
		if rootnode then
			local action = self:getActionCloneByName('Blink2Visible')
			rootnode:runElfAction(action)
		end
	end
end

function RoleView:blink2invisible(  )
	-- body
	if not self:isDead() and not self:isDisposed() then
		local rootnode = self._luaset['sb_hero']
		if rootnode then
			local action = self:getActionCloneByName('Blink2Invisible')
			rootnode:runElfAction(action)
		end
	end
end

function RoleView:showMonsterName()
	-- body
	if not self._hasMonsterNameShowed then
		self._hasMonsterNameShowed = true

		if self._isMonster then

			self:runWithDelay(function ( ... )
				-- body
				local labelNode = self._luaset['showName']
				if tolua.isnull(labelNode) then
					return
				end
				-- bmfontNode:setScale(1.2)

				local action = SwfActionFactory.createAction( require 'QAction_showName',nil,nil,20 );
				action:setListener(function ()
					-- body
					labelNode:removeFromParent()
				end)

				labelNode:runAction(action)

			end, 0.1)			
		end
	end
end

function RoleView:getActionCloneByName( name )
	-- body
	assert(ActionCache)

	return ActionCache[name]:clone()
end

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--[[
charactorid, bloodType
--]]
local function createRoleViewByArgs( args )
	-- body
	return RoleView.new( args )
end

local ViewCache = require 'ViewCache'.new()
ViewCache:setCreator(createRoleViewByArgs)

local function getViewCacheByArgs( args )
	-- body
	local key = value2key(args)
	local ret = ViewCache:getCache(key)

	-- assert(ret, 'no '..key)
	debug.catch(not ret, 'RoleView getViewCacheByArgs no '..key)

	if not ret then
		ret = createRoleViewByArgs(args)
	end

	return ret
end

local function getPureViewCacheByArgs( args )
	-- body
	local key = value2key(args)
	local ret = ViewCache:getCache(key)
	
	assert(ret, 'no '..key)

	ViewCache:recycle(ret)

	return ret
end

local function clean()
	-- body
	return ViewCache:clean()
end

local function createViewCacheByArgs( args )
	-- body
	local key = value2key(args)
	print('createViewCacheByArgs:'..key)
	
	return ViewCache:createCache(args)
end

return { createViewCacheByArgs = createViewCacheByArgs,
 clean = clean, getViewCacheByArgs = getViewCacheByArgs, getPureViewCacheByArgs = getPureViewCacheByArgs }
