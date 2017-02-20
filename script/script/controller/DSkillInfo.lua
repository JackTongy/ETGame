local Config = require "Config"
local Res = require 'Res'
local DBManager = require 'DBManager'
local DSkillInfo = class(LuaDialog)

function DSkillInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DSkillInfo.cocos.zip")
    return self._factory:createDocument("DSkillInfo.cocos")
end

--@@@@[[[[
function DSkillInfo:onInitXML()
    local set = self._set
   self._Btnskillinfo = set:getButtonNode("Btnskillinfo")
   self._skilldetial = set:getJoint9Node("skilldetial")
   self._skilldetial_content = set:getRichLabelNode("skilldetial_content")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DSkillInfo:onInit( userData, netData )

	local cost = userData.cost
	local skillitem = userData.skillitem
	local align = userData.align or 1 -- 1:bottom 2:left 3:top 4:right 
	local offset = userData.offset or 40

	local content
	if cost then
	  content = string.format(Res.locString('PetDetail$SKILLDES'),skillitem.name,skillitem.skilldes)--,skillitem.point)
	else
	  content = string.format('[color=ffb075fa]%s[/color] %s',skillitem.name,skillitem.skilldes)
	end

	if skillitem.abilityIndex then
		content = string.format(Res.locString('PetDetail$SKILLDES_lock'),skillitem.name,skillitem.skilldes,self:getSkillUnlockAwakeText(skillitem.abilityIndex))
	end

	content = string.gsub(content, "\n", "")
	self._skilldetial_content:setString(content)

	local size = self._skilldetial_content:getContentSize()
	local csize = CCSizeMake(size.width+20,size.height+20)
    self._skilldetial:setContentSize(csize)

	self._Btnskillinfo:setTouchDownListener(function ( ... )
		self:close()
	end)

	local point = userData.point 
	print("__point.x = " .. tostring(point.x))
	if align == 1 then
		point.y = point.y - offset - csize.height/2
	elseif align == 2 then
		point.x = point.x - offset - csize.width/2
	elseif align == 3 then
		point.y = point.y + offset + csize.height/2
	elseif align == 4 then
		point.x = point.x + offset + csize.width/2
	end
	print("point.x = " .. tostring(point.x))

	--保持窗体在屏幕中
	local wsize = CCDirector:sharedDirector():getWinSize()
	local lx = csize.width/2 + 10
	local rx = wsize.width - csize.width/2 - 10
	local ty = wsize.height - csize.height/2 - 10
	local by = csize.height/2 + 10

	if point.x < lx then point.x = lx end
	if point.x > rx then point.x = rx end
	if point.y > ty then point.y = ty end
	if point.y < by then point.y = by end


	NodeHelper:setPositionInScreen(self._skilldetial,point)
	
end

function DSkillInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DSkillInfo:getSkillUnlockAwakeText( unlockcnt)
	local awakeIndex = DBManager.getGradeByUnlockCnt(unlockcnt)
	local finalAwake = Res.getFinalAwake(awakeIndex)
	return Res.Num[finalAwake]
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DSkillInfo, "DSkillInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DSkillInfo", DSkillInfo)
