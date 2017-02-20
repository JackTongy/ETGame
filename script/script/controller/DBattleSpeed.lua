local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()
local petFunc = gameFunc.getPetInfo()

local DBattleSpeed = class(LuaDialog)

function DBattleSpeed:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DBattleSpeed.cocos.zip")
    return self._factory:createDocument("DBattleSpeed.cocos")
end

--@@@@[[[[
function DBattleSpeed:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._btnClick = set:getClickNode("btnClick")
    self._bg = set:getJoint9Node("bg")
    self._bg_list = set:getListNode("bg_list")
    self._text = set:getLabelNode("text")
    self._exp = set:getLabelNode("exp")
    self._gold = set:getLabelNode("gold")
    self._layout = set:getLayoutNode("layout")
    self._icon = set:getElfNode("icon")
    self._lv = set:getLabelNode("lv")
    self._lvUp = set:getLabelNode("lvUp")
    self._layout = set:getLayoutNode("layout")
    self._bg = set:getElfNode("bg")
    self._icon = set:getElfNode("icon")
    self._frame = set:getElfNode("frame")
    self._count = set:getLabelNode("count")
    self._isPiece = set:getElfNode("isPiece")
    self._clip_bg = set:getElfNode("clip_bg")
    self._text = set:getElfNode("text")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
--    self._@title = set:getElfNode("@title")
--    self._@sep1 = set:getElfNode("@sep1")
--    self._@item1 = set:getJoint9Node("@item1")
--    self._@sep1 = set:getElfNode("@sep1")
--    self._@item2 = set:getJoint9Node("@item2")
--    self._@ipet = set:getElfNode("@ipet")
--    self._@sep1 = set:getElfNode("@sep1")
--    self._@item3 = set:getJoint9Node("@item3")
--    self._@item0 = set:getElfNode("@item0")
--    self._@sep2 = set:getElfNode("@sep2")
--    self._@battleFinish = set:getElfNode("@battleFinish")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DBattleSpeed:onInit( userData, netData )
	res.doActionDialogShow(self._bg)

	local results = userData.Results
	local otherReward = userData.OtherReward
	local newRole = userData.newRole
	local oldRole = userData.oldRole
	local angelPetId = userData.AngelPetId

	local dataList  = {}

	self._clickBg:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._bg_btnClose:setTriggleSound(res.Sound.back)
	self._bg_btnClose:setListener(function (  )
		res.doActionDialogHide(self._bg, self)
	end)

	self._btnClick:setListener(function ( ... )
		self._btnClick:setVisible(false)
		self._bg_list:stopAllActions()
		if dataList then
			for i,v in ipairs(dataList) do
				for k,v2 in pairs(v) do
					v2[1]:setScale(1.0)
					if not v2[1]:getParent() then
						self._bg_list:getContainer():addChild(v2[1])
						v2[1]:release()
					end
					if v2["layout"] then
						local children = tolua.cast(v2["layout"]:getChildren(), 'CCArray')
						if children and children:count() > 0 then
							for t=0,children:count() - 1 do
								local node = tolua.cast( children:objectAtIndex(t), 'CCNode' )
								node:setVisible(true)
								node:setScale(1.0)
							end
						end
					end
				end
			end
			self._bg_list:layout()
			self._bg_list:alignTo(self._bg_list:getContainer():getChildrenCount())
		end
		if newRole then
			GleeCore:showLayer("DUserLevelUp", {oldRole = oldRole, newRole = newRole})
		end
		if angelPetId and angelPetId > 0 then
			self:showAnimationBossPet(angelPetId)
		end
	end)

	for i,v in ipairs(results) do
		local nodeSet = {}
		table.insert(dataList, nodeSet)

		if i ~= 1 then
			local sep2Set = self:createLuaSet("@sep2")
			table.insert(nodeSet, sep2Set)
		end
		local titleSet = self:createLuaSet("@title")
		table.insert(nodeSet, titleSet)
		titleSet["text"]:setString(res.locString(string.format("Dungeon$Battle%d", i)))
		
		local sep1Set = self:createLuaSet("@sep1")
		table.insert(nodeSet, sep1Set)

		local item1Set = self:createLuaSet("@item1")
		table.insert(nodeSet, item1Set)
		item1Set["exp"]:setString(v.Reward.Exp)
		item1Set["gold"]:setString(v.Reward.Gold)

		if v.LvUpPets and #v.LvUpPets > 0 then
			sep1Set = self:createLuaSet("@sep1")
			table.insert(nodeSet, sep1Set)

			local item2Set = self:createLuaSet("@item2")
			table.insert(nodeSet, item2Set)
			for ii,vv in ipairs(v.LvUpPets) do
				local petSet = self:createLuaSet("@ipet")
				item2Set["layout"]:addChild(petSet[1])

				local nPet = vv
				res.setNodeWithPet(petSet["icon"], nPet)
				petSet["lv"]:setString(nPet.Lv)
			end
		end

		if v.Reward then
			if (v.Reward.Pets and #v.Reward.Pets > 0) or (v.Reward.Equipments and #v.Reward.Equipments > 0) or 
				(v.Reward.Gems and #v.Reward.Gems > 0) or (v.Reward.Materials and #v.Reward.Materials > 0) or
				(v.Reward.PetPieces and #v.Reward.PetPieces > 0) then

				nodeSet = {}
				table.insert(dataList, nodeSet)

				sep1Set = self:createLuaSet("@sep1")
				table.insert(nodeSet, sep1Set)

				local titleSet = self:createLuaSet("@title")
				table.insert(nodeSet, titleSet)
				titleSet["text"]:setString(res.locString("Dungeon$BattleDrop"))
				
				sep1Set = self:createLuaSet("@sep1")
				table.insert(nodeSet, sep1Set)

				local item3Set = self:createLuaSet("@item3")
				table.insert(nodeSet, item3Set)

				self:updateReward(item3Set["layout"], v.Reward, false)
			end
		end
	end

	local nodeSet  = {}
	table.insert(dataList, nodeSet)	

	local battleFinishSet = self:createLuaSet("@battleFinish")
	table.insert(nodeSet, battleFinishSet)
	battleFinishSet["clip_bg"]:runAction(CCRepeatForever:create(CCRotateBy:create(1, -120)))
	
	if otherReward then
		nodeSet = {}
		table.insert(dataList, nodeSet)

		local titleSet = self:createLuaSet("@title")
		table.insert(nodeSet, titleSet)
		titleSet["text"]:setString(res.locString("Dungeon$BattleSpeedReward"))
		
		local sep1Set = self:createLuaSet("@sep1")
		table.insert(nodeSet, sep1Set)

		local item3Set = self:createLuaSet("@item3")
		table.insert(nodeSet, item3Set)

		self:updateReward(item3Set["layout"], otherReward, true)
	end

	if dataList then
		for i,v in ipairs(dataList) do
			for k,v2 in pairs(v) do
				v2[1]:retain()
			end
		end

		local function getActionScale( delta, callback )
			local actArray = CCArray:create()
			actArray:addObject(CCScaleTo:create(delta, 1))
			if callback then
				actArray:addObject(CCCallFunc:create(function ( ... )
					callback()
				end))
			end
			return CCSequence:create(actArray)
		end

		local delta = 0.8
		for i,v in ipairs(dataList) do
			self:runWithDelay(function ( ... )
				for k,v2 in pairs(v) do
					self._bg_list:getContainer():addChild(v2[1])
					v2[1]:release()
				end
				self._bg_list:layout()
				self._bg_list:alignTo(self._bg_list:getContainer():getChildrenCount())
				for i2,v2 in ipairs(v) do
					v2[1]:stopAllActions()
					v2[1]:setScale(1.2)
					if i2 == #v then
						v2[1]:runAction(getActionScale(0.3, function ( ... )
							if v2["layout"] then
								local children = tolua.cast(v2["layout"]:getChildren(), 'CCArray')
								if children and children:count() > 0 then
									for t=0,children:count() - 1 do
										local tt = t
										self:runWithDelay(function ( ... )
											local node = tolua.cast( children:objectAtIndex(tt), 'CCNode' )
											node:setVisible(true)
											node:runAction(CCScaleTo:create(0.2, 1.0))
										end, 0.2 * t)
									end
								end
							end
						end))
					else
						v2[1]:runAction(getActionScale(0.3))
					end
				end
				if i == #dataList then
					self._btnClick:setVisible(false)

					local function doActionLevelUp( ... )
						if newRole then
							self:runWithDelay(function ( ... )
								GleeCore:showLayer("DUserLevelUp", {oldRole = oldRole, newRole = newRole})
							end, delta, self._bg_list)
						end
					end

					if angelPetId and angelPetId > 0 then
						self:runWithDelay(function ( ... )
							self:showAnimationBossPet(angelPetId, doActionLevelUp)
						end, delta, self._bg_list)
					else
						doActionLevelUp()
					end
				end
			end, delta * (i - 1), self._bg_list)
		end
	end
end

function DBattleSpeed:onBack( userData, netData )
	
end

function DBattleSpeed:close( ... )
	local userData = self:getUserData()
	if userData and userData.callback then
		userData.callback()
	end
end
--------------------------------custom code-----------------------------

function DBattleSpeed:updateReward( root, nReward, showGoldIcon )
	local scaleOrigal = 84 / 155
	local list = res.getRewardResList(nReward)
	if list then
		for i=#list,1,-1 do
			if list[i].type == "Exp" then
				table.remove(list, i)
			end
			if not showGoldIcon then
				if list[i].type == "Gold" or list[i].type == "Coin" then
					table.remove(list, i)
				end
			end
		end

		for i,v in ipairs(list) do
			local item = self:createLuaSet("@item0")
			root:addChild(item[1])
			
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
			item["isPiece"]:setVisible(v.isPiece)
			item["count"]:setString(v.count)

			item[1]:setVisible(false)
			item[1]:setScale(1.2)
		end
	end
end

function DBattleSpeed:showAnimationBossPet( petId, callback )
	local animBg = RectangleNode:create()
	local winSize = CCDirector:sharedDirector():getWinSize()
	animBg:setContentSize(CCSize(winSize.width + 200, winSize.height + 200))
	animBg:setColorf(0, 0, 0, 0.6)
	animBg:setVisible(false)
	self:getLayer():addChild(animBg)

	local Swf = require 'framework.swf.Swf'
	local myswf = Swf.new('Swf_ShenShou', {[2] = animBg})
	self:getLayer():addChild( myswf:getRootNode() )

	for i=3,5 do
		local petIcon = ElfNode:create()
		petIcon:setResid(string.format("role_%03d.png", petId))
		petIcon:setScale(require 'CfgHelper'.getCache('BattleCharactor', 'id', petId).troop_scale)
		myswf:getNodeByTag(i):addChild(petIcon)
	end
	local shapeMap = {
		['shape-19'] = "",
		['shape-21'] = 'FB_ssjl01.png',
		['shape-23'] = 'FB_ssjl02.png',
		['shape-25'] = 'FB_ssjl03.png',
		['shape-27'] = 'FB_ssjl04.png',
	}
	myswf:play(shapeMap, nil, function ( ... )
		myswf:getRootNode():removeFromParentAndCleanup(true)
		animBg:removeFromParentAndCleanup(true)
		if callback then
			callback()
		end
		res.setTouchDispatchEvents(true)
	end)

	self:runWithDelay(function ( ... )
		require 'framework.helper.MusicHelper'.playEffect(res.Sound.ui_sfx_advent)
	end, 16 / 24)
	res.setTouchDispatchEvents(false)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DBattleSpeed, "DBattleSpeed")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DBattleSpeed", DBattleSpeed)
