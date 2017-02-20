local buffBasicManager = require 'BuffBasicManager'
local skillUtil = require 'SkillUtil'
-- local Utils = require 'framework.helper.Utils'
local TimeOutManager = require 'TimeOut'

local FightEffectView = require 'FightEffectView'

local ActionUtil = require "ActionUtil"

-- local 

local BuffEffectView = class()

function BuffEffectView:ctor(  )
	self._dict={}
	self._readyForAddDict = {}
	
	self._needReverseArray = {}
end

function BuffEffectView:setDirection( dir )
	-- body
	local scaleX
	if dir == ActionUtil.Direction_Left then
		scaleX = 1
	else
		scaleX = -1
	end

	local removeArray = {}

	for i, node in ipairs(self._needReverseArray) do
		if tolua.isnull(node) then
			table.insert(removeArray, 1, i)
		else
			node:setScaleX( scaleX )
		end
	end

	for i, index in ipairs(removeArray) do
		table.remove(self._needReverseArray, index)
	end
end

function BuffEffectView:setBuffContainer(buffContainer )
	self._buffContainer=buffContainer
end

function BuffEffectView:buffId2EffectArray( buffId ,downlayer)
	-- body
	if buffId and buffId > 0 then
		local buffBasicVo = buffBasicManager.getBuffBasicVo(buffId)
		if buffBasicVo and buffBasicVo.model_id>0 then
			local array = require 'FightEffectBasicManager'.getFightEffectBasicVoArr(buffBasicVo.model_id)

			local rets = {}
			for i,v in ipairs(array) do
				if (downlayer and v.layer == 2) or (not downlayer and v.layer ~= 2) then
					table.insert(rets,v)
				end
			end

			return rets
		end
	end
end

--旋转????
-- dir  主角当前站立的位置
function BuffEffectView:addBuff( buffId, negetive, dir,downlayer)
	-- [1] = {	id = 0,	effectId = 0,	roleTimeArr = 0,	offset = {0,0},	model_id = 0,	modelTimeArr = 0,	layer = 1,},
	negetive = negetive or 1

	local effectArray = self:buffId2EffectArray(buffId,downlayer)
	if not effectArray then
		return
	end

	print('准备增加buff'..buffId..'的表现')

	for i,effect in ipairs(effectArray) do
		-- v
		-- local effect = v.model_id

		local model_id = tonumber(effect.model_id) * negetive
		-- print('-------effect-------')
		-- print(effect)

		if model_id ~= 0 then

			self._readyForAddDict[model_id] = true

			self:runWithDelay( function (  )
				if not self._readyForAddDict[model_id] then
					return
				end

				self._readyForAddDict[model_id] = nil

				-- print('add model='..model_id)

				-- body
				local view = self._dict[model_id]
				if view then
					-- print('model_id='..model_id..' disposed')
					-- view:setDisposed()
					-- self._dict[model_id] = nil
					print('already model_id = '..model_id)

					return
				end

				local bv = FightEffectView.create(model_id)

				if bv then
					-- print('BuffEffectView: add node ')
					bv:setAutoRemoveFromParent(false)
					local node = bv:getRootNode()
					node:setVisible(true)
					-- node:setPosition(ccp(effect.offset[1], effect.offset[2]))

					local buffBasicVo = buffBasicManager.getBuffBasicVo( math.abs(buffId) )

					if buffBasicVo.has_direction == skillUtil.BuffDirection_Has then    -- buff特效具备方向性
						if dir == ActionUtil.Direction_Left then
							node:setScaleX(1)
						else
							node:setScaleX(-1)
						end

						table.insert(self._needReverseArray, node)
					end

					self._buffContainer:addChild(node)

					-- if model_id > 0 then
					-- 	self._dict[model_id] = bv
					-- end

					self._dict[model_id] = bv
				end

			end, effect.delay)

		end
	end
end

--删除buff
function BuffEffectView:removeBuff( buffId ,downlayer)
	local effectArray = self:buffId2EffectArray( buffId ,downlayer)
	
	if not effectArray then
		return effectArray
	end

	print('准备删除buff'..buffId..'的表现')

	for i, effect in ipairs (effectArray) do
		local model_id = tonumber(effect.model_id)
		--加入之前, 预先删除
		self._readyForAddDict[model_id] = nil
		-- print('prev remove model='..model_id)

		self:runWithDelay(function ( ... )
			-- body
			-- print('finnal remove model='..model_id)

			local view = self._dict[model_id]

			if view then
				print('remove model_id = '..model_id)

				view:setDisposed()
				self._dict[model_id] = nil
				-- print('BuffEffectView remove node')
			else
				-- print('BuffEffectView not remove node for '..model_id)
			end

		end, effect.delay)
		
	end
end

--外部调用, 自己自动移除
--delay 单位为毫秒
function BuffEffectView:addEffect( model_id ,delay)
	delay=delay or 0
	-- assert(false)
	self:runWithDelay(function ( )
		-- print(debug.traceback())

		local buffSet = FightEffectView.create(model_id)
		if buffSet then
			-- print('BuffEffectView:addEffect '..model_id)
			buffSet:setAutoRemoveFromParent(true)
			local node = buffSet:getRootNode()
			self._buffContainer:addChild(node)
		end
	end, delay/1000)
end

function BuffEffectView:runWithDelay( func, time )
	-- body
	local timeOut = TimeOutManager.getTimeOut(time,func)
	timeOut:start()
end

function BuffEffectView:reset()
	-- body
	-- self._dict = {}
	-- self._readyForAddDict = {}
end

return BuffEffectView
