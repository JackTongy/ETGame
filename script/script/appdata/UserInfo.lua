--[[
	玩家信息（Role）服务端数据
	字段				类型				说明
	Id 					Int 					玩家 id
	Name				String 				名称
	Lv 					Int 					等级
	Vip 				Int 					VIP
	Exp 				Int 					经验
	Ap 					Int 					体力
	Gold 				Int 					金币
	Coin 				Int 					钻石（精灵石）
	TitleID 			Int 					称号
	Power 				Int 					战斗力
	ApCaps 			Int 					体力上限
	FriendCaps 		Int 					好友上限
	PetLvCaps 			Int 					精灵等级上限
	EqLvCaps 			Int 					装备等级上限
	ActiveCode 		String 				邀请码
	IsActive 			Bool 				是否已输入过邀请码
]]

local timeManager = require "TimeListManager"

-- 用户信息模块
local userInfoFunc = {}
local userInfoData = {}
local apResumeTime = 480
local bossBattleBossId = 0
local bossDownPlay = false
local coinWellFlag = false
local coinWell = nil
local timeZone = nil

function userInfoFunc.cleanData()
	userInfoData = {}
	apResumeTime = 480
	bossBattleBossId = 0
	bossDownPlay = false
	coinWellFlag = false
	coinWell = nil
	timeZone = nil
end

-- 设置用户信息
function userInfoFunc.setData( role )
	local needUpdateGoldCoin = role.Gold ~= userInfoFunc.getGold() or role.Coin ~= userInfoFunc.getCoin()
	local isUpdateAp = role.Ap ~= userInfoFunc.getAp()

	userInfoData = table.clone(role)
	userInfoFunc.setId(role.Id)
	userInfoFunc.setName(role.Name)
	userInfoFunc.setLevel(role.Lv)
	userInfoFunc.setVipLevel(role.Vip)
	userInfoFunc.setExp(role.Exp)
	userInfoFunc.setAp(role.Ap)
	userInfoFunc.setGold(role.Gold)
	userInfoFunc.setCoin(role.Coin)
	userInfoFunc.setTitleID(role.TitleId)
	userInfoFunc.setBattleValue(role.Power)
	userInfoFunc.setApResume(role.ApResume)
	userInfoFunc.setActiveCode(role.ActiveCode)
	userInfoFunc.setSoul(role.Soul)
	userInfoFunc.setTrainType(role.TrainType)
	userInfoFunc.setDailyTaskScore(role.DailyTaskScore)
	userInfoFunc.setTodayScore(role.TodayScore)
	userInfoFunc.setResetTimes(role.ResetTimes)
	userInfoFunc.setResetCost(role.ResetCost)
	userInfoFunc.setNextTownId(role.NextTownId)
	userInfoFunc.setStep(role.Step)
	userInfoFunc.setiStep(role.iStep)

	if isUpdateAp then
		require 'EventCenter'.eventInput("UpdateAp")
	end
	if needUpdateGoldCoin then
		require 'EventCenter'.eventInput("UpdateGoldCoin")
	end
	print('role.iStep:')
	print(role.iStep)
end

function userInfoFunc.getData( ... )
	return userInfoData
end

-- 用户信息是否有效
function userInfoFunc.isValid( ... )
	return userInfoFunc.getId() ~= nil
end

-- 返回ID
function userInfoFunc.getId(  )
	return userInfoData.id
end

-- 设置ID
function userInfoFunc.setId( id )
	userInfoData.id = id
end

-- 返回名字 
function userInfoFunc.getName(  )
	return userInfoData.name
end

-- 设置名字
function userInfoFunc.setName( name )
	userInfoData.name = name

	local utils = require 'framework.helper.Utils'
	utils.delay(function (  )
		require 'EventCenter'.eventInput("UpdateUserName")
	end, 0.1)
end

-- 返回等级
function userInfoFunc.getLevel(  )
	return userInfoData.level
end

-- 设置等级
function userInfoFunc.setLevel( level )
	userInfoData.level = level
end

-- 返回经验值
function userInfoFunc.getExp(  )
	return userInfoData.exp
end

-- 设置经验值
function userInfoFunc.setExp( exp )
	userInfoData.exp = exp
end

function userInfoFunc.getExpCap()
	-- body
	local CfgHelper = require 'CfgHelper'
	local vo = CfgHelper.getCache('role_lv', 'lv', userInfoFunc.getLevel() )
	return vo.exp
end

-- 返回VIP等级
function userInfoFunc.getVipLevel(  )
	return userInfoData.vipLevel
end

-- 设置VIP等级
function userInfoFunc.setVipLevel( vipLevel )
	userInfoData.vipLevel = vipLevel
end

function userInfoFunc.isMaxVip( ... )
	local vipList = require "vip"
	return userInfoData.vipLevel >= #vipList - 1
end

-- 返回体力
function userInfoFunc.getAp(  )
	return userInfoData.ap
end

-- 设置体力
function userInfoFunc.setAp( ap )
	userInfoData.ap = ap
end

-- 返回金币
function userInfoFunc.getGold(  )
	return userInfoData.gold
end

-- 设置金币
function userInfoFunc.setGold( gold )
	require "MATHelper":Change(1, gold, userInfoData and userInfoData.gold)
	userInfoData.gold = gold
end

-- 返回精灵石
function userInfoFunc.getCoin(  )
	return userInfoData.coin
end

-- 设置精灵石
function userInfoFunc.setCoin( coin )
	require "MATHelper":Change(7, coin, userInfoData and userInfoData.coin)
	userInfoData.coin = coin
end

-- 返回精灵果实
function userInfoFunc.getFruitCount(  )
	return userInfoData.fruitCount
end

-- 设置精灵果实
function userInfoFunc.setFruitCount( count )
	userInfoData.fruitCount = count
end

-- 返回玩家称号ID
function userInfoFunc.getTitleID(  )
	return userInfoData.titleID
end

function userInfoFunc.isTitleUpgradeEnable( ... )
	local TitleID = userInfoFunc.getTitleID()
	local ntitle  = require 'DBManager'.getTrainTitle(TitleID+1)
	local totalstars = userInfoFunc.getTotalStars()
	return (ntitle and totalstars >= ntitle.score)
end

-- 设置玩家称号ID
function userInfoFunc.setTitleID( titleID )
	userInfoData.titleID = titleID
end

-- 返回战力
function userInfoFunc.getBattleValue(  )
	return userInfoData.battleValue
end

-- 设置战力
function userInfoFunc.setBattleValue( value )
	userInfoData.battleValue = value
end

-- 返回精灵之魂
function userInfoFunc.getSoul(  )
	return userInfoData.soul
end

-- 设置精灵之魂
function userInfoFunc.setSoul( soul )
	require "MATHelper":Change(4, soul, userInfoData and userInfoData.soul)
	userInfoData.soul = soul
end

-- 返回邀请码
function userInfoFunc.getActiveCode(  )
	return userInfoData.activeCode
end

-- 设置邀请码
function userInfoFunc.setActiveCode( activeCode )
	userInfoData.activeCode = activeCode
end

-- 返回是否已输入过邀请码
function userInfoFunc.getIsActive(  )
	return userInfoData.isActive
end

-- 设置邀请码标志
function userInfoFunc.setIsActive( isActive )
	userInfoData.isActive = isActive
end

-- 返回全部恢复体力所需时间
function userInfoFunc.getApTotalResume(  )
	return (require "DBManager".getInfoRoleLevelCap(userInfoFunc.getLevel()).apcap - userInfoFunc.getAp() - 1) * apResumeTime + userInfoData.ApResume
end

-- 返回下次体力恢复的时间
function userInfoFunc.getApResume( ... )
	return userInfoData.ApResume
end

-- 设置下次体力恢复的时间
function userInfoFunc.setApResume( ApResume )
	print("ApResume = " .. ApResume)
	userInfoData.ApResume = ApResume
	if ApResume > 0 then
		timeManager.addToTimeList(timeManager.packageTimeStruct("apResume", userInfoData.ApResume, function ( delta )
			userInfoData.ApResume = delta
			if delta <= 0 then
				local apCap = require "DBManager".getInfoRoleLevelCap(userInfoFunc.getLevel()).apcap
				userInfoFunc.setAp(math.min(userInfoFunc.getAp() + 1, apCap))
				print("增加一点体力")
				if userInfoFunc.getAp() ~= apCap then
					userInfoData.ApResume = apResumeTime
					delta = userInfoData.ApResume

					require 'framework.helper.Utils'.delay(function (  )
						userInfoFunc.setApResume( apResumeTime - 1 )
					end, 1)
				end
				print(userInfoData)
				require 'EventCenter'.eventInput("UpdateAp")
			end
		end))
	else
		timeManager.removeFromTimeList("apResume")
	end
end

-- 设置训练模式
function userInfoFunc.setTrainType( trainType )
	userInfoData.trainType = trainType
end

-- 返回训练模式
function userInfoFunc.getTrainType(  )
	return userInfoData.trainType or 1
end

function userInfoFunc.setDailyTaskScore(DailyTaskScore)
	userInfoData.DailyTaskScore = DailyTaskScore
end

function userInfoFunc.getDailyTaskScore(  )
	return userInfoData.DailyTaskScore
end

function userInfoFunc.setTodayScore(TodayScore)
	userInfoData.TodayScore = TodayScore
end

function userInfoFunc.getToadyScore( ... )
	return userInfoData.TodayScore
end

function userInfoFunc.setResetTimes( ResetTimes )
	userInfoData.ResetTimes = ResetTimes
end

-- function userInfoFunc.getResetTimes(  )
-- 	return userInfoData.ResetTimes
-- end

function userInfoFunc.setResetCost( ResetCost )
	userInfoData.ResetCost = ResetCost
end

-- function userInfoFunc.getResetCost(  )
-- 	return userInfoData.ResetCost
-- end

function userInfoFunc.setNextTownId( NextTownId )
	userInfoData.NextTownId = NextTownId
end

function userInfoFunc.getNextTownId( ... )
	local townId
	require "TownInfo".PlayBranchEvent(function ( ... )
		townId = userInfoData.NextTownId
	end, function ( ... )
		townId = userInfoData.NextTownIdSenior
	end, function ( ... )
		townId = userInfoData.NextTownIdHero
	end)
	return townId
end

function userInfoFunc.setStep( Step )
	userInfoData.Step = Step
end

function userInfoFunc.getStep( ... )
	return userInfoData.Step
end

function userInfoFunc.setiStep( iStep )
	userInfoData.iStep = iStep
end

function userInfoFunc.getiStep( ... )
	return (userInfoData.iStep and tonumber(userInfoData.iStep)) or 0
end

function userInfoFunc.getStep( ... )
	return (userInfoData.Step and tonumber(userInfoData.Step)) or 0
end

function userInfoFunc.getRoleCreateDateTime( ... )
	return userInfoData.CreateAt
end

--获取主角精灵ID
function userInfoFunc.getLeaderPetID( ... )
	return userInfoData.HeroPetId or 30
end

function userInfoFunc.getBossAtkBossId( ... )
	return bossBattleBossId
end

function userInfoFunc.setBossAtkBossId( bossId )
	bossBattleBossId = bossId
end

function userInfoFunc.setBossDownPlay( flag )
	bossDownPlay = flag
end

function userInfoFunc.getBossDownPlay( ... )
	return bossDownPlay
end

function userInfoFunc.setCoinWellFlag( flag )
	coinWellFlag = flag
end

function userInfoFunc.getCoinWellFlag( ... )
	return coinWellFlag
end

function userInfoFunc.setCoinWell( data )
	coinWell = data
	coinWellFlag = userInfoFunc.isCoinWellExit()
	if not data then
		coinWellFlag = false
	end
end

function userInfoFunc.getCoinWell( ... )
	return coinWell
end

function userInfoFunc.isCoinWellExit( ... )
	if coinWell then
		print("isCoinWellExit1")
		print(coinWell)
		print( tostring(math.floor(require "TimeListManager".getTimeUpToNow(coinWell.DisppearAt)) < 0) )
		return not coinWell.Deleted and math.floor(require "TimeListManager".getTimeUpToNow(coinWell.DisppearAt)) < 0
	else
		print("isCoinWellExit2 = " .. tostring(coinWellFlag))
		return coinWellFlag or false
	end
end

function userInfoFunc.getTitleName( ... )
	local dbtitle = require 'DBManager'.getTrainTitle(userInfoFunc.getTitleID())
	return (dbtitle and dbtitle.Name) or ''
end

function userInfoFunc.getTitleNameHorizontal( ... )
	local dbtitle = require 'DBManager'.getTrainTitle(userInfoFunc.getTitleID())
	return (dbtitle and dbtitle.Name1) or ''
end

function userInfoFunc.getTotalStars( ... )
	return userInfoData.TotalStars
end

function userInfoFunc.setTimeZone( strTimeZone )
	timeZone = {}
	timeZone.hour, timeZone.min, timeZone.sec = string.match(strTimeZone, "(%d+):(%d+):(%d+)")
	timeZone.hour = tonumber(timeZone.hour)
	timeZone.min = tonumber(timeZone.min)
	timeZone.sec = tonumber(timeZone.sec)
	if timeZone.hour == 0 and timeZone.min == 0 and timeZone.sec == 0 then
		timeZone.state = ""
	else
		local first = string.sub(strTimeZone, 1, 1)
		if first == "-" then
			timeZone.state = "-"
		else
			timeZone.state = "+"
		end
	end
end

function userInfoFunc.getTimeZone( ... )
	return timeZone
end

return userInfoFunc