--具备移动功能的特效
local TweenSimple 	= require 'TweenSimple'
require 'MoveVo'
local FlyView 		= require 'FlyView'
local LayerManager 	= require 'LayerManager'
local GridManager 	= require 'GridManager'

TweenSkill = class()

function TweenSkill:ctor()
	self._tweenSimple=TweenSimple.new()
	self._moveVo=MoveVo.new()
	self._view=nil
	self._yOffset=0
	self._originY=0
end

function TweenSkill:setSkin( skinId ,pos)
	assert(pos)
	local viewset = FlyView.createFlyViewById(skinId)
	local view = viewset:getRootNode()
	LayerManager.skyLayer:addChild(view)

	self._moveVo.x=pos.x
	self._moveVo.y=pos.y +self._yOffset

	self._originY=self._moveVo.y
	self._view=view
	
end

function TweenSkill:tweenTo( targetPlayer,speed )
	if self:check() then return end

	local endPos = targetPlayer:getPosition()
	self._endTarget=targetPlayer

	self._average_step = speed * 0.015

	if endPos.x > self._moveVo.x then      -- end 在右边
		self._view:setScaleX(-1 * self._view:getScaleX() )

		self._average_step = self._average_step * -1
 	end

	self._tweenSimple:tweenTo(speed,self._moveVo,endPos.x,self._originY,function(  )
		if self._view then
			-- LayerManager.skyLayer:removeChild(self._view)
			self:dispose()
		end

	end,function (  )
		self:updateIt()
	end)
end

function TweenSkill:updateEnd()
	if self:check() then return end

	local endPos = self._endTarget:getPosition()
	
	local myNextX = self._average_step + self._moveVo.x

	if self._view:getScaleX() > 0 then
		if endPos.x >= self._moveVo.x or endPos.x >= myNextX then
			--过界提前结束
			self._tweenSimple:finishIt()
			return
		end
	else
		if endPos.x <= self._moveVo.x or endPos.x <= myNextX then
			--过界提前结束
			self._tweenSimple:finishIt()
			return
		end
	end 

end

function TweenSkill:updateIt(  )
	if self:check() then return end

	self._view:setPosition(ccp(self._moveVo.x-GridManager.getLogicWidth()/2, self._moveVo.y-GridManager.getLogicHeight()/2))
	self:updateEnd()
end

function TweenSkill:check(  )
	-- body
	if self._endTarget and  self._endTarget:isDisposed() then
		self:dispose()
		return true
	end
end

function TweenSkill:dispose()
	if not self._dead then
		self._dead = true

		self._tweenSimple:dispose()

		if not tolua.isnull( self._view ) then
			self._view:removeFromParent()
		end
		
		self._view=nil
	end
end