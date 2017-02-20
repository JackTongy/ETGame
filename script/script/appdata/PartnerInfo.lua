--[[
	伙伴 (Partner)
	字段				类型				说明
	Rid	 				Int					玩家id
	PositionId			Byte				位置id
	PetId				Long				精灵唯一id
	TeamId			Int 					队形 id (1,2,3)
]]

-- 小伙伴模块
local partnerFunc = {}
local partnerData = {}

function partnerFunc.cleanData()
	partnerData = {}
end

-- 返回小伙伴列表
function partnerFunc.getPartnerListWithTeamIndex( teamIndex )
	local temp = {}
	for i,v in ipairs(partnerData) do
		if v.TeamId == teamIndex then
			table.insert(temp, v)
		end
	end
	return temp
end

-- 设置小伙伴列表
function partnerFunc.setPartnerList( list )
	table.sort(list, function ( v1, v2 )
		if v1.TeamId == v2.TeamId then
			return v1.PositionId < v2.PositionId
		else
			return v1.TeamId < v2.TeamId
		end
	end)
	partnerData = list
end

-- 设置某一个队列的小伙伴列表
function partnerFunc.setPartnerListWithTeamIndex( list )
	for i,v in ipairs(list) do
		for i2,v2 in ipairs(partnerData) do
			if v2.TeamId == v.TeamId and v2.PositionId == v.PositionId then
				partnerData[i2] = v
				break
			end
		end
	end
end

function partnerFunc.isInPartner( petid )

	for k,v in pairs(partnerData) do
		if v.PetId == petid then
			return true
		end
	end	
	return false
	
end

function partnerFunc.updatePartner( partners )
	for i,v in ipairs(partners) do
		for i2,v2 in ipairs(partnerData) do
			if v2.TeamId == v.TeamId and v2.PositionId == v.PositionId then
				partnerData[i2] = v
				break
			end
		end
	end
end

function partnerFunc.getPartnerWithOldPartner( oldPartner )
	for i,v in ipairs(partnerData) do
		if v.TeamId == oldPartner.TeamId and v.PositionId == oldPartner.PositionId then
			return v
		end
	end
end

return partnerFunc