--[[
Id	Int64	公会id
Title	String 	标题
Pic	Int	图标
Des	String	公告（字数客户端控制下）
Number	Int	当前成员数量
Lv	Int	公会等级
TcLvs	Dictionary<int,int>	各类科技等级（key为1~7分别对应文档内容）
JoinLv	Int	申请等级（0：不限）
Point	Int	公会资金
Power	Int	总战力（非实时）
President	Int	会长id
VicePresident	Int	副会长id
SignTimes 公会总签到次数限制
]]

local GuildInfo = {}
local Guild
local GuildMember
local GuildRanks
local PresidentLastLoginAt
local GuildMemberList
local ElectionState

function GuildInfo.cleanData()
	Guild = nil
	GuildMember = nil
	GuildRanks = nil
	PresidentLastLoginAt = nil
	GuildMemberList = nil
	ElectionState = nil
end

function GuildInfo.clear( ... )
	Guild = nil
	GuildMember = nil
	GuildRanks = nil
	PresidentLastLoginAt = nil
	GuildMemberList = nil
	ElectionState = nil
end 

function GuildInfo.setData( data )
	print('GuildInfo:setData:')
	print(data)
	if Guild then
		local userId = require 'AppData'.getUserInfo().getId()
		local isPresidentOrVice = GuildInfo.isPresident(userId) or GuildInfo.isVicePresident(userId)
		Guild = data
		if isPresidentOrVice then
			if not (GuildInfo.isPresident(userId) or GuildInfo.isVicePresident(userId)) then
				require 'AppData'.getBroadCastInfo().set("guild_apply", false)
		--		require "SocketClient":send(require "netModel".getModelRoleNewsUpdate("guild_apply"))
			end
		end
	else
		Guild = data
	end
	require 'EventCenter'.eventInput('RedPointGuild')
end

function GuildInfo.getData( ... )
	return Guild --or {Title='glee',Pic=2,Des='无',Number=10,Lv=1,TcLvs={},JoinLv=0,Point=9998,Power=9999,President=1,VicePresident=2}
end

function GuildInfo.setPresidentLastLoginAt( t )
	PresidentLastLoginAt = t
end

function GuildInfo.getPresidentLastLoginAt( ... )
	return PresidentLastLoginAt
end

function GuildInfo.setGuildMemberList( list )
	GuildMemberList = list
end

function GuildInfo.getGuildMemberList( ... )
	return GuildMemberList
end

function GuildInfo.setElectionState( status )
	ElectionState = status
end

function GuildInfo.getElectionState( ... )
	return ElectionState
end

function GuildInfo.setGuildMember( data )
	GuildMember = data
	require 'EventCenter'.eventInput('RedPointGuild')
end

function GuildInfo.getGuildMember( ... )
	return GuildMember-- or {Gid=1,Point=998,TcLvs={1,1,1,1,1,1,1},TotalPoint=9999,Sign=false}
end

function GuildInfo.Signed( ... )
	local isGuildExit = GuildMember and GuildMember.Gid > 0
	return not isGuildExit or GuildMember.Sign
end


function GuildInfo.isInGuild( ... )
	return GuildMember and GuildMember.Gid > 0
end

function GuildInfo.selfPresident( )
	local appdata = require 'AppData'
	return Guild and appdata.getUserInfo().getId() == Guild.President
end

function GuildInfo.getRanks( ... )
	return GuildRanks
end

function GuildInfo.setRanks( data )
	GuildRanks = data
end

function GuildInfo.addMPoint( Point )
	if Point and GuildMember then
		GuildMember.Point = GuildMember.Point+Point
	end
end

function GuildInfo.setMPoint( Point )
	if Point and GuildMember then
		GuildMember.Point = Point
	end
end


function GuildInfo.addGPoint( Point )
	if Point and Guild then
		Guild.Point = Guild.Point+Point
	end
end

function GuildInfo.setGPoint( Point )
	if Point and Guild then
		Guild.Point = Point
	end
end

function GuildInfo.isPresident( id )
	return Guild and id == Guild.President 
end

function GuildInfo.isVicePresident( id )
	if Guild and Guild.VicePresidents then
		return table.find(Guild.VicePresidents, id)
	end
	return false
end

function GuildInfo.leaveGuild( ... )
	if GuildMember then
		GuildMember.Gid = 0
	end
end

function GuildInfo.selfPresidentOrVicePresident( ... )
	local appdata = require 'AppData'
	return Guild and appdata.getUserInfo().getId() == Guild.President or GuildInfo.isVicePresident(appdata.getUserInfo().getId())
end
return GuildInfo