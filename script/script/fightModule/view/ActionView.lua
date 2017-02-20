local Utils = require 'framework.helper.Utils'
local FaceType = require 'FaceType'
local ActionUtil = require 'ActionUtil'

local ActionView = class( require 'AbsView' )

local AllActions = {
	'待机',
	'虚弱待机',
	'移动',
	'虚弱移动',
	'近战攻击',
	'近战暴击',
	'远程攻击',
	'远程暴击',
	'治疗',
	'大招',
	'击退',
	'格挡',
	'死亡',
	'胜利',
	'失败',
	'大招前',
	'歌舞',
	-- ''
}

local Old_Action_Map_1 = {
	['近战攻击'] = true,
	['近战暴击'] = true,
	['远程攻击'] = true,
	['远程暴击'] = true,
	['治疗'] = true,
}

local New_Action_Map_1 = {
	['移动'] = true,
	['虚弱移动'] = true,
}

--治疗到待机
local Old_Action_Map_2 = {
	['治疗'] = true,
}

local New_Action_Map_2 = {
	['待机'] = true,
	['虚弱待机'] = true,
}

--待机到移动
local Old_Action_Map_3 = {
	['待机'] = true,
	['虚弱待机'] = true,
}

local New_Action_Map_3 = {
	['移动'] = true,
	['虚弱移动'] = true,
}

--移动到待机
local Old_Action_Map_4 = {
	['移动'] = true,
	['虚弱移动'] = true,
}

local New_Action_Map_4 = {
	['待机'] = true,
	['虚弱待机'] = true,
}

	-- local normal = 
	local faceTypes = { 
		FaceType.Face_Type_Normal,
		FaceType.Face_Type_Hurt,
		FaceType.Face_Type_Dead,
		FaceType.Face_Type_Atk,
	}

function ActionView:ctor( luaset, charactorid )
	-- body

	-- assert(false)
	assert(luaset)
	self._luaset = luaset
	self._charactorid = charactorid

	self._originActionSpeedMap = {}

	local flash = self._luaset[1]

	local skinId = tonumber( require 'SkinManager'.charactorToSkin(charactorid) )

	-- 默认
	if self._luaset['hero_root_Tou'] then

		self._luaset['hero_root_Tou']:setResid( string.format('face_%d_hurt.png', skinId) )

		for i,v in ipairs(faceTypes) do
			local fullName = 'hero_root_Tou_'..v

			if not self._luaset[fullName] then
				self._luaset[fullName] = ElfNode:create()

				local image
				if v == FaceType.Face_Type_Normal then
					image = string.format('face_%d_%s.png', skinId, v)
				elseif v == FaceType.Face_Type_Hurt then
					image = string.format('face_%d_%s.png', skinId, v)
				elseif v == FaceType.Face_Type_Dead then
					image = string.format('face_%d_%s.png', skinId, FaceType.Face_Type_Hurt)
				elseif v == FaceType.Face_Type_Atk then
					image = string.format('face_%d_%s.png', skinId, v)
				end

				self._luaset[fullName]:setResid(image)
				self._luaset['hero_root_Tou']:addChild(self._luaset[fullName])
				
				-- self._luaset[fullName]:setBlendMode(770, 771)

				-- if fullName == FaceType.Face_Type_Hurt then
				-- 	self._luaset[fullName]:getTexture():setAliasTexParameters()
				-- else
				-- end
				-- self._luaset[fullName]:getTexture():setAntiAliasTexParameters()
			end
		end
	end
	
	--AllActions
	for i,action in ipairs(AllActions) do
		local modifierController = flash:getModifierControllerByName(action)
		if modifierController then
			self._originActionSpeedMap[action] = modifierController:getSpeedRate()
		end
	end
	-- flash:setBatchDraw(true)

	self:setFaceType(FaceType.Face_Type_Normal)

	local Device = require 'framework.basic.Device'
	if Device.platform == "android" then
		flash:setShaderVertFrag(NULL, 'shaders/elf_hero_etc.fsh')
	end
end

function ActionView:calcTransitionTimeMills( oldAction, newAction )
	-- body
	if true then
		return 0
	end

	if (not oldAction) or (not newAction) then
		return 0
	end

	--从攻击动作到移动的过度
	if Old_Action_Map_1[oldAction] and New_Action_Map_1[newAction] then
		return 0

	--从治疗到待机的过度
	elseif Old_Action_Map_2[oldAction] and New_Action_Map_2[newAction] then
		return 800

	--从待机到移动
	elseif Old_Action_Map_3[oldAction] and New_Action_Map_3[newAction] then
		return 100

	--从移动到待机
	elseif Old_Action_Map_4[oldAction] and New_Action_Map_4[newAction] then
		return 200
	end

	return 0
end



--[[
获得根节点
--]]
function ActionView:getRootNode()
	-- body
	local node = self._luaset[1]
	return (not tolua.isnull(node)) and node
end

--[[
--]]
function ActionView:setMoveSpeed( speed )
	-- body
	if self:isDisposed() then
		return
	end

	local rate = 1.3 * 0.7 * speed / 2.72
	local flash = self._luaset[1]

	local modifierController = flash:getModifierControllerByName('移动')

	assert(modifierController, 'no 移动='..tostring(self._charactorid))

	modifierController:setSpeedRate(rate)

	modifierController = flash:getModifierControllerByName('虚弱移动')
	modifierController:setSpeedRate(rate)
end

function ActionView:setAtkSpdRate( rate )
	-- body
	if not self:isDisposed() then
		
		self._atkSpdRate = rate

		local atk_action = {
			'近战攻击','近战暴击','远程攻击','远程暴击','治疗','大招'
		}

		local flash = self._luaset[1]
		for i, action in ipairs(atk_action) do

			local modifierController = flash:getModifierControllerByName(action)
			--_originActionSpeedMap
			if modifierController then
				-- print('加速 '..action)
				local base = self._originActionSpeedMap[action]
				modifierController:setSpeedRate( base * rate )
			end
		end
	end
end


function ActionView:playDance()

	local step1 = {}
	step1.name = '大招'
	step1.indexBeg = 0
	step1.indexEnd = 15
	step1.loops = 1
	step1.transitionMills = 0
	step1.callback = function ()
		-- body
		-- assert(false)
	end

	local step2 = {}
	step2.name = '大招'
	step2.indexBeg = 15
	step2.indexEnd = 35
	step2.loops = 10000

	local array = {}
	table.insert(array, step1)
	table.insert(array, step2)

	self:splay(array)
end


function ActionView:splay(array)
	-- body
	assert( type(array) == 'table' )
	local len = #array
	assert( len >= 1 )

	for i,v in ipairs(array) do
		self:checkDataIndexAndLoops(v)
	end

	local flash = self._luaset[1]

	-- indexBeg, indexEnd, loops, callback
	local listenerArray = {}

	--set last callback
	listenerArray[len] = array[len].callback

	for i=len-1, 1, -1 do 
		listenerArray[i] = function ( ... )
			-- body
			local myCallback = array[i].callback
			if myCallback then
				myCallback()
			end

			local nextData = array[i+1]
			local nextListener = listenerArray[i+1]
			
			flash:setTransitionMills(nextData.transitionMills or 0)

			-- print(string.format('splay %d, index=%d->%d, loops=%d, fuc=%s', i+1, nextData.indexBeg, nextData.indexEnd, nextData.loops, tostring(nextListener)))

			if nextListener then
				flash:splay(nextData.name, nextData.indexBeg, nextData.indexEnd, nextData.loops, nextListener )
			else
				flash:splay(nextData.name, nextData.indexBeg, nextData.indexEnd, nextData.loops)
			end
		end
	end

	local firstData = array[1]

	local firstListener = listenerArray[1]

	flash:setTransitionMills(firstData.transitionMills)

	if firstListener then
		flash:splay(firstData.name, firstData.indexBeg, firstData.indexEnd, firstData.loops, firstListener )
	else
		flash:splay(firstData.name, firstData.indexBeg, firstData.indexEnd, firstData.loops)
	end
	
end

function ActionView:checkDataIndexAndLoops( data )
	-- body
	if not self:isDisposed() then

		data.indexBeg = data.indexBeg or 0
		data.loops = data.loops or 1
		data.transitionMills = data.transitionMills or 0

		if not data.indexEnd then
			local flash = self._luaset[1]

			local md = flash:getModifierControllerByName(data.name)
			assert(md, 'Could Not Find '..tostring(data.name)..' ModifierController!')
			data.indexEnd = md:getMaxF()
		end
	end
end

--[[
可以打断动作:
移动, 虚弱移动, 待机, 虚弱待机

--]]

--[[
	播放动作接口
		name, 动作名称
		loop, 是否循环
		callback, 回调

		if name == '歌舞' then

		end
--]]
function ActionView:play( name, loop, callback )
	-- body
	-- assert(not callback)

	self._activeAction = name

	if self:isDisposed()  then
		if callback then
			callback()
		end
		return 
	end


	-- assert(callback == nil)

	local flash = self._luaset[1]

	-- assert( not (loop and callback) )

	local modifierController = flash:getModifierControllerByName(name)
	if not modifierController then
		print('warning:该角色'..self._charactorid..' 没有 动画:'..tostring(name))

		if callback then
			callback()
		end

		return 
	end

	--时间不能配置在动作编辑上的情况, 比如 击退动画
	if not loop  then
		
		local period = modifierController:getPeriod()
		modifierController:setLife( period )
		modifierController:setLoops(1)
		modifierController:setLoopMode( STAY )

		-- assert(modifierController, 'Flash Not Found Action '..tostring(name)..' !')
		-- modifierController:setLife( time * 1000 )
	else
		modifierController:setLoops(100000)
		modifierController:setLoopMode( LOOP )
	end

	local newSpeed = self._originActionSpeedMap[name]
	local newModifierController = flash:getModifierControllerByName(name)
	if newModifierController then
		newModifierController:setSpeedRate( newSpeed )
	end

	local transitionTimeMills = self:calcTransitionTimeMills(self._oldActionName, name)
	self._oldActionName = name
	
	if transitionTimeMills >= 0 then
		flash:setTransitionMills(transitionTimeMills)
		-- assert(name ~= '大招')
	else
		flash:setTransitionMills(0)
	end
	
	if callback then
		flash:playWithCallback(name, callback)
	else
		flash:play(name)
	end

	self:refreshsetFrozen()

end

-- function ActionView:getAnimateTimeByName( name )
-- 	-- body
-- 	if self:isDisposed() then
-- 		return 0
-- 	end

-- 	local flash = self._luaset[1]
-- 	local modifierController = flash:getModifierControllerByName(name)

-- 	local ret = 0
-- 	if modifierController then
-- 		ret = modifierController:getPeriod() / modifierController:getSpeedRate()
-- 	end

-- 	return ret
-- end


function ActionView:setFaceType( faceType )
	-- body
	-- FaceType.Face_Type_Normal = 'Face_Type_Normal'
	-- FaceType.Face_Type_Dead = 'Face_Type_Dead'
	-- FaceType.Face_Type_Hurt = 'Face_Type_Hurt'

	local normal = self._luaset['hero_root_Tou_normal']
	local hurt = self._luaset['hero_root_Tou_hurt']
	local dead = self._luaset['hero_root_Tou_dead']
	local atk = self._luaset['hero_root_Tou_atk']

	if not normal then
		return 
	end

	if not self._deadFaceTriggered then

		if faceType == FaceType.Face_Type_Normal then
			normal:setVisible(true)
			hurt:setVisible(false)
			dead:setVisible(false)
			atk:setVisible(false)

		elseif faceType == FaceType.Face_Type_Dead then
			normal:setVisible(false)
			hurt:setVisible(false)
			dead:setVisible(true)
			atk:setVisible(false)

			self._deadFaceTriggered = true
			
		elseif faceType == FaceType.Face_Type_Hurt then
			normal:setVisible(false)
			hurt:setVisible(true)
			dead:setVisible(false)
			atk:setVisible(false)
		elseif faceType == FaceType.Face_Type_Atk then
			normal:setVisible(false)
			hurt:setVisible(false)
			dead:setVisible(false)
			atk:setVisible(true)
		end
	end
end

function ActionView:setFrozen( enable )
	-- body
	if not self:isDisposed() then
		if self._isFrozen ~= enable then
			self._isFrozen = enable
			self:refreshsetFrozen()
		end
	end
end

function ActionView:refreshsetFrozen()
	-- body
	if self:isStanding() then
		local flash = self._luaset[1]

		local modifierController = flash:getModifierControllerByName( self._activeAction )

		if modifierController then
			if self._isFrozen then
				modifierController:setSpeedRate(0)
			else
				modifierController:setSpeedRate( self._originActionSpeedMap[self._activeAction] )
			end
		end

	end
end

function ActionView:isStanding()
	-- body
	return self._activeAction == ActionUtil.Action_Stand or self._activeAction == ActionUtil.Action_XuRuoStand
end


local ActionViewLuaset = require 'ActionViewLuaset'
local function createActionViewById( charactorId )
	-- body
	local prev = SystemHelper:currentTimeMillis()
	local luaset = ActionViewLuaset.createActionLuasetById(charactorId)
	local ret = ActionView.new( luaset, charactorId )

	local now = SystemHelper:currentTimeMillis()

	print(string.format('生成ActionView(%d) time = %d', charactorId, (now-prev)))

	return ret
end

return { createActionViewById = createActionViewById }
