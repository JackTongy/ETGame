local Config 			= require "Config"
local dbManager 		= require "DBManager"
local res 				= require "Res"
local EventCenter 		= require 'EventCenter'

local CDialogBeforeBattle = class(LuaController)

function CDialogBeforeBattle:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CDialogBeforeBattle.cocos.zip")
    return self._factory:createDocument("CDialogBeforeBattle.cocos")
end

--@@@@[[[[
function CDialogBeforeBattle:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._bg_pic1 = set:getElfNode("bg_pic1")
    self._bg_pic2 = set:getElfNode("bg_pic2")
    self._main = set:getElfNode("main")
    self._main_rect = set:getRectangleNode("main_rect")
    self._main_pet74 = set:getElfNode("main_pet74")
    self._main_pet30 = set:getElfNode("main_pet30")
    self._main_pet67 = set:getElfNode("main_pet67")
    self._main_pet150 = set:getElfNode("main_pet150")
    self._main_pet243 = set:getElfNode("main_pet243")
    self._main_anim = set:getSimpleAnimateNode("main_anim")
    self._dialog = set:getElfNode("dialog")
    self._dialog_name = set:getLabelNode("dialog_name")
    self._dialog_content = set:getLabelNode("dialog_content")
    self._dialog_icon = set:getElfNode("dialog_icon")
    self._screenBtn = set:getButtonNode("screenBtn")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CDialogBeforeBattle:onInit( userData, netData )
	GleeCore:closeAllLayers()
	
	self.cachedFunc = nil

	self._screenBtn:setListener(function ( ... )
		if self.cachedFunc then
			self.cachedFunc()
			self.cachedFunc = nil
		else
			self.stepIndex = self.stepIndex+1
			for i,v in ipairs(self.showPetList) do
				v:getParent():reorderChild(v,1)
			end
			self:step()
		end
	end)

	self.showPetList = {}

	self.stepIndex = 13
	self._main_pet150:stopAllActions()
	self._main_pet150:setPosition(17-350,-87)
	self._main_pet150:setColorf(1,1,1,1)
	self:step()

	-- require 'framework.helper.MusicHelper'.playBackgroundMusic("htp_dialogue.mp3", true)
	require 'framework.helper.MusicHelper'.playBackgroundMusic(require 'Res'.Music.dialogue, true)
end

function CDialogBeforeBattle:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
local rate = 1.5
local Earth_Shake_Action_Data = {
   [1] = { f = 1, p = {0, 0} },
   [2] = { f = 2,   p = {-4.00*rate, -4*rate} },
   [3] = { f = 3,   p = {-14*rate, -14*rate} },
   [4] = { f = 4,   p = {-4.00*rate, 6*rate} },
   [5] = { f = 5,   p = {4*rate, -4*rate} },
   [6] = { f = 6,   p = {0, 0} },
}

function CDialogBeforeBattle:createQuakeAction()
   -- body
   local action = require 'framework.swf.SwfActionFactory'.createAction(Earth_Shake_Action_Data,nil,nil, 15)
   return action
end

function CDialogBeforeBattle:onStepFinish( ... )
	-- GleeCore:replaceController("CWorldMap")
	local data = { type = 'guider', data = { battleId = 100, teamid = 1 } }
	EventCenter.eventInput('BattleStart', data)
end

function CDialogBeforeBattle:step( ... )
	if self.stepIndex == 1 then
		self.cachedFunc = function ( ... )
			self._main_pet30:stopAllActions()
			self._main_pet30:setPosition(384,-102)
			self:showDialog()
		end
		local arr = CCArray:create()
		arr:addObject(CCMoveBy:create(0.1,CCPointMake(-500,0)))
		arr:addObject(CCCallFunc:create(function ( ... )
			self.cachedFunc()
			self.cachedFunc = nil
		end))
		self.showPetList = {self._main_pet30}
		self._main_pet30:runAction(CCSequence:create(arr))
	elseif self.stepIndex == 2 then
		self.cachedFunc = function ( ... )
			self._main_pet67:stopAllActions()
			self._main_pet67:setPosition(321,-119)
			self:showDialog()
		end
		local arr = CCArray:create()
		arr:addObject(CCMoveBy:create(0.1,CCPointMake(-490,0)))
		arr:addObject(CCCallFunc:create(function ( ... )
			self.cachedFunc()
			self.cachedFunc = nil
		end))
		self.showPetList = {self._main_pet67}
		self._main_pet30:setVisible(false)
		self._main_pet67:runAction(CCSequence:create(arr))
	elseif self.stepIndex == 3 then
		self.showPetList = {self._main_pet30}
		self._main_pet67:setVisible(false)
		self._main_pet30:setVisible(true)
		self:showDialog()
	elseif self.stepIndex == 4 then
		self.cachedFunc = function ( ... )
			self._main_pet74:stopAllActions()
			self._main_pet74:setPosition(323,-48)
			self:showDialog()
		end
		local arr = CCArray:create()
		arr:addObject(CCMoveBy:create(0.1,CCPointMake(-500,0)))
		arr:addObject(CCCallFunc:create(function ( ... )
			self.cachedFunc()
			self.cachedFunc = nil
		end))
		self.showPetList = {self._main_pet74}
		self._main_pet30:setVisible(false)
		self._main_pet74:runAction(CCSequence:create(arr))
	elseif self.stepIndex == 5 then
		self.cachedFunc = function ( ... )
			self._main_pet74:stopAllActions()
			self._main_pet74:setColorf(1,1,1,0)
			self:showDialog()			
		end
		local arr = CCArray:create()
		arr:addObject(CCFadeOut:create(0.3))
		arr:addObject(CCCallFunc:create(function ( ... )
			self.cachedFunc()
			self.cachedFunc = nil
		end))
		self.showPetList = {}
		self._main_pet74:runAction(CCSequence:create(arr))
	elseif self.stepIndex == 6 then
		self.cachedFunc = function ( ... )
			self._main_pet67:stopAllActions()
			self._main_pet67:setPosition(154,-119)
			self:showDialog()
		end
		self._main_pet67:setPosition(816,-119)
		local arr = CCArray:create()
		arr:addObject(CCMoveBy:create(0.075,CCPointMake(-662,0)))
		arr:addObject(CCCallFunc:create(function ( ... )
			self.cachedFunc()
			self.cachedFunc = nil
		end))
		self.showPetList = {self._main_pet67}
		self._main_pet67:setVisible(true)
		self._main_pet67:runAction(CCSequence:create(arr))
	elseif self.stepIndex == 7 then
		self.cachedFunc = function ( ... )
			self._main_pet150:stopAllActions()
			self._main_pet150:setColorf(1,1,1,1)
			self._main_pet30:stopAllActions()
			self._main_pet30:setColorf(1,1,1,1)
			self._main_pet30:setScaleX(-1)
			self._main_pet30:setVisible(true)
			self._main_pet30:setPosition(418,-89)
			self:showDialog()
		end
		local arr = CCArray:create()
		arr:addObject(CCFadeIn:create(1.25))
		arr:addObject(CCCallFunc:create(function ( ... )
			local arr = CCArray:create()
			arr:addObject(CCMoveBy:create(0.2,CCPointMake(-500,0)))
			arr:addObject(CCCallFunc:create(function ( ... )
				self.cachedFunc()
				self.cachedFunc = nil
			end))
			self._main_pet30:setVisible(true)
			self._main_pet30:setPosition(918,-89)
			self._main_pet30:runAction(CCSequence:create(arr))
		end))
		self.showPetList = {self._main_pet67,self._main_pet150,self._main_pet30}
		self._main_pet150:runAction(CCSequence:create(arr))
	elseif self.stepIndex == 8 then
		self.showPetList = {self._main_pet74,self._main_pet150,self._main_pet30,self._main_pet67}
		self._main_pet74:setColorf(1,1,1,1)
		self._main_pet74:setScaleX(-1)
		self._main_pet74:setPosition(477,-76)
		self:showDialog()
	elseif self.stepIndex == 9 then
		self.cachedFunc = function ( ... )
			self._main_pet150:stopAllActions()
			self._main_pet150:setPosition(17-350,-87)
			self._main_pet74:stopAllActions()
			self._main_pet74:setPosition(577,-76)
			self._main_pet30:stopAllActions()
			self._main_pet30:setPosition(518,-89)
			self._main_pet67:stopAllActions()
			self._main_pet67:setPosition(254,-119)
			self._main_rect:setColorf(0,0,0,0.6)
			self:showDialog()
			self._main_anim:removeFromParentAndCleanup(true)
		end
		local arr = CCArray:create()
		arr:addObject(CCMoveBy:create(0.1,CCPointMake(350,0)))
		arr:addObject(CCCallFunc:create(function ( ... )
			self._bg:getParent():runAction(self:createQuakeAction())

			self._main_anim:setVisible(true)
			local t = ccBlendFunc:new()
			t.src = 770
			t.dst = 1
			self._main_anim:setBlendFunc(t)
			self._main_anim:setOrder(2)
			self._main_anim:setLoops(1)
			self._main_rect:setColorf(1,1,1,0.8)
			self._main_anim:setListener(function ( ... )
				print("anim end------")
				self._main_rect:setColorf(0,0,0,0.6)
			end)
			self._main_anim:start()
			require 'framework.helper.MusicHelper'.playEffect("bt_mage_hit.mp3")
			-- self._main_anim:setListener(function ( ... )
				local order = {self._main_pet67,self._main_pet30,self._main_pet74}
				for i,v in ipairs(order) do
					local arr = CCArray:create()
					arr:addObject(CCDelayTime:create((i-1)*0.05+0.1))
					arr:addObject(CCMoveBy:create(0.1,CCPointMake(100,0)))
					if i == 1 then
						self:showDialog()
					elseif i == #order then
						arr:addObject(CCCallFunc:create(function ( ... )
							self.cachedFunc()
							self.cachedFunc = nil
						end))
					end
					v:runAction(CCSequence:create(arr))
				end
			-- end)
		end))
		arr:addObject(CCMoveBy:create(0.1,CCPointMake(-350,0)))
		self._main_pet150:runAction(CCSequence:create(arr))
	elseif	self.stepIndex == 10 then
		self:showDialog()
	elseif self.stepIndex == 11 then
		self.cachedFunc = function ( ... )
			self._main_pet74:stopAllActions()
			self._main_pet74:setPosition(1000,-76)
			self._main_pet30:stopAllActions()
			self._main_pet30:setPosition(1000,-89)
			self._main_pet67:stopAllActions()
			self._main_pet67:setPosition(1000,-119)
		end
		self.showPetList = {self._main_pet150}

		local order = {self._main_pet74,self._main_pet30,self._main_pet67}
		for i,v in ipairs(order) do
			local arr = CCArray:create()
			arr:addObject(CCDelayTime:create((i-1)*0.05))
			arr:addObject(CCMoveTo:create(0.1,CCPointMake(1000,0)))
			if i == #order then
				arr:addObject(CCCallFunc:create(function ( ... )
					self.cachedFunc()
					self.cachedFunc = nil
				end))
			end
			v:runAction(CCSequence:create(arr))
		end
	elseif self.stepIndex == 12 then
		self:showDialog(11)
	elseif self.stepIndex == 13 then
		self.cachedFunc = function ( ... )
			self._main_pet243:stopAllActions()
			self._main_pet243:setPosition(350,-83)
		
			if require 'AccountHelper'.isItemOFF('PetName') then
				self.cachedFunc = nil
				self._screenBtn:trigger(nil)
			else
				self:showDialog(12)
			end
		end
		self.showPetList = {self._main_pet150,self._main_pet243}
		local arr = CCArray:create()
		arr:addObject(CCMoveBy:create(0.1,CCPointMake(-725,0)))
		arr:addObject(CCCallFunc:create(function ( ... )
			self.cachedFunc()
			self.cachedFunc = nil
		end))
		self._main_pet243:runAction(CCSequence:create(arr))
	elseif self.stepIndex == 14 then
		self:showDialog(13)
	elseif self.stepIndex == 15 then
		self:showDialog(14)
	elseif self.stepIndex == 16 then
		return self:onStepFinish()
	end
end

function CDialogBeforeBattle:showDialog( index )
	local data = self:getDialog(index or self.stepIndex)

	local cur =  self[string.format("_main_pet%d",data.PetID)]
	for i,v in ipairs(self.showPetList) do
		if v == cur then
			v:getParent():reorderChild(v,1)
		else
			v:getParent():reorderChild(v,-1)
		end
	end

	self._dialog:setVisible(true)
	self._dialog_name:setString(dbManager.getCharactor(data.PetID).name)
	self._dialog_content:setString(data.Content)
	self._dialog_icon:runElfAction(res.getFadeAction(0.5))
	if self.preSoundID then
		require 'framework.helper.MusicHelper'.stopEffect(self.preSoundID)
	end
	self.preSoundID = require 'framework.helper.MusicHelper'.playEffect(string.format("raw/guide/%s",data.Sound))
end

function CDialogBeforeBattle:getDialog( index )
	for k,v in pairs(require "Dialogue") do
		if v.ID == index then
			return v
		end
	end
	return nil
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CDialogBeforeBattle, "CDialogBeforeBattle")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CDialogBeforeBattle", CDialogBeforeBattle)


