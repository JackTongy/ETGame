local RoleSelfManager 	= require 'RoleSelfManager'
local ActionUtil 		= require 'ActionUtil'

local Attack_Action = {
	['近战攻击'] = true,
	['近战暴击'] = true,
	['远程攻击'] = true,
	['远程暴击'] = true,
	['大招']		= true,
	['治疗']		= true,
}

local InvisibleMonster = class(require 'MonsterPlayer')

function InvisibleMonster:ctor()
	-- body
	-- self._clothInvisible = true
end

function InvisibleMonster:setClothInvisible( invisible )
	-- body
	self._clothInvisible = invisible
	local cloth = self:getCloth()
	if cloth then
		if invisible then
			cloth:blink2invisible()
		else
			cloth:blink2visible()
		end
	end
end

function InvisibleMonster:checkAction( action )
	-- body
	self:checkPlayAction(action)

	if action == ActionUtil.Action_Stand then
		action = ActionUtil.Action_NoramlStand
	end

	if action == ActionUtil.Action_Walk then
		action = ActionUtil.Action_NormalWalk
	end

	return action
end

function InvisibleMonster:checkPlayAction( action )
	-- body
	print('checkPlayAction')
	print(action)
	if Attack_Action[action] and self._clothInvisible then
		self:setClothInvisible( false )
	end
end

function InvisibleMonster:onEntryForSpecail()
	-- body
	self._clothInvisible = true

	self:runWithDelay(function ()
		-- body
		self:setClothInvisible(true)
	end, 2)
end

function InvisibleMonster:isBodyVisible()
	-- body
	return not self._clothInvisible
end

require 'MonsterFactory'.check(require 'AIType'.Invisible_Type, InvisibleMonster)

return InvisibleMonster