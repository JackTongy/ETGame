local MATHelper = {}
local Enable = false
local stageNPC = 
{
	[10101]=1,
	[10301]=6,
	[10302]=7,
	[10403]=11,
	[10802]=16,
	[10601]=21,
	[11404]=26,
	[11102]=31,
	[11204]=36,
	[20015]=41,
	[20025]=46,
	[20036]=51,
	[21016]=56,
	[20046]=61,
	[20056]=66,
	[20067]=71,
	[20077]=76,
}

function MATHelper:StageBattle( stageid,star )
	print('StageBattle:'..tostring(stageid)..tostring(star))
	local npc = stageNPC[tonumber(stageid)]
	if npc then
		
	end
end

local types = 
{
	[1]='Gold',		--金币
	[2]='Gear Card',--装备卡
	[3]='Summon Card',  --召唤卡
	[4]='Pokesouls', --精灵之魂
	[5]='dawn stone',-- 觉醒之石
	[6]='Honor pnts',--  荣誉
	[7]='Gems' --精灵石
}

function MATHelper:Produced( type,amount,method )
	print('Produced:'..tostring(types[type])..tostring(amount)..tostring(method))
end

function MATHelper:Consumed( type,amount,method )
	print('Consumed:'..tostring(types[type])..tostring(amount)..tostring(method))
end

function MATHelper:Change( type,newamount,oldamount )
	if Enable and newamount and oldamount and tonumber(newamount) ~= tonumber(oldamount) and self:GetMethod() then
		local v = tonumber(newamount) - tonumber(oldamount)
		if v > 0 then
			self:Produced(type,v,self:GetMethod())
		else
			self:Consumed(type,v,self:GetMethod())
		end
	end
end

function MATHelper:Enable( enable )
	Enable = enable
end

function MATHelper:GetMethod( ... )
	local netHead = require 'ArgQueue'.getHead() or require 'ArgQueue'.getLast()
	if netHead and netHead[1] then
		return netHead[1].C
	end
	return nil
end

function MATHelper:EnterGameServer( server )
	print('EnterGameServer:')
	print(server)
	
end

return MATHelper