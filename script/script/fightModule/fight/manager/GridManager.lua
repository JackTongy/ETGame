local YFMath 			= require 'YFMath'

-- init
local Logic_Win_Width 	= 1136
local Logic_Win_Height 	= 640
local Grid_UI_Width 	= 155
local Grid_UI_Height 	= 120
local Threldhold 		= 0.00000000001

local UI_Offset = { 
	x = Logic_Win_Width/2, 
	y = Logic_Win_Height/2 - 10,  
}

local Self_Camp_Left 	= 0.5*Grid_UI_Width + UI_Offset.x
local Self_Camp_Right 	= 3.5*Grid_UI_Width + UI_Offset.x

local Other_Camp_Left 	= -3.5*Grid_UI_Width + UI_Offset.x
local Other_Camp_Right 	= -0.5*Grid_UI_Width + UI_Offset.x

local GridManager = {}
local self = {}

--[[
(-3,1), 	(-2,1), 	(-1,1), 	(0,1), 		(1,1), 		(2,1), 		(3,1),
(-3,0), 	(-2,0), 	(-1,0), 	(0,0), 		(1,0), 		(2,0), 		(3,0),
(-3,-1), 	(-2,-1), 	(-1,-1), 	(0,-1), 	(1,-1), 	(2,-1), 	(3,-1),

	4, 		5, 		6, 		7, 		8, 		9, 		10
	-3,  	-2, 	-1, 	0,  	1, 		2, 		3
	-10, 	-9, 	-8, 	-7, 	-6, 	-5, 	-4
--]]

--战士
local SoldierMap = {
	-- 2, 4, 6,
	-- 1, 5, 8,
	-- 3, 7, 9,
	{ i = 1, j = 0 },
	{ i = 1, j = 1 },
	{ i = 1, j =-1 },
	{ i = 2, j = 1 },
	{ i = 2, j = 0 },
	{ i = 2, j =-1 },
	{ i = 3, j = 1 },
	{ i = 3, j = 0 },
	{ i = 3, j =-1 },
}

--坦克
local TankMap = {
	-- 2, 4, 7,
	-- 1, 5, 8,
	-- 3, 6, 9,
	{ i = 1, j = 0 },
	{ i = 1, j = 1 },
	{ i = 1, j =-1 },
	{ i = 2, j = 1 },
	{ i = 2, j = 0 },
	{ i = 2, j =-1 },
	{ i = 3, j = 1 },
	{ i = 3, j = 0 },
	{ i = 3, j =-1 },
}

--远程
local RangedMap = {
	-- 7, 6, 3,
	-- 8, 5, 1,
	-- 9, 4, 2,
	{ i = 3, j = 0 },
	{ i = 3, j =-1 },
	{ i = 3, j = 1 },
	{ i = 2, j =-1 },
	{ i = 2, j = 0 },
	{ i = 2, j = 1 },
	{ i = 1, j = 1 },
	{ i = 1, j = 0 },
	{ i = 1, j =-1 },
}

--治疗
local CureMap = {
	-- 7, 2, 6,
	-- 8, 1, 5,
	-- 9, 3, 4,
	{ i = 2, j = 0 },
	{ i = 2, j = 1 },
	{ i = 2, j =-1 },
	{ i = 3, j =-1 },
	{ i = 3, j = 0 },
	{ i = 3, j = 1 },
	{ i = 1, j = 1 },
	{ i = 1, j = 0 },
	{ i = 1, j =-1 },
} 

local Career_Array = {
	[1] = SoldierMap,
	[2] = TankMap,
	[3] = RangedMap,
	[4] = CureMap,
}

-- ij转index key的作用
function GridManager.ij2index( i,j )
	-- body
	assert(i)
	assert(j)
	return i + j*1000
end

-- -- index 转ij
-- function GridManager.index2ij( index )
-- 	-- body
-- 	assert(index)
-- 	local i = math.fmod(index+3, 7) - 3
-- 	local j = math.floor( 0.5+(index-i)/7 )
-- 	return i, j
-- end

function GridManager.getLogicWidth()
	return Logic_Win_Width
end

function GridManager.getLogicHeight()
	return Logic_Win_Height
end

function GridManager.getUIGridWidth()
	-- body
	return Grid_UI_Width
end

function GridManager.getUIGridHeight()
	-- body
	return Grid_UI_Height
end

-- 重置
function GridManager.reset()
	-- body
	--格子有三种状态, full, half, empty
	self._indexDataMap = {}
	self._playerIdToIndexMap = {}
end

-- function GridManager.checkGridDataIndex( index )
-- 	-- body
-- 	local data = self._indexDataMap[index]
-- 	if data then
-- 		local player = data.player
-- 		if player:isDisposed() then
-- 			self._indexDataMap[index] = nil
-- 			self._playerIdToIndexMap[player.roleDyVo.playerId] = nil
-- 		end
-- 	end
-- end

-- pos ?
function GridManager.updatePlayerState( player, pos )
	-- body
	assert(player)
	assert(pos)

	local playerPos = player:getPosition()
	pos = pos or playerPos

	local i,j = GridManager.getIJByPos(pos)
	local index = GridManager.ij2index(i,j)
	local uiPos = GridManager.getUICenterByIJ(i,j)

	local oldData = self._indexDataMap[index]
	if oldData then
		-- 优先级比较
		assert(oldData.player)

		local oldPlayerPos = oldData.player:getPosition()

		-- if math.abs(playerPos.x - uiPos.x) > Threldhold or math.abs(playerPos.y - uiPos.y) > Threldhold then 
			if math.abs(oldPlayerPos.x - uiPos.x)<=Threldhold and math.abs(oldPlayerPos.y - uiPos.y)<=Threldhold then
				-- 不需要更新
				return false
			end
		-- end
	end

	-- 清除该player老的记录
	GridManager.removePlayerState( player )

	-- 清除该格子老的数据
	if oldData then
		GridManager.removePlayerState( oldData.player )
	end

	local playerId = player.roleDyVo.playerId

	-- local isCH = (math.abs(pos.x - uiPos.x) <= Threldhold) and (math.abs(pos.y - uiPos.y) <= Threldhold)
	-- local state = (isCH and 'full') or 'half'

	if not player:isDisposed() then
		self._indexDataMap[index] = { player=player, state=state, uiPos = uiPos }
		self._playerIdToIndexMap[playerId] = index
	end

	-- change
	-- require 'EventCenter'.eventInput('GridManagerChange')
	return true
end

function GridManager.removePlayerState( player )
	-- body
	assert(player)

	local playerId = player.roleDyVo.playerId

	-- 清除该player老的记录
	local preIndex = self._playerIdToIndexMap[playerId]
	if preIndex then
		self._indexDataMap[preIndex] = nil
		self._playerIdToIndexMap[playerId] = nil
	end

	-- change
	-- require 'EventCenter'.eventInput('GridManagerChange')
end

function GridManager.getOwnerIdByIJ(i, j)
	local index = GridManager.ij2index(i, j)
	local data = self._indexDataMap[index]
	if data then
		assert(data.player)
		return data.player.roleDyVo.playerId
	end
end

--pos是否是己方, 并且可以被该player去占领
function GridManager.isSelfUICenterValid( player, pos )
	-- body
	assert(player)
	assert(pos)

	return GridManager.isInSelfCampByPos(pos, player:isOtherPlayer()) and GridManager.isUICenterValid( player, pos )
end

function GridManager.isUICenterValid( player, pos )
	-- body
	assert(player)
	assert(pos)

	local i,j = GridManager.getIJByPos(pos)

	local index = GridManager.ij2index(i,j)
	local data = self._indexDataMap[index]

	if data then
		if data.player == player then
			return true
		end
	else
		-- 没人占据, 或者没人意图去占据
		return true
	end
end

function GridManager.isUICenterValid2( player, pos )
	-- body
	assert(player)
	assert(pos)

	local i,j = GridManager.getIJByPos(pos)

	local index = GridManager.ij2index(i,j)
	local data = self._indexDataMap[index]

	if data then
		if data.player == player then
			return true
		else
			if not GridManager.isInUICenter( data.player ) then
				return true
			end
		end
	else
		-- 没人占据, 或者没人意图去占据
		return true
	end
end


function GridManager.isInSelfCampByPos( pos, isOtherPlayer )
	-- body
	assert(pos)

	if isOtherPlayer then
		return (pos.x >= Other_Camp_Left) and (pos.x <= Other_Camp_Right)
	else
		return (pos.x >= Self_Camp_Left) and (pos.x <= Self_Camp_Right)
	end

	-- local i,j = GridManager.getIJByPos(pos)
	-- return (isOtherPlayer and i<0 and i>=-3) or ((not isOtherPlayer) and i>0 and i<=3)
end

function GridManager.isInEnemyCampByPos( pos, isOtherPlayer )
	-- body
	assert(pos)

	if isOtherPlayer then
		return pos.x >= Self_Camp_Left and pos.x <= Self_Camp_Right
	else
		return pos.x <= -Self_Camp_Left and pos.x >= -Self_Camp_Right
	end

	-- local i,j = GridManager.getIJByPos(pos)
	-- return (isOtherPlayer and i>0 and i<=3) or ((not isOtherPlayer) and i<0 and i>=-3)
end

--是否在己方阵营
function GridManager.isInSelfCamp( player )
	-- body
	assert(player)
	local pos = player:getPosition()
	local isOtherPlayer = player:isOtherPlayer()
	return GridManager.isInSelfCampByPos(pos, isOtherPlayer)
end

--是否在敌方阵营
function GridManager.isInEnemyCamp( player )
	-- body
	assert(player)
	local pos = player:getPosition()
	local isOtherPlayer = player:isOtherPlayer()
	return GridManager.isInEnemyCampByPos( pos, isOtherPlayer )
end

-- 该player是否占据了一个UI格子
function GridManager.isInUICenter( player )
	-- body
	assert(player)
	local playerId = player.roleDyVo.playerId
	local index = self._playerIdToIndexMap[playerId]

	if index then
		local data = self._indexDataMap[index]
		if data then
			-- assert(data.state)
			assert(data.player)
			assert(data.player == player)

			local pos = player:getPosition()
			local uiPos = data.uiPos
			-- 二次check
			local isCH = (math.abs(pos.x - uiPos.x) <= Threldhold) and (math.abs(pos.y - uiPos.y) <= Threldhold)

			if isCH then
				-- data.state = 'full' 
				return true
			else
				-- data.state = 'half' 
			end
		end
	end
	-- return true
end

-- 该player占据了己方的一个UI格子
function GridManager.isInSelfUICenter( player )
	-- body
	assert(player)
	return GridManager.isInUICenter( player ) and GridManager.isInSelfCamp( player )
end

function GridManager.isUICenter( pos )
	-- body
	assert(pos)
	local uiCenter = GridManager.getUICenterByPos(pos)
	if math.abs(pos.x - uiCenter.x)<=Threldhold and math.abs(pos.y - uiCenter.y)<=Threldhold then
		return true
	else
		return false
	end
end

function GridManager.getUICenterByIJ( i,j )
	-- body
	assert(i)
	assert(j)
	return { x = i*Grid_UI_Width + UI_Offset.x, y = j*Grid_UI_Height + UI_Offset.y }
end

-- pos or uicenter
function GridManager.getIJByPos( pos )
	-- body
	assert(pos)
	assert(pos.x)
	assert(pos.y)

	local i = math.floor( 0.5+(pos.x-UI_Offset.x)/Grid_UI_Width )
	local j = math.floor( 0.5+(pos.y-UI_Offset.y)/Grid_UI_Height )
	return i, j
end

-- 获得所在格的UI中心
function GridManager.getUICenterByPos( pos )
	-- body
	assert(pos)
	assert(pos.x and pos.y)
	local i = math.floor( 0.5+(pos.x-UI_Offset.x)/Grid_UI_Width )
	local j = math.floor( 0.5+(pos.y-UI_Offset.y)/Grid_UI_Height )
	return GridManager.getUICenterByIJ(i,j)
end

-- 获得英雄所在格子的UI中心
function GridManager.getUICenterByPlayer( player )
	-- body
	assert(player)
	local pos = player:getPosition()
	return GridManager.getUICenterByPos(pos)
end

-- 获得空闲的己方UI格子 (英雄入场), 比如返回
function GridManager.getSelfIdleUICenter( player, needUpdate )
	-- body
	assert(player)
	local career = player:getCareer()
	local array = Career_Array[career]
	assert(array)

	local isOtherPlayer = player:isOtherPlayer()

	-- assert( player.roleDyVo.bornIJ )
	
	if player.roleDyVo.bornIJ then
		local UI_IJ = player.roleDyVo.bornIJ 
		local i = (isOtherPlayer and -UI_IJ.i) or UI_IJ.i
		local j = UI_IJ.j
		local uiPos = GridManager.getUICenterByIJ(i,j)

		if GridManager.isSelfUICenterValid(player, uiPos) then
			if needUpdate then
				GridManager.updatePlayerState(player, uiPos)
			end
			return uiPos
		end
	end

	for _i, UI_IJ in ipairs(array) do
		local i = (isOtherPlayer and -UI_IJ.i) or UI_IJ.i
		local j = UI_IJ.j
		local uiPos = GridManager.getUICenterByIJ(i,j)

		if GridManager.isSelfUICenterValid(player, uiPos) then
			if needUpdate then
				GridManager.updatePlayerState(player, uiPos)
			end
			return uiPos
		end
	end

	-- for _i, UI_IJ in ipairs(array) do
	-- 	local i = (isOtherPlayer and -UI_IJ.i) or UI_IJ.i
	-- 	local j = UI_IJ.j
	-- 	local uiPos = GridManager.getUICenterByIJ(i,j)
	-- 	print('uiPos '..uiPos.x..','..uiPos.y..tostring(isOtherPlayer))
	-- end

	assert(false)
end

-- 自动根据距离排序, 距离近的靠前
function GridManager.getSelfIdleUICenterArraySorted( player )
	-- body
	assert(player)
	local career = player:getCareer()
	local array = Career_Array[career]

	assert(array)

	local uiArray = {}

	local isOtherPlayer = player:isOtherPlayer()

	for _i, UI_IJ in ipairs(array) do
		local i = (isOtherPlayer and -UI_IJ.i) or UI_IJ.i
		local j = UI_IJ.j
		local uiPos = GridManager.getUICenterByIJ(i,j)

		if GridManager.isSelfUICenterValid(player, uiPos) then
			assert( GridManager.isInSelfCampByPos(uiPos, isOtherPlayer) )
			table.insert(uiArray, uiPos)
		end
	end

	local playerPos = player:getPosition()
	table.sort(uiArray, function ( uiPos1, uiPos2 )
		-- body
		local dis1 = YFMath.quick_distance( playerPos.x,playerPos.y, uiPos1.x, uiPos1.y )
		local dis2 = YFMath.quick_distance( playerPos.x,playerPos.y, uiPos2.x, uiPos2.y )
		return dis1 < dis2
	end)

	return uiArray
end

-- 自动根据距离排序, 距离近的靠前
function GridManager.getSelfFrontIdleUICenterArraySorted( player )
	-- body
	assert(player)
	local career = player:getCareer()
	local array = Career_Array[career]

	assert(array)

	local uiArray = {}

	local isOtherPlayer = player:isOtherPlayer()

	for _i, UI_IJ in ipairs(array) do
		if UI_IJ.i == 1 then
			local i = (isOtherPlayer and -UI_IJ.i) or UI_IJ.i
			local j = UI_IJ.j
			local uiPos = GridManager.getUICenterByIJ(i,j)

			if GridManager.isUICenterValid2(player, uiPos) and GridManager.isInSelfCampByPos(uiPos, isOtherPlayer) then
				-- assert( GridManager.isInSelfCampByPos(uiPos, isOtherPlayer) )
				table.insert(uiArray, uiPos)
			end
		end
	end

	local playerPos = player:getPosition()
	table.sort(uiArray, function ( uiPos1, uiPos2 )
		-- body
		local dis1 = YFMath.quick_distance( playerPos.x,playerPos.y, uiPos1.x, uiPos1.y )
		local dis2 = YFMath.quick_distance( playerPos.x,playerPos.y, uiPos2.x, uiPos2.y )
		return dis1 < dis2
	end)

	return uiArray
end


-- 自动根据怪物距离死亡线排序, 距离近的靠前, 同时要超过自己当前的x
function GridManager.getMonsterIdleUICenterArraySorted( player )
	-- body
	assert(player)
	assert(player:isMonster())

	local playerPos = player:getPosition()
	local ui_i, ui_j = GridManager.getIJByPos(playerPos)

	ui_j = math.max(ui_j, -1)
	ui_j = math.min(ui_j,  1)

	ui_i = math.max(ui_i, -3)

	local uiArray = {}

	local playerPos = player:getPosition()

	for i=ui_i, 3 do
		local uiPos = GridManager.getUICenterByIJ(i, ui_j)

		if uiPos.x >= playerPos.x then
			if GridManager.isUICenterValid(player, uiPos) then
				table.insert(uiArray, uiPos)
			end
		end
	end

	local next1Ui_j
	local next2Ui_j

	if ui_j == -1 then 
		next1Ui_j = 0
		next2Ui_j = 1
	elseif ui_j == 1 then
		next1Ui_j = 0
		next2Ui_j = -1
	elseif ui_j == 0 then
		local testPos1 = GridManager.getUICenterByIJ(0,1)
		local testPos2 = GridManager.getUICenterByIJ(0,-1)

		if math.abs(testPos1.y - playerPos.y) <= math.abs(testPos2.y - playerPos.y) then
			next1Ui_j = 1
			next2Ui_j = -1
		else
			next1Ui_j = -1
			next2Ui_j = 1
		end
	end

	assert(next1Ui_j)
	assert(next2Ui_j)

	for i=ui_i, 3 do
		local uiPos = GridManager.getUICenterByIJ(i, next1Ui_j)
		if uiPos.x >= playerPos.x then
			if GridManager.isUICenterValid(player, uiPos) then
				table.insert(uiArray, uiPos)
			end
		end
	end

	for i=ui_i, 3 do
		local uiPos = GridManager.getUICenterByIJ(i, next2Ui_j)
		if uiPos.x >= playerPos.x then
			if GridManager.isUICenterValid(player, uiPos) then
				table.insert(uiArray, uiPos)
			end
		end
	end

	return uiArray
end

-- 自动根据距离死亡线排序, 距离近的靠前, 同时要超过自己当前的x, 同时不换行, 给远程和治疗使用
function GridManager.getMonsterIdleUICenterArrayNoChangeLine( player )
	-- body
	assert(player)
	assert(player:isMonster())

	local uiArray = {}

	local playerPos = player:getPosition()
	local ui_i, ui_j = GridManager.getIJByPos(playerPos)

	ui_j = math.max(ui_j, -1)
	ui_j = math.min(ui_j,  1)

	ui_i = math.max(ui_i, -3)

	local end_i = -1

	-- 上一个意图?
	if player:isCareerZiLiao() then
		end_i = 3
	end

	for i = ui_i, end_i do
		local uiPos = GridManager.getUICenterByIJ(i, ui_j)

		if uiPos.x > playerPos.x then
			if GridManager.isUICenterValid(player, uiPos) then
				table.insert(uiArray, uiPos)
			end
		end
	end
	
	-- table.sort(uiArray, function ( uiPos1, uiPos2 )
	-- 	-- body
	-- 	return uiPos1.x < uiPos2.x
	-- end)

	return uiArray
end

function GridManager.isPosInBattleField( pos )
	-- body
	assert(pos)
	local i,j = GridManager.getIJByPos(pos)
	return i>=-3 and i<=3 and j>=-1 and j<=1
end

function GridManager.getMonsterDeadLine()
	-- body
	local pos = GridManager.getUICenterByIJ( 3.5,0 )
	return pos.x + 10
end

local WinSize = { 
	width 	= require 'Global'.getWidth(),
	height 	= require 'Global'.getHeight(),
}

function GridManager.getScaleX( )
	return WinSize.width/Logic_Win_Width
end

-- 第一次初始站位
function GridManager.getBornGridArray( careerArr )
	-- body
	assert(careerArr)
	assert(#careerArr <=6)

	local usedMap = {}

	local retGridArr = {}

	for index=1, #careerArr do
		local career = careerArr[index]
		assert(career >=1 and career <=4)
		local gridArr = Career_Array[career]
		assert(gridArr)

		for ii,vv in ipairs(gridArr) do
			local k = vv.i * 10 + vv.j
			
			if not usedMap[k] then
				usedMap[k] = true
				
				table.insert(retGridArr, { i=vv.i, j=vv.j } )
				break
			end
		end
	end

	return retGridArr
end

return GridManager