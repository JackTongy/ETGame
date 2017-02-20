local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local countOneLine = 5

local DGetReward = class(LuaDialog)

function DGetReward:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGetReward.cocos.zip")
    return self._factory:createDocument("DGetReward.cocos")
end

--@@@@[[[[
function DGetReward:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._clickBg_shield = set:getShieldNode("clickBg_shield")
    self._title = set:getLinearLayoutNode("title")
    self._title_elf1 = set:getElfNode("title_elf1")
    self._title_elf2 = set:getElfNode("title_elf2")
    self._title_elf3 = set:getElfNode("title_elf3")
    self._title_elf4 = set:getElfNode("title_elf4")
    self._layout = set:getLayoutNode("layout")
    self._listBase = set:getElfNode("listBase")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
    self._hale = set:getElfNode("hale")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._name = set:getLabelNode("name")
    self._count = set:getLabelNode("count")
    self._piece = set:getElfNode("piece")
--    self._@list = set:getListNode("@list")
--    self._@itemLine = set:getLayoutNode("@itemLine")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
--    self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------

local Launcher = require 'Launcher'
Launcher.register("DGetReward", function ( userData )
	if userData.rewardType ~= "List" and userData.rewardType ~= "TrialFast" then
		local list = res.getRewardResList(userData)
		if list and #list > 0 then
			Launcher.Launching(data)
		end
	else
		Launcher.Launching(data)
	end
end)

function DGetReward:onInit( userData, netData )
	self.rewardNodeSet = {}
	if userData.rewardType == "List" then
		for i,v in ipairs(userData.rewardList) do
			self:updateItemList(v)
		end
	elseif userData.rewardType == "TrialFast" then
		self._title_elf1:setResid("WJSL_BX_SD_wenzi1.png")
		self._title_elf2:setResid("WJSL_BX_SD_wenzi2.png")
		self._title_elf3:setResid("WJSL_BX_SD_wenzi3.png")
		self._title_elf4:setResid("WJSL_BX_SD_wenzi4.png")
		self:updateItemList(userData.reward)
	else
		self:updateItemList(userData)
	end
	
	local LangName = require 'Config'.LangName or ''
	if LangName ~= "thai" and LangName ~= "tra_ch" and LangName ~= "vn" and LangName ~= "kor" and LangName ~= "sim_ch" then
		self._title_elf1:setWidth(10)
		self._title_elf3:setWidth(0)
		self._title_elf4:setWidth(0)
	end

	local itemLine
	self._clickBg_shield:setVisible(false)

	if #self.rewardNodeSet > countOneLine * 2 then
		local list = self:createLuaSet("@list")
		self.list = list[1]
		self._listBase:addChild(list[1])
		for i,v in ipairs(self.rewardNodeSet) do
			if i % countOneLine == 1 then
				itemLine = self:createLuaSet("@itemLine")
				list[1]:getContainer():addChild(itemLine[1])
			end
			itemLine[1]:addChild(v[1])
			v[1]:setVisible(false)
			v["hale"]:setVisible(false)
			v["name"]:setVisible(false)
		end
		list[1]:layout()
	else
		for i,v in ipairs(self.rewardNodeSet) do
			if i % countOneLine == 1 then
				itemLine = self:createLuaSet("@itemLine")
				self._layout:addChild(itemLine[1])
			end
			itemLine[1]:addChild(v[1])
			v[1]:setVisible(false)
			v["hale"]:setVisible(false)
			v["name"]:setVisible(false)
		end
	end
	self._listBase:setVisible(self.list ~= nil)
	self._layout:setVisible(self.list == nil)

	self._clickBg:setListener(function ( ... )
		if self.isClose then
			self:notfiyCallback()
			self:close()
		else
			self.isClose = true
			self._title:stopAllActions()
			self._title:setOpacity(255)
			self._title:setScale(1)
			for i,v in ipairs(self.rewardNodeSet) do
				v[1]:stopAllActions()
				v[1]:setVisible(true)
				v[1]:setScale(1)
				v[1]:setRotation(0)
				v["hale"]:stopAllActions()
				v["hale"]:setVisible(true)
				v["hale"]:runAction(CCRepeatForever:create(CCRotateBy:create(1, -120)))
				v["name"]:stopAllActions()
				v["name"]:setOpacity(255)
				v["name"]:setVisible(true)
			end

	--		self:runWithDelay(function (  )
				if self.list then
					self.list:setNeedLayout()
					self.list:layout()

					local array = self.list:getContainer():getChildren()
					if array then
						for i=0,array:count() - 1 do
							local node = tolua.cast(array:objectAtIndex(i), "LayoutNode")
							node:setNeedLayout()
							node:layout()
						end
					end	

					self._clickBg_shield:setVisible(true)
				else
					self._layout:setNeedLayout()
					self._layout:layout()

					local array = self._layout:getChildren()
					if array then
						for i=0,array:count() - 1 do
							local node = tolua.cast(array:objectAtIndex(i), "LayoutNode")
							node:setNeedLayout()
							node:layout()
						end
					end		
				end
	--		end, 0)
		end
	end)

	self._title:setOpacity(0)
	self._title:setScale(3)

	local actArray = CCArray:create()
	actArray:addObject(CCFadeIn:create(0.2))
	actArray:addObject(CCScaleTo:create(0.2, 1))
	local actArray2 = CCArray:create()
	actArray2:addObject(CCSpawn:create(actArray))
	actArray2:addObject(CCCallFunc:create(function ( ... )
		for i,v in ipairs(self.rewardNodeSet) do
			local x, y = v[1]:getPosition()
			if i > countOneLine * 2 then
				local x1
				x1, y = self.rewardNodeSet[i % countOneLine + countOneLine][1]:getPosition()
			end
			
			v[1]:runAction(self:getItemAction(x, y, 0.1 * (i - 1), i, function ( ... )
				v["hale"]:setVisible(true)
				v["hale"]:runAction(CCRepeatForever:create(CCRotateBy:create(1, 120)))
				v["name"]:runAction(self:getNameAction())
				if i == #self.rewardNodeSet then
					self.isClose = true

					if self.list then
						self._clickBg_shield:setVisible(true)
					end
				end
			end))
		end
	end))
	
	self._title:runAction(CCSequence:create(actArray2))
	require 'framework.helper.MusicHelper'.playEffect(res.Sound.ui_reward)
	require 'GuideHelper':check('DGetReward')
end

function DGetReward:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DGetReward:updateItemList( reward )
	if reward then
		local list = res.getRewardResList(reward)
		if list then
			for i,v in ipairs(list) do
				self:updateItem(v)
			end
		end
	end
end

function DGetReward:updateItem( v )
	local scaleOrigal = 110 / 155
	local item = self:createLuaSet("@item")
	if v.type == "Gem" then
		item["name"]:setString(v.name .. " Lv." .. v.lv)
	else
		item["name"]:setString(v.name)
	end
	
	item["bg"]:setResid(v.bg)
	item["bg"]:setScale(scaleOrigal)
	item["icon"]:setResid(v.icon)
	if v.type == "Pet" or v.type == "PetPiece" then
		item["icon"]:setScale(scaleOrigal * 140 / 95)
	else
		item["icon"]:setScale(scaleOrigal)
	end
	item["frame"]:setResid(v.frame)
	item["frame"]:setScale(scaleOrigal)
	item["count"]:setString(v.count)
	item["piece"]:setVisible(v.isPiece)

	res.addRuneStars( item["frame"], v )

	table.insert(self.rewardNodeSet, item)
end

function DGetReward:getItemAction( x, y, delay, index, func )
	local actArray = CCArray:create()
	actArray:addObject(CCDelayTime:create(delay))
	actArray:addObject(CCScaleTo:create(0, 0))
	actArray:addObject(CCPlace:create(ccp(0, 50)))
	actArray:addObject(CCShow:create())

	local actArray2 = CCArray:create()
	local delta = 0.3
	actArray2:addObject(CCScaleTo:create(delta, 1))
	actArray2:addObject(CCRotateTo:create(delta, 720))
	actArray2:addObject(CCMoveTo:create(delta, ccp(x, y)))

	actArray:addObject(CCSpawn:create(actArray2))
	actArray:addObject(CCCallFunc:create(func))

	if self.list and (index % countOneLine == 0) and index > countOneLine then
		actArray:addObject(CCCallFunc:create(function ( ... )
			self.list:alignTo(index / countOneLine - 1)
		end))
	end
	return CCSequence:create(actArray)
end

function DGetReward:getNameAction( ... )
	local actArray = CCArray:create()
	actArray:addObject(CCFadeTo:create(0, 0))
	actArray:addObject(CCShow:create())
	actArray:addObject(CCFadeIn:create(0.3))
	return CCSequence:create(actArray)
end

function DGetReward:notfiyCallback( ... )
	local userData = self:getUserData()
	if userData and userData.callback then
		userData.callback()
	end	
	require 'GuideHelper':check('AnimtionEnd')
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGetReward, "DGetReward")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGetReward", DGetReward)

return DGetReward
