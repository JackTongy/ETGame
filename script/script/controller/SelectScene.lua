local config = require "Config"

local SelectScene = class(LuaController)

function SelectScene:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."SelectScene.cocos.zip")
    return self._factory:createDocument("SelectScene.cocos")
end

--@@@@[[[[
function SelectScene:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._fuben = set:getElfNode("fuben")
    self._fuben_list = set:getListNode("fuben_list")
    self._tab = set:getTabNode("tab")
    self._label = set:getLabelNode("label")
    self._team = set:getElfNode("team")
    self._team_list = set:getListNode("team_list")
    self._tab = set:getTabNode("tab")
    self._label = set:getLabelNode("label")
    self._button = set:getButtonNode("button")
    self._backClick = set:getColorClickNode("backClick")
    self._guideButton = set:getButtonNode("guideButton")
    self._ActionBallEnter = set:getElfAction("ActionBallEnter")
    self._ActionBiShaTwinkle = set:getElfAction("ActionBiShaTwinkle")
    self._ActionBallDisappear = set:getElfAction("ActionBallDisappear")
    self._ActionCureValue = set:getElfAction("ActionCureValue")
    self._ActionHurtValue = set:getElfAction("ActionHurtValue")
    self._ActionSelectRectHide = set:getElfAction("ActionSelectRectHide")
    self._ActionSelectRectShow = set:getElfAction("ActionSelectRectShow")
    self._ActionLockTarget = set:getElfAction("ActionLockTarget")
    self._ActionLockTargetHide = set:getElfAction("ActionLockTargetHide")
--    self._@fubenItem = set:getElfNode("@fubenItem")
--    self._@teamItem = set:getElfNode("@teamItem")
end
--@@@@]]]]

--------------------------------override functions----------------------
local EventCenter = require 'EventCenter'

function SelectScene:onInit( userData, netData )
	local fubenArray = require 'pve_fubens'

	for i,v in ipairs (fubenArray) do 
		local lset = self:createLuaSet('@fubenItem')
		lset['label']:setString( tostring(v.fubenid) )
		lset['tab']:setListener(function ()
			self['fubenid'] = v.fubenid
		end)
		self._fuben_list:addListItem( lset[1] )

		if i == 1 then
			lset['tab']:trigger(lset['tab'])
		end
	end
	self._fuben_list:layout()

	local teamArray = require 'pve_charactor_teams'
	for i,v in ipairs (teamArray) do 
		local lset = self:createLuaSet('@teamItem')
		lset['label']:setString( tostring(v.teamid) )
		lset['tab']:setListener(function ()
			self['teamid'] = v.teamid
		end)
		self._team_list:addListItem( lset[1] )

		if i == 1 then
			lset['tab']:trigger(lset['tab'])
		end
	end
	self._team_list:layout()

	self._button:setListener(function ( ... )
		-- body
		local data = { type = 'test', data = { fubenid = self['fubenid'], teamid = self['teamid'] } }

		-- GleeCore:pushController('GameStart', data)
		EventCenter.eventInput('BattleStart', data)
		
	end)


	self._backClick:setListener(function ( ... )
		-- body
		GleeCore:popController()
	end)


	self._guideButton:setListener(function ( ... )
		-- body
		-- local data = { type = 'guider', data = { battleId = 100, teamid = 1 } }
		-- EventCenter.eventInput('BattleStart', data)
		GleeCore:replaceController("CDialogBeforeBattle")
	end)

end

function SelectScene:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(SelectScene, "SelectScene")


--------------------------------register--------------------------------
GleeCore:registerLuaController("SelectScene", SelectScene)


