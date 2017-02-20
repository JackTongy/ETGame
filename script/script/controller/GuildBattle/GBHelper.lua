local GBHelper = {}
local dbManager = require "DBManager"
local timeManager = require "TimeManager"

GBHelper.MidCastle = 1
GBHelper.MatchStatus = {
	Undefined = 0,		-- 未定义状态
	Signuping = 1,		-- 报名中
	MatchBefore = 2,	-- 报名结束，开赛前
	BattleArraySetting = 3,		-- 战前部署
	FightPrepare = 4,	-- 战前准备（不可操作）
	Fighting = 5,	-- 开战中
	Dealing = 6,	-- 结算中
	GameOver = 7,	-- 比赛已结束
	SignupBefore = 8,		-- 报名之前
}

GBHelper.ChallengeStatus = {
	Undefined = 0,		-- 未定义状态
	Waiting = 1,
	Challenging = 2,
	GameOver = 3
}

-- 赛程信息(本公会已报名 + 服务器当前 UTC 时间 + 当前赛程安排)
function GBHelper.getGuildMatchSchedule( ... )
	return GBHelper.GuildMatchSchedule
end

function GBHelper.setGuildMatchSchedule( data )
	GBHelper.GuildMatchSchedule = data
end

-- 个人公会战信息
function GBHelper.getGuildMatchPlayer( ... )
	return GBHelper.playerInfo
end

function GBHelper.setGuildMatchPlayer( player )
	GBHelper.playerInfo = player
end

-- 同组三个公会信息
function GBHelper.getMatches( ... )
	return GBHelper.Matches
end

function GBHelper.setMatches( data )
	if data then
		table.sort(data, function ( match1, match2 )
			return match1.Rank < match2.Rank
		end)
	end

	GBHelper.Matches = data
	GBHelper.setGuildColorDict(data)
end

-- 大地图据点信息
function GBHelper.getCastles( ... )
	return GBHelper.Castles
end

function GBHelper.setCastles( data )
	GBHelper.Castles = data
	if GBHelper.Castles and #GBHelper.Castles == 24 then
		local castle = {}
		castle.Cmd = 0
		castle.ServerId = 0
		castle.CastleId = GBHelper.MidCastle
		castle.Target = 0
		castle.Occupied = false
		castle.GuildId = 0
		castle.HpLeft = 100
		castle.HpMax = 100
		table.insert(GBHelper.Castles, castle)
	end
end

function GBHelper.getTargetsMine( ... )
	local list = {}
	local playerInfo = GBHelper.playerInfo
	if playerInfo then
		for i,v in ipairs(GBHelper.getCastles()) do
			if v.Target > 0 and v.ServerId == playerInfo.ServerId and v.GuildId == playerInfo.Gid then
				table.insert(list, v.Target)
			end
		end
	end
	return list
end

function GBHelper.updateCastle( castle )
	if GBHelper.Castles then
		for i,v in ipairs(GBHelper.Castles) do
			if v.CastleId == castle.CastleId then
				GBHelper.Castles[i] = castle
			end
		end
	end
end

function GBHelper.updateCastles( castles )
	if GBHelper.Castles and castles then
		for _,cls in pairs(castles) do
			for i,v in ipairs(GBHelper.Castles) do
				if v.CastleId == cls.CastleId then
					GBHelper.Castles[i] = cls
					break
				end
			end
		end
	end
end

function GBHelper.setGuildColorDict( matchs )
	if matchs then
		GBHelper.colorDict = {}
		for i,v in ipairs(matchs) do
			if v.CastleId and #v.CastleId > 0 then
				GBHelper.colorDict[ v.ServerId .. v.GuildId ] = tonumber(string.sub(tostring(v.CastleId[1]), 1, 1))
			end
		end
	end
end

function GBHelper.getGuildColor( serverId, guildId )
	return GBHelper.colorDict and GBHelper.colorDict[ serverId .. guildId ] or nil
end

function GBHelper.getGuildColorIcon( serverId, guildId, castleId )
	if castleId == GBHelper.MidCastle then
		return "N_GHZ_zljd.png"
	else
		local color = GBHelper.getGuildColor(serverId, guildId)
		return color and string.format("N_GHZ_jd%d.png", color) or ""	
	end
end

function GBHelper.getGuildBar( serverId, guildId )
	local color = GBHelper.getGuildColor(serverId, guildId)
	return string.format("N_GHZ_x%d.png", color)
end

function GBHelper.isCamp( castleId )
	local campList = {10, 20, 30}
	return table.find(campList, castleId)
end

function GBHelper.getOpponentCastleIdListConnect( castleId )
	local list = dbManager.getGuildMatchCastleConfig( castleId ).Nexts
	local result = {castleId}
	for i,v in ipairs(list) do
		if not GBHelper.isMyCastle( GBHelper.getCastleWithId( v ) ) and not GBHelper.isCamp( v ) then
			table.insert(result, v)
		end
	end
	return result
end

function GBHelper.getMyCastleCanCmd( castle )
	if GBHelper.isMyCastle( castle ) then
		local list = dbManager.getGuildMatchCastleConfig( castle.CastleId ).Nexts
		for i,v in ipairs(list) do
			if not GBHelper.isMyCastle( GBHelper.getCastleWithId( v ) ) then
				return true
			end
		end
	end
	return false
end

function GBHelper.getOpponentCastleCanAtk( castle )
	if not GBHelper.isMyCastle( castle ) then
		local list = dbManager.getGuildMatchCastleConfig( castle.CastleId ).Nexts
		for i,v in ipairs(list) do
			local thisCastle = GBHelper.getCastleWithId( v )
			if GBHelper.isMyCastle( thisCastle ) then
				if thisCastle.Target == castle.CastleId then
					return true
				end
			end
		end
	end
	return false
end

function GBHelper.isStatusFighting( ... )
	return GBHelper.getMatchStatusWithSeconds() == GBHelper.MatchStatus.Fighting
end

function GBHelper.haveActionPointNoCd( ... )
	return GBHelper.playerInfo and GBHelper.playerInfo.ActionPoint > 0 and GBHelper.playerInfo.Cd == 0
end

function GBHelper.isMyCastle( castle )
	if GBHelper.playerInfo then
		return GBHelper.playerInfo.Gid == castle.GuildId and GBHelper.playerInfo.ServerId == castle.ServerId
	end
	return false
end

function GBHelper.isMatchStart( ... )
	local curTime = timeManager.getCurrentSeverTime() / 1000
	return curTime > timeManager.getTimestamp(GBHelper.GuildMatchSchedule.Schedule.MatchStart)
end

function GBHelper.getMatchStatusWithSeconds( )
	local status = GBHelper.MatchStatus.Undefined
	local seconds = 0
	if GBHelper.GuildMatchSchedule and GBHelper.GuildMatchSchedule.Schedule then
		local schedule = GBHelper.GuildMatchSchedule.Schedule
		print("------------------------------schedule-----------------------------")
		print(schedule)
		local curTime = math.floor( timeManager.getCurrentSeverTime() / 1000 )
		if curTime < timeManager.getTimestamp(schedule.SeasonStart) then
			status = GBHelper.MatchStatus.SignupBefore
			seconds = timeManager.getTimestamp(schedule.SeasonStart) - curTime	
		elseif curTime < timeManager.getTimestamp(schedule.SignUpFinish) then
			status = GBHelper.MatchStatus.Signuping
			seconds = timeManager.getTimestamp(schedule.SignUpFinish) - curTime
		elseif curTime < timeManager.getTimestamp(schedule.MatchFinish) then
			local date = timeManager.getCurrentSeverDate()
			local h1, m1 = dbManager.getGuildFightTime( GBHelper.MatchStatus.BattleArraySetting )
			local h2, m2 = dbManager.getGuildFightTime( GBHelper.MatchStatus.FightPrepare )
			local h3, m3 = dbManager.getGuildFightTime( GBHelper.MatchStatus.Fighting )
			local h4, m4 = dbManager.getGuildFightTime( GBHelper.MatchStatus.Dealing )
			if GBHelper.isDateOld(date, h1, m1) then
				status = GBHelper.MatchStatus.MatchBefore
				seconds = GBHelper.getTimeDiff(h1, m1, date)	
			elseif GBHelper.isDateOld(date, h2, m2) then
				status = GBHelper.MatchStatus.BattleArraySetting
				seconds = GBHelper.getTimeDiff(h2, m2, date)
			elseif GBHelper.isDateOld(date, h3, m3) then
				status = GBHelper.MatchStatus.FightPrepare
				seconds = GBHelper.getTimeDiff(h3, m3, date)
			elseif GBHelper.isDateOld(date, h4, m4) then	
				status = GBHelper.MatchStatus.Fighting
				seconds = GBHelper.getTimeDiff(h4, m4, date)
			else
				status = GBHelper.MatchStatus.MatchBefore
				seconds = GBHelper.getTimeDiff(h1 + 24, m1, date)
			end
		else
			status = GBHelper.MatchStatus.GameOver
			seconds = 0
		end
	end
	print('status = ' .. status .. ", seconds = " .. seconds)
	return status, seconds
end

function GBHelper.isDateOld( date, hour, minute )
	if date.hour == hour then
		return date.min < minute
	else
		return date.hour < hour
	end
end

function GBHelper.getTimeDiff( hour, minute, date )
	return (hour * 3600 + minute * 60) - (date.hour * 3600 + date.min * 60 + date.sec)
end

function GBHelper.getCastleWithId( castleId )
	if GBHelper.Castles then
		for k,v in pairs(GBHelper.Castles) do
			if v.CastleId == castleId then
				return v
			end
		end
	end
end

function GBHelper.isCastleLineToCamp( castleId, serverId, guildId )
	local result = false
	local list = dbManager.getGuildMatchCastleConfig( castleId ).Nexts
	if list then
		for i,v in ipairs(list) do
			local castle = GBHelper.getCastleWithId( v )
			if castle and guildId == castle.GuildId and serverId == castle.ServerId then
				result = true
				break
			end
		end
	end
	return result
end

-- function GBHelper.isCastleLineToCamp( castleId, serverId, guildId )
-- 	local iCampId = GBHelper.getCampId( serverId, guildId )
-- 	local closeList = {}
-- 	local function check( id )
-- 		local list = dbManager.getGuildMatchCastleConfig( id ).Nexts
-- 		local ttimes = 0
-- 		for k,v in pairs(list) do
-- 			if iCampId == v then
-- 				return true
-- 			else
-- 				if not table.find(closeList, v) then
-- 					table.insert(closeList, v)
-- 					local castle = GBHelper.getCastleWithId( v )
-- 					if castle and guildId == castle.GuildId and serverId == castle.ServerId then
-- 						if check(v) then
-- 							return true
-- 						end
-- 					end
-- 				else
-- 					ttimes = ttimes + 1
-- 					if ttimes == #list then
-- 						return false
-- 					end
-- 				end	
-- 			end
-- 		end
-- 	end
-- 	return check(castleId)
-- end

function GBHelper.getMyCampId( ... )
	if GBHelper.playerInfo and GBHelper.Matches then
		for i,v in ipairs(GBHelper.Matches) do
			if v.ServerId == GBHelper.playerInfo.ServerId and v.GuildId == GBHelper.playerInfo.Gid then
				return v.CastleId[1]
			end
		end
	end
end

function GBHelper.getCampId( serverId, guildId )
	if GBHelper.playerInfo and GBHelper.Matches then
		for i,v in ipairs(GBHelper.Matches) do
			if v.ServerId == serverId and v.GuildId == guildId then
				return v.CastleId[1]
			end
		end
	end
end

function GBHelper.getChallengeStatusWithSeconds( )
	local status = GBHelper.ChallengeStatus.Undefined
	local seconds = 0
	if GBHelper.GuildMatchSchedule and GBHelper.GuildMatchSchedule.Schedule then
		local schedule = GBHelper.GuildMatchSchedule.Schedule
		local curTime = math.floor( timeManager.getCurrentSeverTime() / 1000 )
		if curTime < timeManager.getTimestamp(schedule.ChallengeStartOne) then
			status = GBHelper.ChallengeStatus.Waiting
			seconds = timeManager.getTimestamp(schedule.ChallengeStartOne) - curTime
		elseif curTime < timeManager.getTimestamp(schedule.ChallengeFinishOne) then
			status = GBHelper.ChallengeStatus.Challenging
			seconds = timeManager.getTimestamp(schedule.ChallengeFinishOne) - curTime
		elseif curTime < timeManager.getTimestamp(schedule.ChallengeStartTwo) then
			status = GBHelper.ChallengeStatus.Waiting
			seconds = timeManager.getTimestamp(schedule.ChallengeStartTwo) - curTime
		elseif curTime < timeManager.getTimestamp(schedule.ChallengeFinishTwo) then
			status = GBHelper.ChallengeStatus.Challenging
			seconds = timeManager.getTimestamp(schedule.ChallengeFinishTwo) - curTime
		else
			status = GBHelper.ChallengeStatus.GameOver
			seconds = 0
		end
	end
	print("status = " .. status .. ", seconds = " .. seconds)
	return status, seconds
end

function GBHelper.canBattleArraySetting( ... )
	if GBHelper.getGuildMatchPlayer() == nil then
		return false
	end
	local status = GBHelper.getMatchStatusWithSeconds()
	return status == GBHelper.MatchStatus.MatchBefore or status == GBHelper.MatchStatus.BattleArraySetting or status == GBHelper.MatchStatus.Dealing or status == GBHelper.MatchStatus.GameOver
end

function GBHelper.getGuildMatchBoxCount( serverId, guildId )
	if GBHelper.playerInfo and GBHelper.Matches then
		for i,v in ipairs(GBHelper.Matches) do
			if v.ServerId == serverId and v.GuildId == guildId then
				return v.Boxes
			end
		end
	end
	return 0
end

function GBHelper.addMyGuildMatchBoxCount( ... )
	if GBHelper.playerInfo and GBHelper.Matches then
		for i,v in ipairs(GBHelper.Matches) do
			if v.ServerId == GBHelper.playerInfo.ServerId and v.GuildId == GBHelper.playerInfo.Gid then
				GBHelper.Matches[i].Boxes = GBHelper.Matches[i].Boxes + 1
				break
			end
		end
	end
end

return GBHelper