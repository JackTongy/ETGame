local Config = require "Config"
local res = require "Res"

local DRuneDetail = class(LuaDialog)

function DRuneDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRuneDetail.cocos.zip")
    return self._factory:createDocument("DRuneDetail.cocos")
end

--@@@@[[[[
function DRuneDetail:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getShieldNode("bg")
    self._bg_detailBg_gemIcon = set:getElfNode("bg_detailBg_gemIcon")
    self._bg_detailBg_gemName = set:getLabelNode("bg_detailBg_gemName")
    self._bg_detailBg_layout = set:getLinearLayoutNode("bg_detailBg_layout")
--    self._@title = set:getLabelNode("@title")
--    self._@info = set:getLabelNode("@info")
--    self._@sp = set:getElfNode("@sp")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DRuneDetail:onInit( userData, netData )
	self.mRune = userData.RuneData or userData
	self:updateView()

	res.doActionDialogShow(self._bg)
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)
end

function DRuneDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------
function DRuneDetail:updateView(  )
	local dbinfo = require "DBManager".getInfoRune(self.mRune.RuneId)
	res.setNodeWithRune(self._bg_detailBg_gemIcon,self.mRune.RuneId,self.mRune.Star,self.mRune.Lv)
	self._bg_detailBg_gemName:setString(require "Toolkit".getRuneName(self.mRune.RuneId,self.mRune.Lv))

	local title = self:createLuaSet("@title")[1]
	title:setString(res.locString("Rune$ProTitle"))
	self._bg_detailBg_layout:addChild(title)

	local pro = self:createLuaSet("@info")[1]
	pro:setString(res.locString(string.format("Rune$RuneType%d",dbinfo.Location)).." "..require "CalculateTool".getRuneBaseProValue(self.mRune))
	self._bg_detailBg_layout:addChild(pro)

	if self.mRune.Buffs and #self.mRune.Buffs>0 then
		for i,v in ipairs(self.mRune.Buffs) do
			pro = self:createLuaSet("@info")[1]
			local value = v.Value >= 0 and string.format("+%g%%",math.floor(v.Value*1000)/10) or "?"
			pro:setString(res.locString(string.format("Rune$RuneBuff%s",v.Type)).." ".. value)
			pro:setFontFillColor(self:getProColor(i),true)
			self._bg_detailBg_layout:addChild(pro)
		end
	end

	local sp = self:createLuaSet("@sp")[1]
	self._bg_detailBg_layout:addChild(sp)

	local dbSet = require "DBManager".getInfoRuneSetConfig(dbinfo.SetId)
	local setInCount = 0
	if self.mRune.SetIn>0 and table.find(require "RuneInfo".getRuneList(),self.mRune) then
		local runes = require "RuneInfo".selectByCondition(function ( v )
			if v.SetIn == self.mRune.SetIn then
				local setid = require "DBManager".getInfoRune(v.RuneId).SetId
				return setid == dbinfo.SetId
			else
				return false
			end
		end)
		setInCount = #runes
	end

	title = self:createLuaSet("@title")[1]
	title:setString(string.format(res.locString("Rune$RuneSetTitle"),dbSet.name))
	self._bg_detailBg_layout:addChild(title)

	pro = self:createLuaSet("@info")[1]
	pro:setString(string.format("( %d/2 )  %s +%g%%",setInCount,res.locString(string.format("Rune$RuneBuff%s",dbSet.type1)),math.floor(dbSet.value1*1000)/10))
	pro:setFontFillColor(setInCount>=2 and res.color4F.white or ccc4f(0.5,0.5,0.5,1),true)
	self._bg_detailBg_layout:addChild(pro)

	pro = self:createLuaSet("@info")[1]
	pro:setString(string.format("( %d/4 )  %s +%g%%",setInCount,res.locString(string.format("Rune$RuneBuff%s",dbSet.type2)),math.floor(dbSet.value2*1000)/10))
	pro:setFontFillColor(setInCount>=4 and res.color4F.white or ccc4f(0.5,0.5,0.5,1),true)
	self._bg_detailBg_layout:addChild(pro)
end

function DRuneDetail:getProColor( index )
	return res.getEquipColor(index)
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRuneDetail, "DRuneDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRuneDetail", DRuneDetail)


