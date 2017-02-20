local userFunc = require "UserInfo"
local netModel = require "netModel"
local Toolkit  = require 'Toolkit'

local function getOpenStatus( ... )
	if Toolkit.isTimeBetween(11,0,13,0) then
		return 1
	elseif Toolkit.isTimeBetween(17,0,19,0) then
		return 2
	elseif Toolkit.isTimeBetween(21,0,23,0) then
		return 3
	else
		return 0
	end
end

local function checkEnable( state )
	local status = getOpenStatus()
	return status>0 and status ~= state
end

local function update1( view,enable )
	view["bg_duck"]:setVisible(enable)
	view["bg_eatBtn"]:setEnabled(enable)
	local status = getOpenStatus()
	view["bg_fire"]:setVisible(status>0)
	if status>0 and not enable then
		view["bg_eatBtn_label"]:setString(require "Res".locString("Activity$RoastDuckEatBtnText1"))
	end
end

local function hasDouble( ... )
	local actInfo = require "ActivityInfo".getDataByType(13)
	if actInfo then
		print(actInfo)
		if actInfo.Data == 1 then
			return true
		else
			local status = getOpenStatus()
			if actInfo.Data == 2 and status == 1 then
				return true
			elseif actInfo.Data == 3 and (status == 2 or status == 3) then
				return true
			end
		end
	end
	return false
end

local checkRedPoint
local update
update = function ( self,view )
	local state = userFunc.getData().DuckGot
	view.mState = state
	local enable = checkEnable(state)
	update1(view,enable)

	view["bg_double"]:setVisible(hasDouble())

	if enable then
		view["bg_eatBtn"]:setListener(function ( ... )
			if checkEnable(state) then
				if state == 3 then
					if userFunc.getVipLevel() < 3 then
						self:toast(res.locString("Activity$RoastDuckEatVipTip"))
						return
					end
				end
				
				self:send(netModel.getModelRoleEatDuck(),function ( data )
					print(data)
					self:toast(string.format(require "Res".locString("Activity$RoastDuckEatedTip"),hasDouble() and 60 or 30))
					userFunc.setData(data.D.Role)
					view.mState = data.D.Role.DuckGot
					update1(view,false)
					checkRedPoint(self)
				end)
			else
				self:toast(require "Res".locString("Activity$ActFinishTip"))
				update1(view,false)
				checkRedPoint(self)
			end
		end)
	else
		self:roleNewsUpdate()	
	end
end

checkRedPoint = function ( self )
	self:roleNewsUpdate()
end

return {update = update}