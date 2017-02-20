local config = require "Config"
local timeManager =require 'TimeManager'
local roleSelfManager=require 'RoleSelfManager'
local utils = require 'framework.helper.Utils'


local PVPRoom = class(LuaController)

local Client = require 'SocketClientPvp'
local TimeManager = require 'TimeManager'

--send ? 

function PVPRoom:createDocument()
	self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."PVPRoom.cocos.zip")
	return self._factory:createDocument("PVPRoom.cocos")
end

--@@@@[[[[
function PVPRoom:onInitXML()
    local set = self._set
   self._bg = set:getElfNode("bg")
   self._ll1_uId = set:getInputTextNode("ll1_uId")
   self._ll2_roomId = set:getInputTextNode("ll2_roomId")
   self._button = set:getButtonNode("button")
   self._shadow = set:getElfNode("shadow")
   self._shadow_info = set:getLabelNode("shadow_info")
   self._pingButton = set:getButtonNode("pingButton")
   self._ActionShowWait = set:getElfAction("ActionShowWait")
   self._ActionHideWait = set:getElfAction("ActionHideWait")
end
--@@@@]]]]

--------------------------------override functions----------------------

function PVPRoom:onInit( userData, netData )
	-- {"C":"Entry","M":1,"D":{"Token":"3-1-1395897289997-23123123123123123"}}

	local roomData = utils.readTableFromFile('loginRoom.lua')
	if roomData then
		print(roomData)
		print('roomData')
		self._ll1_uId:setText(roomData.uid)
		self._ll2_roomId:setText(roomData.rid)
	end

	self._button:setListener(function ()
		-- body
		local uid = self._ll1_uId:getText()
		local rid = self._ll2_roomId:getText()

		local roomData = {uid=uid,rid=rid}
		utils.writeTableToFile(roomData, 'loginRoom.lua')

		-- local osTime =os.time()*1000  -- C++时间的毫秒获取有问题 
		local serverTime = timeManager.getCurrentSeverTime()

		local pvpLoginData = { C='Entry', D = {Token=''..uid..'-'..rid..'-'..'xxx',T=serverTime} }

		-- pvpLoginData.D
		local msg = Client:send(pvpLoginData, function (data )
			--返回当前玩家的id
			roleSelfManager.dyId=data.D.Id  
			-- 设置误差校验值

			-- timeManager.setLoginSeverTime(data.D.T)
		end)
		
		self:toast(''..msg)
		
	end)



	-- body
	local timedata = { C='Ping' }

	local firstOffsetTime--
	local firstStartTime--

	-- local nowOffset
	-- local 

	self._pingButton:setListener(function ( ... )
		-- body
		local time1 = SystemHelper:currentTimeMillis()

		Client:send(timedata, function ( netdata )
			-- print(netdata)
			-- body
			local now = SystemHelper:currentTimeMillis() --SystemHelper:currentTimeMillis()

			print('发送的时间:'..time1)
			print('服务器时间:'..netdata.D.T)
			print('接收的时间:'..now)
			print('时间的差值:'..((now+time1)/2-netdata.D.T))
			print('传输的时间:'..(now-time1))
			print('调节值:'..TimeManager._adjust2ServerTime)

			local nowOffset = ((now+time1)/2-netdata.D.T)
			
			firstOffsetTime = firstOffsetTime or nowOffset
			firstStartTime = firstStartTime or now

			print('======')
			print('流逝时间:'..(now-firstStartTime))
			print('误差时间:'..(nowOffset-firstOffsetTime))
		end)
	end)

end

function PVPRoom:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(PVPRoom, "PVPRoom")


--------------------------------register--------------------------------
GleeCore:registerLuaController("PVPRoom", PVPRoom)


