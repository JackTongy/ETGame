local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"
local gameFunc = require "AppData"
local dbManager = require "DBManager"

local DSkillBookDetail = class(LuaDialog)

function DSkillBookDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSkillBookDetail.cocos.zip")
    return self._factory:createDocument("DSkillBookDetail.cocos")
end

--@@@@[[[[
function DSkillBookDetail:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_icon = set:getElfNode("root_icon")
    self._root_piece = set:getElfNode("root_piece")
    self._root_count = set:getLabelNode("root_count")
    self._root_name = set:getLabelNode("root_name")
    self._root_LvLimit = set:getLabelNode("root_LvLimit")
    self._root_des = set:getRichLabelNode("root_des")
    self._root_btnClose2 = set:getClickNode("root_btnClose2")
    self._root_btnClose2_text = set:getLabelNode("root_btnClose2_text")
    self._root_btnClose = set:getClickNode("root_btnClose")
    self._root_btnClose_text = set:getLabelNode("root_btnClose_text")
    self._root_btnMerge = set:getClickNode("root_btnMerge")
    self._root_btnMerge_text = set:getLabelNode("root_btnMerge_text")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DSkillBookDetail:onInit( userData, netData )
	self.nBook = userData
	self:setListenerEvent()
	self:updateLayer()
	res.doActionDialogShow(self._root)
end

function DSkillBookDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DSkillBookDetail:setListenerEvent( ... )
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnClose:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnClose2:setListener(function ( ... )
		res.doActionDialogHide(self._root, self)
	end)

	self._root_btnMerge:setListener(function ( ... )
		self:send(netModel.getModelRemainBookSyn(self.nBook.Id), function ( data )
			if data and data.D then
				gameFunc.getPerlBookInfo().removeBookPiece(self.nBook.Id, self.MergeAmount)
				if data.D.Resource then
					gameFunc.updateResource(data.D.Resource)
				end
				require "EventCenter".eventInput("UpdateSkillBook")
				res.doActionDialogHide(self._root, self)
				if data.D.Reward then
					GleeCore:showLayer("DGetReward", data.D.Reward)
				end
			end
		end)
	end)
end

function DSkillBookDetail:updateLayer( ... )
	local dbSkill = dbManager.getInfoSkill(self.nBook.Bid)
	local dbBook = dbManager.getInfoBookConfig(self.nBook.Bid)
	res.setNodeWithBook(self._root_icon, dbBook)
	self._root_name:setString(dbSkill.name)
	self._root_LvLimit:setVisible(self.nBook.Tp ~= nil)
	if self.nBook.Tp then
		self._root_LvLimit:setString(string.format(res.locString("PetKill$SkillLevelUp"), self.nBook.Tp))
	end
	
	self._root_des:setString(string.format(res.locString("Remains$SkillBookDes"), dbSkill.skilldes))
	self._root_piece:setVisible(self.nBook.isPiece)
	self._root_count:setVisible(self.nBook.isPiece)
	self._root_btnClose:setVisible(self.nBook.isPiece)
	self._root_btnMerge:setVisible(self.nBook.isPiece)
	self._root_btnClose2:setVisible(not self.nBook.isPiece)
	if self.nBook.isPiece then
		local colorList = {[1] = 0, [2] = 5, [3] = 25, [4] = 50}
		self._root_count:setString(string.format("%d/%d", self.nBook.Amount, colorList[dbBook.Color]))
		self._root_btnMerge:setEnabled(self.nBook.Amount >= colorList[dbBook.Color])
		if self.nBook.Amount < colorList[dbBook.Color] then
			self._root_count:setFontFillColor(res.color4F.red, true)
		else
			self._root_count:setFontFillColor(res.color4F.green, true)
		end
		self.MergeAmount = colorList[dbBook.Color]
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSkillBookDetail, "DSkillBookDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSkillBookDetail", DSkillBookDetail)


