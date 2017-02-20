	--特效表现读取 根据 buff 的type字段 来进行读取

local buffData = require 'buff'
local skillUtil = require 'SkillUtil'
local buffBasicManager = {}
buffBasicManager.data={}
buffBasicManager.hasInit=false

-- function buffBasicManager.getBuffBasicVo( buffId)
-- 	buffBasicManager.initAllData()
-- 	return buffBasicManager.data[buffId]
-- end

function buffBasicManager.getBuffBasicVo( buffid)
	buffBasicManager.initAll()
	return buffBasicManager.data[buffid]
end


--是否有冰冻效果
function buffBasicManager.isFreeze( buffid)

	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	-- if buffid == 42 then
	-- 	print('why always me!')
	-- 	print(buffBasicVo)
	-- end

	for k,v in ipairs(buffBasicVo.ghtypearray) do
		if v==skillUtil.BuffType_Freeze then
			return true
		end
	end
	return false
end
--是否有昏迷效果
function buffBasicManager.isComa( buffid)
	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	for k,v in ipairs(buffBasicVo.ghtypearray) do
		if v==skillUtil.BuffType_Coma then
			return true
		end
	end
	return false
end

--是否有致盲效果
function buffBasicManager.isBlind( buffid )
	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	for k,v in ipairs(buffBasicVo.ghtypearray) do
		if v==skillUtil.BuffType_Blind then
			return true
		end
	end
	return false
end

--是否有中毒效果
function buffBasicManager.isPoison( buffid )
	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	for k,v in ipairs(buffBasicVo.ghtypearray) do
		if v==skillUtil.BuffType_Poison then
			return true
		end
	end
	return false
end

--是否有缓速效果
function buffBasicManager.isSlow( buffid )
	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	for k,v in ipairs(buffBasicVo.ghtypearray) do
		if v==skillUtil.BuffType_Slow then
			return true
		end
	end
	return false
end

--是否具有弓箭贯穿效果
function buffBasicManager.isGuangChuang(buffid )
	-- print('isGuangChuang buffId='..buffid)
	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	for k,v in ipairs(buffBasicVo.ghtypearray) do
		-- print("v=="..v)
		-- print(v)
		-- print(skillUtil.BuffType_GuangChuang)
		if v==skillUtil.BuffType_GuangChuang then
			return true
		end
	end
	return false
end

function buffBasicManager.isHealLarger( buffid )
	-- body
	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	for k,v in ipairs(buffBasicVo.ghtypearray) do
		-- print("v=="..v)
		-- print(v)
		-- print(skillUtil.BuffType_GuangChuang)
		if v== skillUtil.BuffType_HealLarger or v == skillUtil.BUffType_HealLarger1 then
			return true
		end
	end
	return false
end

--是否是歌舞类
function buffBasicManager.isGeWu(buffid)
	local buffBasicVo=buffBasicManager.getBuffBasicVo(buffid)	
	for k,v in ipairs(buffBasicVo.ghtypearray) do
		if v==skillUtil.BuffType_GeWu then
			return true
		end
	end
	return false
end



--检测数据是否已经重新存储
function buffBasicManager.initAll( ) 
	if not buffBasicManager.hasInit then
		for k,buffBasicVo in pairs(buffData) do
			buffBasicManager.data[buffBasicVo.buffid]=buffBasicVo
			-- if  not buffBasicManager.data[buffBasicVo.type] then
			-- 	buffBasicManager.data[buffBasicVo.type] ={}
			-- end
			-- table.insert(buffBasicManager.data[buffBasicVo.type],buffBasicVo);
		end
		buffBasicManager.hasInit=true
	end
end

-- --检测数据是否已经重新存储
-- function buffBasicManager.initAllData( ) 
-- 	if not buffBasicManager.hasInit then
-- 		for k,buffBasicVo in pairs(buffData) do
-- 			buffBasicManager.data[buffBasicVo.buff_id]=buffBasicVo
-- 		end
-- 		buffBasicManager.hasInit=true
-- 	end
-- end

--获取buff的特效状态  是持续性的还是 状态性的 用来判断特效的播放方式
function buffBasicManager.getBuffState(buffBasicVo )
	
	--状态行buff,一直持续
	return skillUtil.BuffState_State
end

return buffBasicManager
