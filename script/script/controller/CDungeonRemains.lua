--[[
	地图类型定义：
	0. 空地
	1. 小怪
	2. BOSS
	3. 血瓶
	4. 剑
	5. 炸弹
	6. 宝箱
	7. 钥匙
	8. 金币
	9. 木桶
	10. 进入下一层的门
	11. 出口
	12. 放大镜
]]

local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local netModel = require "netModel"
local gameFunc = require "AppData"
local EventCenter = require 'EventCenter'
local musicHelper = require 'framework.helper.MusicHelper'

local wGridCount = 8
local hGridCount = 5
local girdCount = wGridCount * hGridCount
local largeNum = 9999999

local CDungeonRemains = class(LuaController)

function CDungeonRemains:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CDungeonRemains.cocos.zip")
    return self._factory:createDocument("CDungeonRemains.cocos")
end

--@@@@[[[[
function CDungeonRemains:onInitXML()
	local set = self._set
    self._dungeonBg = set:getElfNode("dungeonBg")
    self._bg = set:getClipNode("bg")
    self._bg_floorlayoutx = set:getLayoutNode("bg_floorlayoutx")
    self._bg_layoutx = set:getLayoutNode("bg_layoutx")
    self._shadow = set:getElfNode("shadow")
    self._lucky = set:getElfNode("lucky")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon = set:getElfNode("icon")
    self._icon_shadow = set:getElfNode("icon_shadow")
    self._icon_monsterFlag = set:getElfNode("icon_monsterFlag")
    self._icon_nameBg = set:getElfNode("icon_nameBg")
    self._icon_nameBg_name = set:getLabelNode("icon_nameBg_name")
    self._icon = set:getElfNode("icon")
    self._effect1 = set:getSimpleAnimateNode("effect1")
    self._effect2 = set:getSimpleAnimateNode("effect2")
    self._icon2 = set:getElfNode("icon2")
    self._icon = set:getElfNode("icon")
    self._effect = set:getSimpleAnimateNode("effect")
    self._icon2 = set:getElfNode("icon2")
    self._icon = set:getElfNode("icon")
    self._icon = set:getElfNode("icon")
    self._effect1 = set:getSimpleAnimateNode("effect1")
    self._effect2 = set:getSimpleAnimateNode("effect2")
    self._effect2 = set:getSimpleAnimateNode("effect2")
    self._icon = set:getElfNode("icon")
    self._effect1 = set:getSimpleAnimateNode("effect1")
    self._icon = set:getElfNode("icon")
    self._tree = set:getElfNode("tree")
    self._decoverAnime = set:getSimpleAnimateNode("decoverAnime")
    self._btn = set:getButtonNode("btn")
    self._dungeonFrame = set:getElfNode("dungeonFrame")
    self._dungeonFrame_pic = set:getElfNode("dungeonFrame_pic")
    self._dungeonFrame_titleBg_title = set:getLabelNode("dungeonFrame_titleBg_title")
    self._mask = set:getElfNode("mask")
    self._begin = set:getStencilBeginNode("begin")
    self._btn = set:getButtonNode("btn")
    self._end = set:getStencilEndNode("end")
    self._detailLayer = set:getElfNode("detailLayer")
    self._detailLayer_Magnifier = set:getElfNode("detailLayer_Magnifier")
    self._detailLayer_Magnifier_icon = set:getElfNode("detailLayer_Magnifier_icon")
    self._detailLayer_Magnifier_count = set:getLabelNode("detailLayer_Magnifier_count")
    self._detailLayer_Magnifier_text = set:getLabelNode("detailLayer_Magnifier_text")
    self._detailLayer_Magnifier_btn = set:getButtonNode("detailLayer_Magnifier_btn")
    self._detailLayer_hp_count = set:getLabelNode("detailLayer_hp_count")
    self._detailLayer_atk_count = set:getLabelNode("detailLayer_atk_count")
    self._detailLayer_key_count = set:getLabelNode("detailLayer_key_count")
    self._detailLayer_SADice1 = set:getSimpleAnimateNode("detailLayer_SADice1")
    self._detailLayer_SADice2 = set:getSimpleAnimateNode("detailLayer_SADice2")
    self._detailLayer_dice1 = set:getElfNode("detailLayer_dice1")
    self._detailLayer_dice2 = set:getElfNode("detailLayer_dice2")
    self._detailLayer_layoutXDD = set:getLinearLayoutNode("detailLayer_layoutXDD")
    self._detailLayer_layoutXDD_k = set:getLabelNode("detailLayer_layoutXDD_k")
    self._detailLayer_layoutXDD_v = set:getLabelNode("detailLayer_layoutXDD_v")
    self._detailLayer_btnStartDice = set:getButtonNode("detailLayer_btnStartDice")
    self._detailLayer_btnStartDice_tip = set:getLabelNode("detailLayer_btnStartDice_tip")
    self._detailLayer_btnStartDice_text = set:getLabelNode("detailLayer_btnStartDice_text")
    self._topLayer = set:getElfNode("topLayer")
    self._topLayer_btn = set:getClickNode("topLayer_btn")
    self._topLayer_btnExit = set:getClickNode("topLayer_btnExit")
    self._topLayer_btnReset = set:getClickNode("topLayer_btnReset")
    self._actHeartbeat = set:getElfAction("actHeartbeat")
--    self._@_bg1 = set:getLinearLayoutNode("@_bg1")
--    self._@_bg2 = set:getLinearLayoutNode("@_bg2")
--    self._@_bg3 = set:getLinearLayoutNode("@_bg3")
--    self._@_bg4 = set:getLinearLayoutNode("@_bg4")
--    self._@_bg5 = set:getLinearLayoutNode("@_bg5")
--    self._@_bg6 = set:getLinearLayoutNode("@_bg6")
--    self._@_bg7 = set:getLinearLayoutNode("@_bg7")
--    self._@_bg8 = set:getLinearLayoutNode("@_bg8")
--    self._@_bg9 = set:getLinearLayoutNode("@_bg9")
--    self._@floorlayouty = set:getLayoutNode("@floorlayouty")
--    self._@floor = set:getElfNode("@floor")
--    self._@layouty = set:getLayoutNode("@layouty")
--    self._@item = set:getElfNode("@item")
--    self._@elem0 = set:getElfNode("@elem0")
--    self._@elem1 = set:getElfNode("@elem1")
--    self._@elem2 = set:getElfNode("@elem2")
--    self._@elem3 = set:getElfNode("@elem3")
--    self._@elem4 = set:getElfNode("@elem4")
--    self._@elem5 = set:getElfNode("@elem5")
--    self._@decoverAnime = set:getSimpleAnimateNode("@decoverAnime")
--    self._@elem6 = set:getElfNode("@elem6")
--    self._@elem7 = set:getElfNode("@elem7")
--    self._@elem8 = set:getSimpleAnimateNode("@elem8")
--    self._@elem9 = set:getElfNode("@elem9")
--    self._@elem10 = set:getElfNode("@elem10")
--    self._@elem11 = set:getElfNode("@elem11")
--    self._@elem12 = set:getElfNode("@elem12")
--    self._@appearAnime = set:getSimpleAnimateNode("@appearAnime")
--    self._@_frame1 = set:getLinearLayoutNode("@_frame1")
--    self._@_frame2 = set:getLinearLayoutNode("@_frame2")
--    self._@_frame3 = set:getLinearLayoutNode("@_frame3")
--    self._@_frame4 = set:getLinearLayoutNode("@_frame4")
--    self._@_frame5 = set:getLinearLayoutNode("@_frame5")
--    self._@_frame6 = set:getLinearLayoutNode("@_frame6")
--    self._@_frame7 = set:getLinearLayoutNode("@_frame7")
--    self._@_frame8 = set:getLinearLayoutNode("@_frame8")
--    self._@_frame9 = set:getLinearLayoutNode("@_frame9")
--    self._@clk = set:getShieldNode("@clk")
--    self._@clkLight = set:getRectangleNode("@clkLight")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register('CDungeonRemains',function ( userData )
   Launcher.callNet(netModel.getModelRemainGet(), function ( data )
   	print("getModelRemainGet")
   	print(data)
   	Launcher.Launching(data)   
 	end)
end)

function CDungeonRemains:onInit( userData, netData )
	if netData and netData.D then
		self:updateRemainsData(netData.D.Remain)
	end

	self:setListenerEvent()
	self:broadcastEvent()
	self:initRandomTreeMap() 
	self:initBackgroundFrame()
	self:initFloorLayer()
	self:initCellNodeSet()
	self:updateLayer()
	musicHelper.playBackgroundMusic(res.Music.dungeon, true)	

	require "LangAdapter".LabelNodeAutoShrink(self._detailLayer_Magnifier_text, 75)
	require "LangAdapter".LabelNodeAutoShrink(self._set:getLabelNode("topLayer_btnReset_#text"), 135)
end

function CDungeonRemains:onBack( userData, netData )
	musicHelper.playBackgroundMusic(res.Music.dungeon, true)
end

function CDungeonRemains:onRelease(  )
	EventCenter.resetGroup("CDungeonRemains")
end

--------------------------------custom code-----------------------------

function CDungeonRemains:broadcastEvent( ... )
	EventCenter.addEventFunc("OnBattleCompleted", function ( data )
		print("战斗结算")
		print(data)
		if data and data.mode == "RemainsFuben" and data.isWin then
			gameFunc.updateResource(data.userData.D.Resource)
			self:updateRemainsData(data.userData.D.Remain)
			self:updateLayer()
		end
	end, "CDungeonRemains")
end

function CDungeonRemains:initFloorLayer( ... )
	self.floorSetList = {}
	self._bg_floorlayoutx:removeAllChildrenWithCleanup(true)
	for i=1,wGridCount do
		local floorLayoutySet = self:createLuaSet("@floorlayouty")
		self._bg_floorlayoutx:addChild(floorLayoutySet[1])
		for j=1,hGridCount do
			local floor = self:createLuaSet("@floor")
			floorLayoutySet[1]:addChild(floor[1])
			table.insert(self.floorSetList, floor)
			floor[1]:setResid(self:getDungeonFloorPic(self.Terrain, self.earthMap[(i - 1) * hGridCount + j]))
		end
	end	
end

function CDungeonRemains:initCellNodeSet( ... )
	self.itemSetList = {}
	self._bg_layoutx:removeAllChildrenWithCleanup(true)
	for i=1,wGridCount do
		local layoutySet = self:createLuaSet("@layouty")
		self._bg_layoutx:addChild(layoutySet[1])
		for j=1,hGridCount do
			local item = self:createLuaSet("@item")
			layoutySet[1]:addChild(item[1])
			table.insert(self.itemSetList, item)
			item["btn"]:setTriggleSound("")
			item["btn"]:setListener(function (  )
				local index = (i - 1) * hGridCount + j
				local status = self.ElementList[index].State
				if status == 1 and not self:isTreeEnable(index) then
					return
				end
				self:playElementEffect( self.ElementList[index] )
				if status == 1 then
					if self.Remains.Steps <= 0 then
						self._topLayer:setVisible(true)
						return
					end

					local function openGrid( ... )
						item["decoverAnime"]:setLoops(1)
						item["decoverAnime"]:start()

						-- self:updateGridsStatusTogetherWith(index)
						local updateCellList = self:getIndexListTogetherWith(index)
						table.insert(updateCellList, index)
						for k,v in pairs(updateCellList) do
							self:updateCellNode(v, self.ElementList[v])
						end

						-- 木桶、宝箱、怪物...有入场动画1
						local animList = {1, 2, 6, 9}
						local typeIsInAnimList = function ( list, elemType )
							for k,v in pairs(list) do
								if v == elemType then
									return true
								end
							end
							return false
						end

						local actionKey = 0
						if self.ElementList[index].Type == 4 then 		-- 剑有入场动画2
							actionKey = 2
						elseif self.ElementList[index].Type == 5 then 	-- 炸弹有入场动画3
							actionKey = 3
						elseif typeIsInAnimList(animList, self.ElementList[index].Type) then
							actionKey = 1
						end
						if actionKey == 1 or actionKey == 3 then
							self:playEffectInternal(res.Sound.dg_monster)

							item["tree"]:setVisible(false)
							self.elemSetList[index]["icon"]:setVisible(false)

							local appearAnime = self:createLuaSet("@appearAnime")
							self.elemSetList[index][1]:addChild(appearAnime[1])
							appearAnime[1]:setPosition(ccp(0,0))
							appearAnime[1]:setOrder(self.elemSetList[index]["icon"]:getOrder() - 1)
							appearAnime[1]:setLoops(largeNum)
							appearAnime[1]:setVisible(false)
							appearAnime[1]:setListener(function (  )
								appearAnime[1]:removeFromParentAndCleanup(true)
							end)
							appearAnime[1]:setFrameDelay(0.07)
							local actArray = CCArray:create()
							actArray:addObject(CCHide:create())
							actArray:addObject(CCFadeTo:create(0, 0))
							actArray:addObject(CCScaleTo:create(0, 1.5))
							actArray:addObject(CCShow:create())
							actArray:addObject(CCFadeIn:create(0.5))
							actArray:addObject(CCScaleTo:create(0, 1))

							if actionKey == 3 then
								self.elemSetList[index]["icon"]:setResid("FB_DXC_zhadan.png")
								actArray:addObject(CCCallFunc:create(function (  )
									local actBoomArray = CCArray:create()
									actBoomArray:addObject(CCScaleTo:create(0.4, 1.3))
									actBoomArray:addObject(CCCallFunc:create(function ( ... )
										local decoverAnime = self:createLuaSet("@decoverAnime")
										self.elemSetList[index][1]:addChild(decoverAnime[1])
										decoverAnime[1]:setPosition(ccp(0,0))
										decoverAnime[1]:setOrder(self.elemSetList[index]["icon"]:getOrder() + 1)
										decoverAnime[1]:setListener(function (  )
											decoverAnime[1]:removeFromParentAndCleanup(true)
											self:toast(dbManager.getInfoDefaultConfig("RemainBoom").Value)
											self:updateLayer()
										end)
										decoverAnime[1]:setLoops(1)
										decoverAnime[1]:start()
										self.elemSetList[index]["icon"]:setScale(1)
										self.elemSetList[index]["icon"]:setResid("FB_DXC_zhadansuipian.png")
									end))
									self.elemSetList[index]["icon"]:runAction(CCSequence:create(actBoomArray))
								end))
							elseif actionKey == 1 then
								actArray:addObject(CCCallFunc:create(function ( ... )
									self:updateLayer()
								end))
							end
							self.elemSetList[index]["icon"]:runAction(CCSequence:create(actArray))
							appearAnime[1]:setLoops(1)
							appearAnime[1]:start()
						elseif actionKey == 2 then
							local duration = 0.07
							local deltaAngle = 30
							local actArray = CCArray:create()
							actArray:addObject(CCHide:create())
							actArray:addObject(CCDelayTime:create(0.5))
							actArray:addObject(CCMoveBy:create(0, ccp(0, 5)))
							actArray:addObject(CCShow:create())
							actArray:addObject(CCMoveBy:create(duration, ccp(0, -5)))
							actArray:addObject(CCRotateBy:create(duration, deltaAngle))
							actArray:addObject(CCRotateBy:create(duration, -deltaAngle * 2))
							actArray:addObject(CCRotateBy:create(duration, deltaAngle * 2))
							actArray:addObject(CCRotateBy:create(duration, -deltaAngle * 2))
							actArray:addObject(CCRotateBy:create(duration, deltaAngle))
							actArray:addObject(CCCallFunc:create(function ( ... )
								self:updateLayer()
							end))
							self.elemSetList[index][1]:runAction(CCSequence:create(actArray))
						else
							self:updateLayer()
						end

						if self.ElementList[index].Type == 3 then
							self:playEffectInternal(res.Sound.dg_heart)
						elseif self.ElementList[index].Type == 4 then
							self:playEffectInternal(res.Sound.dg_sword)
						end
						
						-- self.Remains.Steps = math.max(self.Remains.Steps - 1, 0)
						-- self._detailLayer_layoutXDD_v:setString(self.Remains.Steps)
					end

					self:send(netModel.getModelRemainUncover(index), function ( data )
						if data and data.D then
							self:updateRemainsData(data.D.Remain)
							openGrid()
						end
					end)
				elseif status == 2 then
					self:elementEvent(index)
				elseif status == 3 then
					if self.ElementList[index].Type == 4 then
						self:toast(string.format(res.locString("Remains$BuffAtk"), dbManager.getInfoDefaultConfig("RemainAtk").Value * 100))
					elseif self.ElementList[index].Type == 3 then
						self:toast(string.format(res.locString("Remains$BuffHp"), dbManager.getInfoDefaultConfig("RemainHpRecover").Value * 100, dbManager.getInfoDefaultConfig("RemainHp").Value * 100))
					end
				end
			end)
		end
		layoutySet[1]:layout()
	end
end

function CDungeonRemains:updateLayer( ... )
	self:updateCellNodeSet()
	self:updateDetailLayer()
	self._dungeonFrame_titleBg_title:setString(string.format(res.locString("Remains$FloorTitle"), self.Remains.Lv))

	if self.Remains.Steps == -1 then
		self._topLayer:setVisible(false)
	end
	self:updateMaskLayer()
end

function CDungeonRemains:updateMaskLayer( ... )
	self._mask:setVisible(self.isMagnifierUsing or false)
	if self.isMagnifierUsing then
		self._mask:removeAllChildrenWithCleanup(true)
		local clk = self:createLuaSet("@clk")
		self._mask:addChild(clk[1])

		local orderNoList = {}
		for i,v in ipairs(self.ElementList) do
			if v.State == 1 and not self:isMagnifier(i) then
				table.insert(orderNoList, i)
			end
		end
		for _,index in ipairs(orderNoList) do
			local clkLight = self:createLuaSet("@clkLight")
			clk["begin"]:addChild(clkLight[1])
			local point = NodeHelper:getPositionInScreen(self.floorSetList[index][1])
			point.y = point.y + 8
			NodeHelper:setPositionInScreen(clkLight[1], point)
			clkLight["btn"]:setListener(function ( ... )
			--	self:playElementEffect( self.ElementList[index] )
				self:send(netModel.getModelRemainUseGlass(index), function ( data )
					if data and data.D then
						self.isMagnifierUsing = false
						self:updateRemainsData(data.D.Remain)
						self:updateLayer()
						self:toast(res.locString("Remains$MagnifierUseSucc"))
					end
				end)
			end)
		end
	end
end

function CDungeonRemains:initRandomTreeMap(  )
	local Utils = require 'framework.helper.Utils'
	local floor = self.Remains.Lv
	local dateString = "Floor" .. floor
	local map = Utils.readTableFromFile('DungeonRemainsRandMap' .. dateString)
	if map and map.Floor == floor and self.Remains.Steps > 0 then

	else
		map = {}
		map.Floor = floor
		map.treeMap = {}
		map.earthMap = {}
		for i=1,wGridCount * hGridCount do
			table.insert(map.treeMap, math.random(100))
			table.insert(map.earthMap, math.random(100))
		end
		Utils.writeTableToFile(map, 'DungeonRemainsRandMap' .. dateString)
	end
	self.treeMap = map.treeMap
	self.earthMap = map.earthMap
end

function CDungeonRemains:initBackgroundFrame( ... )
	self._dungeonBg:removeAllChildrenWithCleanup(true)
	local bg = self:createLuaSet(string.format("@_bg%d", self.Terrain))
	self._dungeonBg:addChild(bg[1])

	self._dungeonFrame_pic:removeAllChildrenWithCleanup(true)
	local frame = self:createLuaSet(string.format("@_frame%d", self.Terrain))
	self._dungeonFrame_pic:addChild(frame[1])
end

function CDungeonRemains:updateCellNodeSet(  )
	for i,v in ipairs(self.ElementList) do
		if i <= #self.itemSetList then
			self:updateCellNode(i, v)
		end
	end
end

function CDungeonRemains:updateCellNode( index, data )
	local nodeSet = self.itemSetList[index]
	local status = data.State
	nodeSet["tree"]:setVisible(status == 1)
	nodeSet["shadow"]:setVisible(status == 1)
	if status == 1 then
		nodeSet["tree"]:setResid(self:getDungeonTreePic(self.Terrain, self.treeMap[index]))
		if self.isMagnifierUsing and not self:isMagnifier(index) then
			nodeSet["tree"]:setColorf(1, 1, 1, 1)
			self.floorSetList[index][1]:setColorf(1, 1, 1, 1)
		else
			if self:isTreeEnable(index) then
				nodeSet["tree"]:setColorf(1, 1, 1, 1)
				self.floorSetList[index][1]:setColorf(1, 1, 1, 1)
			else
				nodeSet["tree"]:setColorf(0.6, 0.6, 0.6, 1)
				self.floorSetList[index][1]:setColorf(0.6, 0.6, 0.6, 1)
			end	
		end
		if self:isMagnifier(index) then
			nodeSet["tree"]:setOpacity(128)
		else
			nodeSet["tree"]:setOpacity(255)
		end
	else
		self.floorSetList[index][1]:setColorf(1, 1, 1, 1)
	end
	self:updateLucky(index, data)
end

function CDungeonRemains:updateLucky( index, data )
	local nodeSet = self.itemSetList[index]
	nodeSet["lucky"]:removeAllChildrenWithCleanup(true)
	local elemSet = self:createLuaSet(string.format("@elem%d", data.Type))
	nodeSet["lucky"]:addChild(elemSet[1])
	elemSet[1]:setPosition(ccp(0, 0))
	self.elemSetList = self.elemSetList or {}
	self.elemSetList[index] = elemSet
	local isOpacity = data.State == 1 and self:isMagnifier(index)
	if data.Type == 0 then

	elseif data.Type == 1 or data.Type == 2 then
		elemSet[1]:setVisible(data.State == 2 or isOpacity)
		if elemSet[1]:isVisible() then
			local dbRemainPet = dbManager.getInfoRemainNpcConfigLeader(data.Value)
			local PetId = dbRemainPet.petid
			local monsterNode = self:getNpcUIModel(PetId)
			elemSet["icon"]:addChild(monsterNode)
			monsterNode:setOrder(elemSet["icon_shadow"]:getOrder() + 10)
			
			elemSet["icon_monsterFlag"]:setVisible(data.Type == 2)
			elemSet["icon_monsterFlag"]:setOrder(elemSet["icon_shadow"]:getOrder() + 20)

			local dbPet = dbManager.getCharactor(PetId)
			elemSet["icon_nameBg_name"]:setString(dbPet.name)
			elemSet["icon_nameBg"]:setOrder(elemSet["icon_shadow"]:getOrder() + 30)
		end
	elseif data.Type == 3 then
		elemSet[1]:setVisible(data.State ~= 1 or isOpacity)
		elemSet["icon"]:stopAllActions()
		elemSet["icon2"]:setVisible(data.State == 3)
		if elemSet[1]:isVisible() then
			elemSet["icon"]:runAction(self._actHeartbeat:clone())
			if data.State == 3 then
				elemSet["effect1"]:stop()
				elemSet["effect2"]:start()
			end
		end
	elseif data.Type == 4 then
		elemSet[1]:setVisible(data.State ~= 1 or isOpacity)
		elemSet["icon2"]:setVisible(data.State == 3)
		if elemSet[1]:isVisible() then
			if data.State == 3 then
				elemSet["icon"]:setResid("FB_DXC_jian2.png")
				elemSet["icon"]:setVisible(true)
				elemSet["effect"]:clearResidArray()
				for i=1,55, 2 do
					elemSet["effect"]:addResidToArray(string.format("lanxian_%05d.png", i))
				end
				elemSet["effect"]:start()
			else
				elemSet["icon"]:setResid("FB_DXC_jian.png")
				elemSet["icon"]:setVisible(true)
				elemSet["effect"]:clearResidArray()
				for i=1,55,2 do
					elemSet["effect"]:addResidToArray(string.format("hongxian_%05d.png", i))
				end
				elemSet["effect"]:start()
			end
		end
	elseif data.Type == 5 then
		elemSet[1]:setVisible(data.State ~= 1 or isOpacity)
		if elemSet[1]:isVisible() then
			if data.State == 3 then
				elemSet["icon"]:setResid("FB_DXC_zhadansuipian.png")
			else
				elemSet["icon"]:setResid("FB_DXC_zhadan.png")
			end
		end
	elseif data.Type == 6 then
		elemSet[1]:setVisible(data.State ~= 1 or isOpacity)
		if elemSet[1]:isVisible() then
			if data.State == 3 then
				elemSet["icon"]:setResid("FB_DXC_baoxiang.png")
				elemSet["effect1"]:stop()
				elemSet["effect2"]:stop()
			else
				elemSet["icon"]:setResid("FB_DXC_baoxiang2.png")
				elemSet["effect1"]:start()
				elemSet["effect2"]:stop()
			end
		end
	elseif data.Type == 7 or data.Type == 8 or data.Type == 10 or data.Type == 11 or data.Type == 12 then
		elemSet[1]:setVisible(data.State == 2 or isOpacity)
	elseif data.Type == 9 then
		elemSet[1]:setVisible(data.State ~= 1 or isOpacity)
		if elemSet[1]:isVisible() then
			if data.State == 3 then
				elemSet["icon"]:setResid("FB_DXC_poguanzi.png")
			else
				elemSet["icon"]:setResid("FB_DXC_guanzi.png")
			end
		end
		elemSet["effect1"]:stop()
		elemSet["effect2"]:stop()
	end
end

function CDungeonRemains:elementEvent( index )
	local nElement = self.ElementList[index]
	if nElement.Type == 0 then
		-- nothing
	elseif nElement.Type == 1 or nElement.Type == 2 then
		local teamActive = gameFunc.getTeamInfo().getTeamActive()
		local teamCount = #teamActive.PetIdList
		if teamActive.BenchPetId > 0 then
			teamCount = teamCount + 1
		end
		local allDead = true
		for i,v in ipairs(self.Remains.HpLefts) do
			if i <= teamCount and v > 0 then
				allDead = false
				break
			end
		end

		if allDead then
			self:toast(res.locString("Remains$AllPetsDead"))
		else
			local param = {}
			param.type = "RemainsFuben"
			param.emenyPetList = dbManager.getInfoRemainNpcConfig(nElement.Value)
			param.terrian = self.Terrain
			local RemainsFubenData = {}
			RemainsFubenData.index = index
			RemainsFubenData.HpLefts = self.Remains.HpLefts
			RemainsFubenData.Atks = self.Remains.Atks
			RemainsFubenData.Hps = self.Remains.Hps
			param.RemainsFubenData = RemainsFubenData
			GleeCore:showLayer("DPrepareForStageBattle", param)	
		end
	elseif nElement.Type == 3 then
		self.elemSetList[index]["effect1"]:setLoops(1)
		self.elemSetList[index]["effect1"]:start()
		self.elemSetList[index]["effect1"]:setListener(function (  )
			self:remainsOperatorEvent(index)
		end)
	elseif nElement.Type == 6 then
		if self.Remains.Keys > 0 then
			self:remainsOperatorEvent(index)
		else
			self:toast(res.locString("Remains$BoxKeyNotEnough"))
		end
	elseif nElement.Type == 10 then
		if self:showFinishTip() then
			local param = {}
			param.content = res.locString("Remains$FinishTip")
			param.callback = function ( ... )
				self:remainsOperatorEvent(index)
			end
			GleeCore:showLayer("DConfirmNT", param)
		else
			self:remainsOperatorEvent(index)
		end
	elseif nElement.Type == 11 then
		self.elemSetList[index][1]:setResid("FB_DXC_louti_open.jpg")
		GleeCore:popController(nil, res.getTransitionFade())
		self:runWithDelay(function ( ... )
			GleeCore:showLayer("DRemains")
		end, 0.5)
	else
		self:remainsOperatorEvent(index)
	end
end

function CDungeonRemains:showFinishTip( ... )
	local klist = {6, 9}
	for i,nElement in ipairs(self.ElementList) do
		if table.find(klist, nElement.Type) and nElement.State == 2 then
			return true
		end
	end
	return false
end

function CDungeonRemains:remainsOperatorEvent( index )
	self:send(netModel.getModelRemainOp(index, self.Remains.HpLefts), function ( data )
		if data and data.D then
			if data.D.Resource then
				gameFunc.updateResource(data.D.Resource)
			end
			if data.D.Remain then
				self:updateRemainsData(data.D.Remain)
				self:updateLayer()
			end

			local nElement = self.ElementList[index]
			if nElement.State == 2 then
				if nElement.Type == 6 then 
					self.elemSetList[index]["effect2"]:setLoops(1)
					self.elemSetList[index]["effect2"]:start()
					self:playEffectInternal(res.Sound.dg_chest)
				elseif nElement.Type == 9 then
					self.elemSetList[index]["effect1"]:setLoops(1)
					self.elemSetList[index]["effect1"]:start()
					self.elemSetList[index]["effect2"]:setLoops(1)
					self.elemSetList[index]["effect2"]:start()
					self:playEffectInternal(res.Sound.dg_pot)
				end
			elseif nElement.State == 3 then
				if self.ElementList[index].Type == 4 then
					self:toast(string.format(res.locString("Remains$BuffAtk"), dbManager.getInfoDefaultConfig("RemainAtk").Value * 100))
				elseif self.ElementList[index].Type == 3 then
					self:toast(string.format(res.locString("Remains$BuffHp"), dbManager.getInfoDefaultConfig("RemainHpRecover").Value * 100, dbManager.getInfoDefaultConfig("RemainHp").Value * 100))
				elseif self.ElementList[index].Type == 7 then
					GleeCore:showLayer("DGetReward", {RemainKey = 1})
				elseif self.ElementList[index].Type == 12 then
					res.doActionGetReward({RemainGlass = 1})
				end
			end
			if data.D.Reward then
				GleeCore:showLayer("DGetReward", data.D.Reward)
			end
		end
	end)
end

function CDungeonRemains:isTreeEnable( index )
	local enable = false
	local list = self:getIndexListTogetherWith(index)
	for i,v in ipairs(list) do
		if self.ElementList[v].State > 1 then
			enable = true
			break
		end
	end
	return enable
end

function CDungeonRemains:updateRemainsData( data )
	self.Remains = data
	self.Terrain = self.Remains.T

	self.ElementList = self.ElementList or {}
	for k,v in pairs(data.Cells) do
		local canFind = false
		for key,value in pairs(self.ElementList) do
			if value.Id == v.Id then
				self.ElementList[key] = v
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(self.ElementList, v)
		end
	end
	table.sort(self.ElementList, function ( a, b )
		if a.Id < b.Id then
			return true
		end
	end)
end

function CDungeonRemains:updateGridsStatusTogetherWith( index )
 	if self.ElementList[index].Type == 0 then
 		self.ElementList[index].State = 3
 	else
 		self.ElementList[index].State = 2
 	end
end

function CDungeonRemains:updateDetailLayer( ... )
	self._detailLayer_atk_count:setString(self.Remains.Atks > 0 and string.format("+%g%%", self.Remains.Atks * 100) or "0")
	self._detailLayer_key_count:setString(self.Remains.Keys)
	self._detailLayer_hp_count:setString(self.Remains.Hps > 0 and string.format("+%g%%", self.Remains.Hps * 100) or "0")
	self._detailLayer_layoutXDD_v:setString(self.Remains.Steps < 0 and 10 or self.Remains.Steps)
	self._detailLayer_layoutXDD:layout()
	res.adjustNodeWidth(self._detailLayer_layoutXDD, 180)
	
	if self.Remains.Steps == -1 then
		self._detailLayer_btnStartDice:setVisible(true)
		self._detailLayer_btnStartDice_text:stopAllActions()
		self._detailLayer_btnStartDice_text:runAction(res.getFadeAction(1))
		self._detailLayer_SADice1:setVisible(true)
		self._detailLayer_SADice2:setVisible(true)
		self._detailLayer_SADice1:setResid("YJ_touzi1.png")
		self._detailLayer_SADice2:setResid("YJ_touzi1.png")
		self._detailLayer_SADice1:setScale(1)
		self._detailLayer_SADice2:setScale(1)
		self._detailLayer_dice1:setVisible(false)
		self._detailLayer_dice2:setVisible(false)
	else
		self._detailLayer_btnStartDice:setVisible(false)
		self._detailLayer_btnStartDice_text:stopAllActions()
		self._detailLayer_SADice1:setVisible(false)
		self._detailLayer_SADice2:setVisible(false)
		self._detailLayer_dice1:setResid(string.format("YJ_touzi%d.png", self.Remains.P1))
		self._detailLayer_dice2:setResid(string.format("YJ_touzi%d.png", self.Remains.P2))
		self._detailLayer_dice1:setVisible(true)
		self._detailLayer_dice2:setVisible(true)
	end

	self._detailLayer_Magnifier:setVisible(self.Remains.Steps ~= -1 and not self.isMagnifierUsing)
	self._detailLayer_Magnifier_count:setString(self.Remains.Glasses)
	self._detailLayer_Magnifier_count:setFontFillColor(self.Remains.Glasses == 0 and res.color4F.red or res.color4F.white, true)
end

function CDungeonRemains:setListenerEvent( ... )
	self._topLayer_btnReset:setListener(function ( ... )
		local function resetRemains( ... )
			self:send(netModel.getModelRemainReset(), function ( data )
				if data and data.D then
					gameFunc.getUserInfo().setData(data.D.Role)
					self:updateRemainsData(data.D.Remain)

					self:initRandomTreeMap() 
					self:initBackgroundFrame()
					self:initFloorLayer()
					self:updateLayer()
				end
			end)
		end
		if self.Remains.Times == 0 then
			if gameFunc.getUserInfo().getVipLevel() < 8 then
				self:toast(res.locString("Remains$TimesNone"))
				return
			end
			if self.Remains.TimesBuy == 0 and gameFunc.getUserInfo().getVipLevel() >= 8 then
				local cost = dbManager.getInfoDefaultConfig("RemainReset").Value
				local param = {}
				param.content = string.format(res.locString("Remains$ResetTip"), cost)
				param.callback = function ( ... )
					if gameFunc.getUserInfo().getCoin() >= cost then
						resetRemains()
					else
						require "Toolkit".showDialogOnCoinNotEnough()
					end
				end
				GleeCore:showLayer("DConfirmNT", param)
				return
			end
			if self.Remains.TimesBuy > 0 then
				self:toast(res.locString("Remains$TimesBuyNone"))
				return
			end
		end
		resetRemains()
	end)

	self._topLayer_btnExit:setListener(function ( ... )
		GleeCore:popController(nil, res.getTransitionFade())
	end)

	self._detailLayer_btnStartDice:setListener(function ( ... )
		local function DiceAnimation( index, point, callback )
			self[string.format("_detailLayer_SADice%d", index)]:clearResidArray()
			self[string.format("_detailLayer_SADice%d", index)]:addResidToArray("YJ_touzi1.png")
			for i=1,8 do
				local p = math.random(6)
				self[string.format("_detailLayer_SADice%d", index)]:addResidToArray(string.format("YJ_touzi%d.png", p))
			end
			self[string.format("_detailLayer_SADice%d", index)]:addResidToArray(string.format("YJ_touzi%d.png", point))
			self[string.format("_detailLayer_SADice%d", index)]:setFrameDelay(0.2)
			self[string.format("_detailLayer_SADice%d", index)]:setListener(function ( ... )
				self[string.format("_detailLayer_SADice%d", index)]:setVisible(true)
				self[string.format("_detailLayer_SADice%d", index)]:setResid(string.format("YJ_touzi%d.png", point))
				local ox, oy = self[string.format("_detailLayer_SADice%d", index)]:getPosition()
				local x, y = self[string.format("_detailLayer_dice%d", index)]:getPosition()
				local actArray = CCArray:create()
				local spawnArray = CCArray:create()
				spawnArray:addObject(CCMoveTo:create(0.5, ccp(x, y)))
				spawnArray:addObject(CCScaleTo:create(0.5, 0.4))
				actArray:addObject(CCSpawn:create(spawnArray))
				actArray:addObject(CCCallFunc:create(function ( ... )
					self[string.format("_detailLayer_SADice%d", index)]:setPosition(ccp(ox, oy))
					self[string.format("_detailLayer_dice%d", index)]:setResid(string.format("YJ_touzi%d.png", point))
					self[string.format("_detailLayer_dice%d", index)]:setVisible(true)
					if callback then
						callback()
					end
				end))
				self[string.format("_detailLayer_SADice%d", index)]:runAction(CCSequence:create(actArray))
			end)
			self[string.format("_detailLayer_SADice%d", index)]:setLoops(1)
			self[string.format("_detailLayer_SADice%d", index)]:start()
		end

		self:send(netModel.getModelRemainRp(), function ( data )
			if data and data.D then
				print("RemainRp")
				print(data)
				self:updateRemainsData(data.D.Remain)
		
				self._detailLayer_btnStartDice:setVisible(false)
				self._detailLayer_btnStartDice_text:stopAllActions()
				res.setTouchDispatchEvents(false)
				DiceAnimation(1, self.Remains.P1)
				DiceAnimation(2, self.Remains.P2, function ( ... )
					self:updateLayer()
					res.setTouchDispatchEvents(true)
				end)
			end
		end)
	end)

	self._topLayer_btn:setListener(function ( ... )
		self._topLayer:setVisible(false)
	end)

	self._detailLayer_Magnifier_btn:setListener(function ( ... )
		if self.Remains.Steps == 0 then
			self:toast(res.locString("Remains$xingdongdianNone"))
			return
		end
		if not self:isTreeNotMagnifierExist() then
			self:toast(res.locString("Remains$MagnifierUseFailTip1"))
			return
		end

		if self.Remains.Glasses > 0 then
			local param = {}
			param.content = res.locString("Remains$MagnifierUseTip")
			param.callback = function ( ... )
				self.isMagnifierUsing = true
				self:updateLayer()
			end
			GleeCore:showLayer("DConfirmNT", param)
		else
			local priceBase = dbManager.getInfoDefaultConfig("GlassCost").Value
			local priceAdd = dbManager.getInfoDefaultConfig("GlassAddCost").Value
			local cost = priceBase + self.Remains.GlassBuy * priceAdd
			local param = {}
			param.content = string.format(res.locString("Remains$MagnifierBuyTip"), cost)
			param.callback = function ( ... )
				if gameFunc.getUserInfo().getCoin() >= cost then
					self:send(netModel.getModelRemainBuyGlass(), function ( data )
						if data and data.D then
							gameFunc.getUserInfo().setData(data.D.Role)
							self:updateRemainsData(data.D.Remain)
							self:updateLayer()
						end
					end)
				else
					require "Toolkit".showDialogOnCoinNotEnough()
				end
			end
			GleeCore:showLayer("DConfirmNT", param)
		end
	end)
end

function CDungeonRemains:getIndexListTogetherWith( index )
	local temp = {}
	index = index - 1
	local y1 = index % hGridCount
	local x1 = math.floor(index / hGridCount)
	for i=0,wGridCount * hGridCount - 1 do
		local y2 = i % hGridCount
		local x2 = math.floor(i / hGridCount)
		if math.abs(x2 - x1) <= 1 and math.abs(y2 - y1) <= 1 and (x2 - x1) * (y2 - y1) == 0 then
			if x2 == x1 and y2 == y1 then
				-- nothing
			else
				table.insert(temp, i + 1)
			end
		end
	end
	return temp
end

function CDungeonRemains:getNpcUIModel( petId )
	local monsterNode = require "ActionView".createActionViewById(petId):getRootNode()
	monsterNode:setVisible(true)
	monsterNode:setScale(0.5)
	monsterNode:setPosition(ccp(0, -30))
	monsterNode:setTransitionMills(0)
	monsterNode:play("待机")
	monsterNode:setBatchDraw(true)
	return monsterNode
end

function CDungeonRemains:getDungeonTreePic( terrian, randValue ) 
	randValue = randValue * girdCount / 100
	local terrianList = {
		[1] = {"FB_caodi_cao1.png", "FB_caodi_cao2.png", "FB_caodi_cao3.png"},
		[2] = {"FB_xuedi_jixue1.png", "FB_xuedi_jixue2.png", "FB_xuedi_jixue3.png", "FB_xuedi_jixue4.png"},
		[3] = {"FB_huangmo_shadi2.png", "FB_huangmo_shadi3.png", "FB_huangmo_shadi1.png"},
		[4] = {"FB_chengshi_lumian4.png", "FB_chengshi_lumian1.png", "FB_chengshi_lumian2.png", "FB_chengshi_lumian3.png", "FB_chengshi_lumian5.png"},
		[5] = {"FB_haiyang_haishui1.png", "FB_haiyang_haishui2.png", "FB_haiyang_haishui3.png"},
		[6] = {"FB_huoshan_yanshi3.png", "FB_huoshan_yanshi1.png", "FB_huoshan_yanshi2.png"},
		[7] = {"FB_DXC_shu1.png", "FB_DXC_shu2.png", "FB_DXC_shu3.png"},
		[8] = {"FB_shanmai_shanti1.png", "FB_shanmai_shanti2.png", "FB_shanmai_shanti3.png"},
		[9] = {"FB_shidi_caodi1.png", "FB_shidi_caodi2.png", "FB_shidi_shui1.png", "FB_shidi_shui2.png", "FB_shidi_shui3.png"}
	}
	local randList = {
		[1] = {7, 10, 23},
		[2] = {4, 24, 6, 6},
		[3] = {7, 5, 28},
		[4] = {15, 10, 7, 5, 3},
		[5] = {3, 25, 12},
		[6] = {16, 14, 10},
		[7] = {20, 14, 6},
		[8] = {12, 9, 19},
		[9] = {5, 12, 14, 4, 5},
	}

	local tree = ""
	if terrianList[terrian] then
		local index = self:getIndexWithRand(randList[terrian], randValue)
		if index >= 1 and index <= #terrianList[terrian] then
			tree = terrianList[terrian][index]
		end
	end
	return tree
end

function CDungeonRemains:getDungeonFloorPic( terrian, randValue )
	randValue = randValue * girdCount / 100
	local terrianList = {
		[1] = {"FB_caodi_diban1.png", "FB_caodi_diban2.png", "FB_caodi_diban3.png"},
		[2] = {"FB_xuedi_diban1.png", "FB_xuedi_diban2.png", "FB_xuedi_diban3.png"},
		[3] = {"FB_huangmo_diban1.png", "FB_huangmo_diban2.png", "FB_huangmo_diban3.png"},
		[4] = {"FB_chengshi_diban1.png", "FB_chengshi_diban2.png", "FB_chengshi_diban3.png"},
		[5] = {"FB_haiyang_diban1.png", "FB_haiyang_diban2.png", "FB_haiyang_diban3.png"},
		[6] = {"FB_huoshan_diban1.png", "FB_huoshan_diban2.png", "FB_huoshan_diban3.png"},
		[7] = {"FB_DXC_diban1.png", "FB_DXC_diban2.png"},
		[8] = {"FB_shanmai_diban1.png", "FB_shanmai_diban2.png", "FB_shanmai_diban3.png"},
		[9] = {"FB_shidi_diban3.png", "FB_shidi_diban1.png", "FB_shidi_diban2.png"}
	}
	local randList = {
		[1] = {26, 10, 4},
		[2] = {25, 6, 9},
		[3] = {12, 8, 20},
		[4] = {4, 9, 27},
		[5] = {6, 30, 4},
		[6] = {8, 12, 20},
		[7] = {20, 20},
		[8] = {8, 12, 20},
		[9] = {26, 10, 4},
	}

	local floor = ""
	if terrianList[terrian] then
		local index = self:getIndexWithRand(randList[terrian], randValue)
		if index >= 1 and index <= #terrianList[terrian] then
			floor = terrianList[terrian][index]
		end
	end
	return floor
end

function CDungeonRemains:getIndexWithRand( list, randValue )
 	local index = 0
 	if list then
 		for i,v in ipairs(list) do
 			if i > 1 then
 				list[i] = list[i] + list[i-1]
 			end
 		end

 		for i,v in ipairs(list) do
 			if randValue <= v then
 				index = i
 				break
 			end
 		end
 		if index == 0 then
 			index = #list
 		end
 	end
 	return index
end

function CDungeonRemains:getDungeonTreeSound( index )
	local musicEffect

	local terrian = self.Terrain
	local treeRand = self.treeMap[index]
	if terrian == 1 then
		musicEffect = res.Sound.dg_touch_meadow
	elseif terrian == 2 then
		if treeRand <= 70 then
			musicEffect = res.Sound.dg_touch_snow
		else
			musicEffect = res.Sound.dg_touch_ice
		end
	elseif terrian == 3 then
		musicEffect = res.Sound.dg_touch_sand
	elseif terrian == 4 then
		if treeRand > 80 and treeRand <= 92.5 then
			musicEffect = res.Sound.dg_touch_stone
		else
			musicEffect = res.Sound.dg_touch
		end
	elseif terrian == 5 then
		if treeRand <= 70 then
			musicEffect = res.Sound.dg_touch_water
		else
			musicEffect = res.Sound.dg_touch
		end
	elseif terrian == 6 then
		if treeRand <= 40 then
			musicEffect = res.Sound.dg_touch_lava
		else
			musicEffect = res.Sound.dg_touch
		end
	elseif terrian == 7 then
		musicEffect = res.Sound.dg_touch_forest
	elseif terrian == 8 then
		musicEffect = res.Sound.dg_touch
	elseif terrian == 9 then
		musicEffect = res.Sound.dg_touch_wetland
	end

	if not musicEffect then
		musicEffect = res.Sound.dg_touch
	end
	return musicEffect
end

function CDungeonRemains:playEffectInternal( name )
	musicHelper.playEffect(name)
end

function CDungeonRemains:playElementEffect( nElement )
	local musicEffect
	local elementType = nElement.Type
	if nElement.State == 1 then
		if self:isTreeEnable(nElement.Id) then
			musicEffect = self:getDungeonTreeSound(nElement.Id)
		else
			musicEffect = res.Sound.pick
		end
	elseif nElement.State == 2 then
		if elementType == 4 then
			musicEffect = res.Sound.dg_buff_sword
		elseif elementType == 3 then
			musicEffect = res.Sound.dg_buff_heart
		elseif elementType == 11 then
			musicEffect = res.Sound.dg_touch_open
		end
		if not musicEffect then
			musicEffect = res.Sound.pick
		end
	elseif nElement.State == 3 then
		if elementType == 4 or elementType == 3 then
			musicEffect = res.Sound.pick
		end
	end

	if musicEffect then
		self:playEffectInternal(musicEffect)
	end
end

function CDungeonRemains:isMagnifier( index )
	return self.Remains.Show and table.find(self.Remains.Show, index)
end

function CDungeonRemains:isTreeNotMagnifierExist( ... )
	for i,nElement in ipairs(self.ElementList) do
		if nElement.State == 1 and not self:isMagnifier(i) then
			return true
		end
	end
	return false
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CDungeonRemains, "CDungeonRemains")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CDungeonRemains", CDungeonRemains)


