local GuideCtrl = require 'GuideCtrl'
local PointManager = require 'PointManager'

local ElementGuide =
{
	[12] = 'GCfg02',--金砖引导
	[34] = 'GCfg04',--神兽
}

local GuideHelper = {}

function GuideHelper:startGuide( ... )
	GuideCtrl:startGuide(...)
end

function GuideHelper:startGuideIfIdle( ... )
	if GuideCtrl:isGuideDone() then
		GuideCtrl:startGuide(...)
	end
end

function GuideHelper:check( action,arg )
	GuideCtrl:check(action,arg)
end

function GuideHelper:inGuide( ... )
	return GuideCtrl:inGuide(...)
end

function GuideHelper:getIStep( ... )
	return GuideCtrl:getGuideCheckPoint()
end

function GuideHelper:getNetCheck()
	return GuideCtrl:getGuideNetCheck()
end

function GuideHelper:registerPoint( name,node )
	PointManager:registerPoint(name,node)
end

function GuideHelper:unregisterPoint( name )
	PointManager:unregisterPoint(name)
end

function GuideHelper:startUnlockGuide( ... )
	GuideCtrl:startUnlockGuide( ... )
end

function GuideHelper:startUnlockGuideWithName( ... )
	GuideCtrl:startUnlockGuideWithName(...)
end

function GuideHelper:elementGuide( elemType )
	if elemType then
		local guidename = ElementGuide[elemType]
		if guidename then
			GuideHelper:startGuide(guidename,1,1,nil,1)
		end
	end
end

function GuideHelper:getLastSavePoint( ... )
	return GuideCtrl:getLastSavePoint()
end

function GuideHelper:isGuideDone( ... )
	return GuideCtrl:isGuideDone()
end

function GuideHelper:recordGuideStepDes( ... )
	return GuideCtrl:recordGuideStepDes(...)
end

function GuideHelper:reset( ... )
	return GuideCtrl:reset( ... )
end

function GuideHelper:registerActionFuc( ... )
	return GuideCtrl:registerActionFuc( ... )
end

function GuideHelper:guideDone( ... )
	return GuideCtrl:guideDone( ... )
end

function GuideHelper:RecordGuide( ... )
	return GuideCtrl:RecordGuide( ... )
end

return GuideHelper