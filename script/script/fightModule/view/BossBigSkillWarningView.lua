
local Config 		= require 'Config'
local Global 		= require 'Global'
local EventCenter 	= require 'EventCenter'
local FightEvent 	= require 'FightEvent'
local TimeOut 		= require 'TimeOut'
local GridManager 	= require 'GridManager'
local SkillUtil     = require 'SkillUtil'
local ActionUtil    = require 'ActionUtil'

local BossBigSkillWarningView = class(require 'BasicView')

function BossBigSkillWarningView:ctor(luaset, document)
	-- body
	self._luaset = luaset
	self._shapes = nil

	self:initEvents()
end

function BossBigSkillWarningView:refreshDir( dir )
	-- body
	local node = self._luaset['layer_bossBigSkillWarning_line_pic']

	if dir == ActionUtil.Direction_Left then
		node:setScaleX( -math.abs(node:getScaleX()) ) 
	else
		node:setScaleX( math.abs(node:getScaleX()) ) 
	end
end

function BossBigSkillWarningView:initEvents()
	-- body
	EventCenter.addEventFunc(FightEvent.Pve_BigSkill_Warning_Init, function ( data )
		-- body
		assert(data)
		assert(data.shapes)
		assert(data.range)
-- 		data.dir

		self._shapes = data.shapes

		if data.shapes == SkillUtil.Type_Line then
			local node = self._luaset['layer_bossBigSkillWarning_line_pic']
			-- node:setVisible(false)

			local width = node:getWidth()
			local height = node:getHeight()

			local scaleX = data.range[1] * GridManager.getUIGridWidth() / width
			local scaleY = data.range[2] * GridManager.getUIGridHeight() / height
			node:setScaleX(scaleX)
			node:setScaleY(scaleY)

		elseif data.shapes == SkillUtil.Type_Line2 then
			local node = self._luaset['layer_bossBigSkillWarning_line_pic']
			-- node:setVisible(false)

			local width = node:getWidth()
			local height = node:getHeight()

			local scaleX = data.range[1] * GridManager.getUIGridWidth() / width
			local scaleY = data.range[2] * GridManager.getUIGridHeight() / height

			node:setScaleX(scaleX)
			node:setScaleY(scaleY)

		elseif data.shapes == SkillUtil.Type_Circle then
			local node = self._luaset['layer_bossBigSkillWarning_circle_pic']
			-- node:setVisible(false)

			local width = node:getWidth()
			local height = node:getHeight()
			
			local scaleX = 2 * data.range[1] * GridManager.getUIGridWidth() / width
			local scaleY = 2 * data.range[2] * GridManager.getUIGridHeight() / height

			node:setScaleX(scaleX)
			node:setScaleY(scaleY)
		else
			assert(false)
		end

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_BigSkill_Warning_Show, function ( data )
		-- body
		-- print(FightEvent.Pve_BigSkill_Warning_Show)

		require 'framework.helper.MusicHelper'.playEffect(require 'Res'.Sound.bt_warning)

		if self._shapes == SkillUtil.Type_Line then
			local node = self._luaset['layer_bossBigSkillWarning_line']
			node:setVisible(true)
			node:runElfAction( self._luaset['ActionBigSkill_LineIn']:clone() )

			self:refreshDir( ActionUtil.Direction_Right )

		elseif self._shapes == SkillUtil.Type_Line2 then
			local node = self._luaset['layer_bossBigSkillWarning_line']
			node:setVisible(true)
			node:runElfAction( self._luaset['ActionBigSkill_LineIn']:clone() )

		elseif self._shapes == SkillUtil.Type_Circle then
			local node = self._luaset['layer_bossBigSkillWarning_circle']
			node:setVisible(true)
			node:runElfAction( self._luaset['ActionBigSkill_CircleIn']:clone() )
		else
			assert(false)
		end

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_BigSkill_Warning_Hide, function ( data )
		-- body
		-- print(FightEvent.Pve_BigSkill_Warning_Hide)

		local node1 = self._luaset['layer_bossBigSkillWarning_line']
		local node2 = self._luaset['layer_bossBigSkillWarning_circle']

		node1:setVisible(false)
		node2:setVisible(false)

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_BigSkill_Warning_Pos, function ( data )
		-- body
		local pos = data.pos
		assert(pos)

		if self._shapes == SkillUtil.Type_Line then
			local node = self._luaset['layer_bossBigSkillWarning_line']
			node:setPosition(ccp(pos.x, pos.y))
		elseif self._shapes == SkillUtil.Type_Circle then
			local node = self._luaset['layer_bossBigSkillWarning_circle']
			node:setPosition(ccp(pos.x, pos.y))
		elseif self._shapes == SkillUtil.Type_Line2 then
			local node = self._luaset['layer_bossBigSkillWarning_line']
			node:setPosition(ccp(pos.x, pos.y))
		else
			assert(false)
		end

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_BigSkill_Warning_Dir, function ( data )
		-- body
		assert(data.dir)

		if self._shapes == SkillUtil.Type_Line2 then
			self:refreshDir(data.dir)
		end
	end, 'Fight')

end

return BossBigSkillWarningView