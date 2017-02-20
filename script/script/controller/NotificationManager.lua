local moveSpeed = 100
local kPosY = 168
local kHeadOffsetX = 864
local showTime = 3

local layerManager = require "framework.interface.LuaLayerManager"

local mgr = {}

local NotifyOrder = {Hongbao = 1,SystemNotify = 2,UserNotify = 3}

mgr.notifyList = {}
mgr.tickHandlers = {}

mgr.isRunning = false

function mgr.init(  )
	local config = require 'Config'
 	local utils = require 'framework.helper.Utils'
	factory = XMLFactory:getInstance()
	factory:setZipFilePath(config.COCOS_ZIP_DIR.."Notification.cocos.zip")
	local document = factory:createDocument("Notification.cocos")
	document:retain()

 	function mgr.createNodeSet( nodeName )
	     	local element = factory:findElementByName(document, nodeName)
	  	assert(element) 

	       	local cset = factory:createWithElement(element)
	      	return utils.toluaSet(cset)
	end

	local layer = ElfLayer:create()
	CCDirector:sharedDirector():getRunningScene():addChild(layer,101)
	local set = mgr.createNodeSet("@notification")
	mgr._bg = set["bg"]
	mgr._clip = set["clip"]
	mgr._btn = set["btn"]
	mgr._clip:setPosition(0,kPosY)
	mgr._root = set[1]
	layer:addChild(mgr._root)
	mgr._root:setVisible(false)

	local func = layerManager.show
	layerManager.show = function ( self,... )
		func(self,...)
		mgr.onLayerChange()
	end

	local func = layerManager.hide
	layerManager.hide = function ( self,... )
		func(self,...)
		mgr.onLayerChange()
	end

	local func = GleeCore.pushController
	GleeCore.pushController = function (self, ...)
		func(self,...)
		mgr.onLayerChange()
	end

	local func = GleeCore.replaceController
	GleeCore.replaceController = function (self,...)
		func(self,...)
		mgr.onLayerChange()
	end

	local func = GleeCore.popControllerTo0
	GleeCore.popControllerTo0 = function ( self,...)
		func(self,...)
		mgr.onLayerChange()
	end

	local func = GleeCore.popController0
	GleeCore.popController0 = function (self,...)
		func(self,...)
		mgr.onLayerChange()
	end

	mgr.addBtnListener()

	mgr.inited = true
end

function mgr.addBtnListener( ... )
	mgr._btn:setListener(function ( ... )
		assert(mgr.curNotifyData,"no current notifydata ")
		require 'SocketClient'.send0(require "netModel".getModelHongbaoRob(mgr.curNotifyData.Hongbao.Id),function ( netdata )
			print(netdata)
			if netdata and netdata.D and netdata.D.Resource then
				require "AppData".updateResource(netdata.D.Resource)
				require "Res".doActionGetReward(netdata.D.Reward)
			else
				GleeCore:toast(require "Res".locString("RedPaper$paperfail"))
			end
			mgr._btn:setVisible(false)
		end)
	end)
	mgr._btn:setVisible(false)
end

function mgr.reset( ... )
	for _,v in ipairs(mgr.tickHandlers) do
		require "framework.sync.TimerHelper".cancel(v)
	end
	mgr.notifyList = {}
	mgr.tickHandlers = {}
	if mgr.inited then
		mgr.hide()
	end
end

function mgr.onLayerChange( ... )
	print("----------onLayerChange-----------")
	mgr.tickHandlers[#mgr.tickHandlers+1] = require "framework.sync.TimerHelper".tick(function ( ... )
		if mgr.needToShow() then
			mgr.show()
		else
			mgr.hide()
		end
	      	return true
	end)
end

function mgr.needToShow( ... )
	local lang = require 'Config'.LangName
	if lang == "ES" or lang == "PT" then
		return false
	end

	if mgr.hasNotification() or mgr.isRunning then
		local cname = GleeCore:getRunningController():getControllerName()
		print("CName------>:"..cname)
		if cname~= "CHome" and cname ~= "CWorldMap" and  cname ~= "CDungeon" then
			return false
		end
		-- for _,v in pairs(layerManager._runningLayerMap) do
		-- 	if v:getType() ~= "Menu" then
		-- 		return false
		-- 	end
		-- end
		return true
	else
		return false
	end
end

function mgr.show( ... )
	mgr._root:setVisible(true)
	if not mgr.isRunning then
		mgr._bg:setPosition(-1136,kPosY)
		mgr._bg:runAction(CCMoveTo:create(0.3,CCPointMake(0,kPosY)))
		
		mgr.showNotification()

		mgr.isRunning = true
	end
end

function mgr.hide( ... )
	mgr._root:setVisible(false)
end

function mgr.hasNotification( ... )
	for i=1,table.maxn(mgr.notifyList) do
		local t = mgr.notifyList[i]
		if t and #t>0 then
			return true
		end
	end
end

function mgr.getNotificationToShow( ... )
	for i=1,table.maxn(mgr.notifyList) do
		local t = mgr.notifyList[i]
		if t and #t>0 then
			return table.remove(t)
		end
	end
end

function mgr.onNotificaitionFinish( node )
	print("-------onNotificaitionFinish---------")
	node:removeFromParentAndCleanup(true)
	if mgr.hasNotification() then
		mgr.showNotification()
	else
		local arr = CCArray:create()
		arr:addObject(CCMoveTo:create(0.3,CCPointMake(-1136,kPosY)))
		arr:addObject(CCCallFunc:create(function ( ... )
			mgr._root:setVisible(false)
			mgr.isRunning = false
			if mgr.hasNotification() then
				mgr.show()
			end
		end))
		mgr._bg:runAction(CCSequence:create(arr))
	end
end

function mgr.showNotification(  )
	local node,data = mgr.createNotification()
	mgr._clip:addChild(node)
	local w = node:getContentSize().width
	node:setPosition(480,0)
	local arr = CCArray:create()
	arr:addObject(CCDelayTime:create(0.1))
	arr:addObject(CCMoveBy:create(0.3,CCPointMake(-kHeadOffsetX,0)))
	local b = mgr.isHongbao(data) and data.Rid ~= require "UserInfo".getId()
	if b then
		arr:addObject(CCCallFunc:create(function ( ... )
			local x = node:getPosition()
			local wBtn = mgr._btn:getContentSize().width
			mgr._btn:setPosition(x+w+wBtn/2,170)
			mgr._btn:setVisible(true)
		end))
	end
	arr:addObject(CCDelayTime:create(showTime))
	if b then
		arr:addObject(CCCallFunc:create(function ( ... )
			mgr._btn:setVisible(false)
		end))
	end
	local len = w+960 - kHeadOffsetX
	local time = b and 0.1 or len/moveSpeed
	arr:addObject(CCMoveBy:create(time,CCPointMake(-len,0)))
	arr:addObject(CCCallFunc:create(function ( ... )
		return mgr.onNotificaitionFinish(node)
	end))
	node:runAction(CCSequence:create(arr))
	mgr.curNotifyData = data
end

function mgr.createNotification( )
	local data = mgr.getNotificationToShow()
	local label = mgr.createNodeSet("@label")[1]
	if mgr.isHongbao(data) then
		label:setString(data.Content)
	else
		label:setString(string.format("%s：%s",data.Name,data.Content))
	end
	label:setAnchorPoint(CCPointMake(0,0.5))
	if data.Rid == 0 then
		label:setFontFillColor(ccc4f(0.76,1,1,0.19),true)--0.19,0.76,1,1
	else
		label:setFontFillColor(ccc4f(0.6,0.08,1,0.97),true)--0.97,0.6,0.08,1
	end
	return label,data
end

function mgr.isHongbao( data )
	return data.ShareType == 4
end

function mgr.onNewNotificationGet( data )
	if not mgr.inited then
		mgr.init()
	end

	local order
	if mgr.isHongbao(data) then
		order = NotifyOrder.Hongbao
	elseif data.Rid == 0 then
		order = NotifyOrder.SystemNotify
	else
		order = NotifyOrder.UserNotify
	end
	mgr.notifyList[order] = mgr.notifyList[order] or {}
	table.insert(mgr.notifyList[order],1,data)

	if not mgr.isRunning and mgr.needToShow() then
		mgr.show()
	end
end

require 'EventCenter'.addEventFunc("NewBroadcastChatGet", function ( data )
	return mgr.onNewNotificationGet(data)
end, "NotificationManager")

function mgr.sendSysNotify( data )
	local t  = {}
	t.Rid = 0
	t.Name = require "Res".locString("Global$SysNotification")
	t.Content = data.Content
	mgr.onNewNotificationGet(t)
	mgr.sysNotifySendCounts[data.Id] = mgr.sysNotifySendCounts[data.Id] or 0
	mgr.sysNotifySendCounts[data.Id] = mgr.sysNotifySendCounts[data.Id] + 1
end

function mgr.scheduleSysNotifyList( ... )
	local list = require "AppData".getSysNotifyList()
	table.sort(list,function ( a,b )
		return a.No<b.No
	end)

	mgr.sysNotifySendCounts = {}
	
	for i,v in ipairs(list) do
		mgr.sendSysNotify(v)
		if mgr.sysNotifySendCounts[v.Id] < v.T then
			mgr.tickHandlers[#mgr.tickHandlers+1]=require "framework.sync.TimerHelper".tick(function ( ... )
				mgr.sendSysNotify(v)
				if mgr.sysNotifySendCounts[v.Id] >= v.T then
			      		return true
			      	end
			end,v.F)
		end
	end
end

return mgr