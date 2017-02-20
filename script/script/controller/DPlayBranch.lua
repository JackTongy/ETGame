local Config = require "Config"
local res = require "Res"
local unLockManager = require "UnlockManager"
local townFunc = require "TownInfo"

local DPlayBranch = class(LuaDialog)

function DPlayBranch:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DPlayBranch.cocos.zip")
    return self._factory:createDocument("DPlayBranch.cocos")
end

--@@@@[[[[
function DPlayBranch:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getElfNode("bg")
   self._bg_layoutMode = set:getLayoutNode("bg_layoutMode")
   self._bg_layoutMode_btnNormal = set:getClickNode("bg_layoutMode_btnNormal")
   self._bg_layoutMode_btnSenior = set:getClickNode("bg_layoutMode_btnSenior")
   self._bg_layoutMode_btnSenior_lock = set:getElfNode("bg_layoutMode_btnSenior_lock")
   self._bg_layoutMode_btnHero = set:getClickNode("bg_layoutMode_btnHero")
   self._bg_layoutMode_btnHero_lock = set:getElfNode("bg_layoutMode_btnHero_lock")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DPlayBranch:onInit( userData, netData )
	res.doActionDialogShow(self._bg,function ( ... )
      require 'GuideHelper':registerPoint('英雄副本',self._bg_layoutMode_btnHero)
      require 'GuideHelper':registerPoint('精英副本',self._bg_layoutMode_btnSenior)
      require 'GuideHelper':check('DPlayBranch')
   end)

	local curPlayBranch = townFunc.getPlayBranch()

	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

   self._bg_layoutMode_btnNormal:setListener(function ( ... )
   	if curPlayBranch ~= townFunc.getPlayBranchList().PlayBranchNormal then
   		townFunc.setPlayBranch(townFunc.getPlayBranchList().PlayBranchNormal)
   		require "EventCenter".eventInput("SwitchPlayBranch")
   	end
   	res.doActionDialogHide(self._bg, self)
   end)

   self._bg_layoutMode_btnSenior:setListener(function ( ... )
   	if unLockManager:isUnlock("Elite") then
   		if curPlayBranch ~= townFunc.getPlayBranchList().PlayBranchSenior then
   			townFunc.setPlayBranch(townFunc.getPlayBranchList().PlayBranchSenior)
   			require "EventCenter".eventInput("SwitchPlayBranch")
            require 'GuideHelper':check('EliteMode')
   		end
   		res.doActionDialogHide(self._bg, self)
   	else
   		self:toast(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("Elite")))
   	end
   end)

   self._bg_layoutMode_btnHero:setListener(function ( ... )
	   if not require "UnlockManager":isOpen( "herofuben" ) then
	   	self:toast(res.locString("Explore$_Tips"))
	   	return
	   end

   	if unLockManager:isUnlock("HeroElite") then
   		if curPlayBranch ~= townFunc.getPlayBranchList().PlayBranchHero then
   			townFunc.setPlayBranch(townFunc.getPlayBranchList().PlayBranchHero)
   			require "EventCenter".eventInput("SwitchPlayBranch")
            require 'GuideHelper':check('HeroMode')
   		end
   		res.doActionDialogHide(self._bg, self)
   	else
   		self:toast(string.format(res.locString("Home$LevelUnLockTip"), unLockManager:getUnlockLv("HeroElite")))
   	end
   end)

   self._bg_layoutMode_btnSenior_lock:setVisible(not unLockManager:isUnlock("Elite"))
   self._bg_layoutMode_btnHero_lock:setVisible(not unLockManager:isUnlock("HeroElite"))
end

function DPlayBranch:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPlayBranch, "DPlayBranch")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPlayBranch", DPlayBranch)
