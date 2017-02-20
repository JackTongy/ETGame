local helper = {}

local netModel = require "netModel"
local gameFunc = require "AppData"
local dbManager = require "DBManager"
local res = require "Res"

function helper.FriendApply( self, fid, callback, errCallback )
	if helper.FriendApplyPrepare() then
		self:send(netModel.getModelFriendApply(fid), function ( data )
			print("FriendApply")
			print(data)
			if data and callback then
				callback(data)
			end
		end, function ( data )
			print("FriendApply error")
			print(data)
			if data and errCallback then
				errCallback(data)
			end
		end)
	else
		if errCallback then
			errCallback()
		end
	end
end

function helper.FriendApplyList( self, fids, callback, errCallback )
	if helper.FriendApplyPrepare() then
		self:send(netModel.getModelFriendApplyList(fids), function ( data )
			print("FriendApplyList")
			print(data)
			if data and callback then
				callback(data)
			end
		end, function ( data )
			print("FriendApplyList error")
			print(data)
			if data and errCallback then
				errCallback(data)
			end
		end)
	end
end

function helper.FriendApplyPrepare( ... )
	local friendsFunc = gameFunc.getFriendsInfo()
	local friendList = friendsFunc.getFriendList()
	local userInfo = gameFunc.getUserInfo()
	local levelCapTable = dbManager.getInfoRoleLevelCap(userInfo.getLevel())
	if friendList and #friendList >= levelCapTable.friendcap then
		GleeCore:toast(res.locString("Friend$CapTip"))
		return false	
	end
	return true
end

return helper