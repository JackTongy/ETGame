--[[
	好友信息（Friend）
	字段				类型				说明
	Id 					Int 					主键 id
	Fid 				Int 					好友 id
	IsOnline 			Bool 				是否在线
	Name 				String 				好友名称
	Lv 					Int 					等级
	Power				Int 					战斗力
	Pet 				Pet 				宠物（队长）
	Invite 				Bool 				是否可以邀请
]]

local Utils = require 'framework.helper.Utils'

-- 好友模块
local friendsFunc = {}
local friendsData = {}
friendsData.friendsList = {}

function friendsFunc.cleanData()
	friendsData = {}
	friendsData.friendsList = {}
end

-- 返回好友列表
function friendsFunc.getFriendList(  )
	friendsData.friendsList = friendsData.friendsList or {}
	return friendsData.friendsList
end

-- 设置好友列表
function friendsFunc.setFriendList( list )
	friendsData.friendsList = list or {}

	local petFunc = require "PetInfo"
	for i,v in ipairs(friendsData.friendsList) do
		petFunc.convertToC(v.Pet)
	end
end

-- 返回可以邀请助战的好友列表
function friendsFunc.getFriendListCanInvite(  )
	local temp = {}
	if friendsData.friendsList then
		for i,v in ipairs(friendsData.friendsList) do
			if v.Invite then
				table.insert(temp, v)
			end
		end
	end
	return temp
end

function friendsFunc.setFriendCannotInvite( fid )
	if friendsData.friendsList and fid then
		for i,v in ipairs(friendsData.friendsList) do
			if v.Fid == fid then
				friendsData.friendsList[i].Invite = false
				break
			end
		end
	end
end

function friendsFunc.isMyFriend( fid )
	if friendsData.friendsList then
		for k,v in pairs(friendsData.friendsList) do
			if v.Fid == fid then
				return true
			end
		end
	end
	return false
end

function friendsFunc.sortWithMyFriends(  )
	table.sort(friendsData.friendsList, function ( v1, v2 )
		if v1.IsOnline and not v2.IsOnline then
			return true
		elseif v1.IsOnline == v2.IsOnline then
			if v1.Lv > v2.Lv then
				return true
			elseif v1.Lv == v2.Lv then
				if v1.CombatPower > v2.CombatPower then
					return true
				end
			end
		end
	end)
end

function friendsFunc.sortWithAp(  )
	-- print("AP-paixu")
	-- print(friendsData.friendsList)
	table.sort(friendsData.friendsList, function ( v1, v2 )
		local r1 = friendsFunc.isInRAps(v1.Fid)
		local r2 = friendsFunc.isInRAps(v2.Fid)
		local s1 = friendsFunc.isInSAps(v1.Fid)
		local s2 = friendsFunc.isInSAps(v2.Fid)
		if r1 and not r2 then
			return true
		elseif r1 == r2 then
			if not s1 and s2 then
				return true
			elseif s1 == s2 then
				if v1.IsOnline and not v2.IsOnline then
					return true
				elseif v1.IsOnline == v2.IsOnline then
					if v1.Lv > v2.Lv then
						return true
					elseif v1.Lv == v2.Lv then
						if v1.CombatPower > v2.CombatPower then
							return true
						end
					end
				end
			end
		end
	end)
	-- print("--------------------------")
	-- print(friendsData.friendsList)
end

function friendsFunc.sortApplysWithVerify(  )
	local timerListManager = require "TimeListManager"
	table.sort(friendsData.applys, function ( v1, v2 )
		local t1 = timerListManager.getTimestamp(v1.CreateAt)
		local t2 = timerListManager.getTimestamp(v2.CreateAt)
		return t1 > t2
	end)
end

function friendsFunc.addFriendToList( friend )
	local petFunc = require "PetInfo"
	petFunc.convertToC(friend.Pet)

	local canFind = false
	for i,v in ipairs(friendsData.friendsList) do
		if v.Fid == friend.Fid then
			friendsData.friendsList[i] = friend
			canFind = true
			break
		end
	end
	if not canFind then
		table.insert(friendsData.friendsList, friend)
	end
end

function friendsFunc.removeFriendWithId( friendId )
	if friendsData.friendsList then
		for i,v in ipairs(friendsData.friendsList) do
			if v.Id == friendId then
				table.remove(friendsData.friendsList, i)
				break
			end
		end
	end
end

-- 返回已赠送体力ID列表	-- 已赠送则当日不可再次赠送
function friendsFunc.getSAps(  )
	return friendsData.SAps
end

-- 设置已赠送体力ID列表	-- 已赠送则当日不可再次赠送
function friendsFunc.setSAps( SAps )
	friendsData.SAps = SAps
end

-- 返回可领取体力ID列表
function friendsFunc.getRAps(  )
	return friendsData.RAps
end

-- 设置可领取体力ID列表
function friendsFunc.setRAps( RAps )
	friendsData.RAps = RAps
end

-- 返回true不可赠送
function friendsFunc.isInSAps( fid )
	return friendsData.SAps and table.find(friendsData.SAps, fid) or false
end

-- 返回true可领取
function friendsFunc.isInRAps( fid )
	return friendsData.RAps and table.find(friendsData.RAps, fid) or false
end

function friendsFunc.isInTodayApList( fid )
	local result = false
	if friendsData.todayApList then
		result = table.find(friendsData.todayApList, fid)
	end
	return result
end

function friendsFunc.addFidToSAps( fid )
	if not friendsFunc.isInSAps(fid) then
		table.insert(friendsData.SAps, fid)
	end
end

function friendsFunc.removeFidFromSAps( fid )
	if friendsData.SAps then
		for i,v in ipairs(friendsData.SAps) do
			if v == fid then
				table.remove(friendsData.SAps, i)
				break
			end
		end
	end
end

function friendsFunc.addFidToRAps( fid )
	if not friendsFunc.isInRAps(fid) then
		table.insert(friendsData.RAps, fid)
	end
end

function friendsFunc.removeFidFromRAps( fid )
	if friendsData.RAps then
		for i,v in ipairs(friendsData.RAps) do
			if v == fid then
				table.remove(friendsData.RAps, i)
				break
			end
		end
	end
end

function friendsFunc.setTodayApList( list )
	friendsData.todayApList = list or {}
end

function friendsFunc.getCanSendApList( ... )
	local list = {}
	if friendsData.friendsList then
		for i,v in ipairs(friendsData.friendsList) do
			if not friendsFunc.isInSAps( v.Fid ) then
				table.insert(list, v.Fid)
			end
		end
	end
	return list
end

function friendsFunc.addFidToTodayApList( fid )
	friendsData.todayApList = friendsData.todayApList or {}
	table.insert(friendsData.todayApList, fid)
end

function friendsFunc.getTodayAp(  )
	return friendsData.todayApList and #friendsData.todayApList or 0
end

function friendsFunc.setEverydayApCap( apCap )
	friendsData.everydayApCap = apCap
end

function friendsFunc.getEverydayApCap(  )
	return friendsData.everydayApCap
end

-- 返回申请信息列表
function friendsFunc.getApplys(  )
	return friendsData.applys
end

-- 设置申请信息列表
function friendsFunc.setApplys( applys )
	friendsData.applys = applys
end

-- 设置邀请任务
function friendsFunc.setInviteTasks( inviteTasks )
	friendsData.inviteTasks = inviteTasks
end

-- 返回邀请任务
function friendsFunc.getInviteTasks(  )
	return friendsData.inviteTasks
end

-- 根据好友精灵队长进行排序
function friendsFunc.sortWithPet( list, selectPetId )
	table.sort(list, function ( a, b )
		if a.Invite and not b.Invite then
			return true
		elseif b.Invite and not a.Invite then
			return false
		elseif a.Invite == b.Invite then
			pet1 = a.Pet
			pet2 = b.Pet
			if selectPetId and pet1.Id == selectPetId then
				return true
			end
			if selectPetId ~= pet2.Id then
				if pet1.Power > pet2.Power then
					return true
				elseif pet1.Power == pet2.Power then
					if pet1.Lv > pet2.Lv then
						return true
					elseif pet1.Lv == pet2.Lv then
						if pet1.Id < pet2.Id then
							return true
						end
					end			
				end
			end
		end
	end)
end

-- 根据ID获取好友的精灵
function friendsFunc.getPetWithId( id )
	for k,v in pairs(friendsData.friendsList) do
		if v.Pet.Id == id then
			return v.Pet
		end
	end
	return nil
end

function friendsFunc.removeApplyWithId( fid )
	local dataArray = friendsFunc.getApplys()
	if dataArray then
		for i,v in ipairs(dataArray) do
			if v.Id == fid then
				table.remove(dataArray, i)
				break
			end
		end
	end
end

-- 关于红点的接口
function friendsFunc.checkNewsInvite( ... )
	-- local list = friendsFunc.getInviteTasks()
	-- for k,v in pairs(list) do
	-- 	if v.State == 2 then
	-- 		return true
	-- 	end
	-- end
	return false
end

function friendsFunc.checkNewsReceiveAP( ... )
	local list = friendsFunc.getRAps()
	return list and #list > 0 or false
end

function friendsFunc.chcekNewsVerify( ... )
	local list = friendsFunc.getApplys()
	return list and #list > 0 or false
end

return friendsFunc