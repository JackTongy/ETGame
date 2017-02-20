local Config = require "Config"

local LabelSet = class(LuaController)

function LabelSet:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."LabelSet.cocos.zip")
    return self._factory:createDocument("LabelSet.cocos")
end

--@@@@[[[[
function LabelSet:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._ActionHurtValue = set:getElfAction("ActionHurtValue")
   self._ActionCureValue = set:getElfAction("ActionCureValue")
--   self._@BaoJiWenZi = set:getJointAnimateNode("@BaoJiWenZi")
--   self._@DongJieWenZi = set:getJointAnimateNode("@DongJieWenZi")
--   self._@HuanSuWenZi = set:getJointAnimateNode("@HuanSuWenZi")
--   self._@HunMiWenZi = set:getJointAnimateNode("@HunMiWenZi")
--   self._@MianYiWenZi = set:getJointAnimateNode("@MianYiWenZi")
--   self._@ZhiMangWenZi = set:getJointAnimateNode("@ZhiMangWenZi")
--   self._@ZhongDuWenZi = set:getJointAnimateNode("@ZhongDuWenZi")
--   self._@WuDi = set:getJointAnimateNode("@WuDi")
--   self._@DaDuan = set:getJointAnimateNode("@DaDuan")
--   self._@LiuXueWenZi = set:getJointAnimateNode("@LiuXueWenZi")
end
--@@@@]]]]

--------------------------------override functions----------------------
function LabelSet:onInit( userData, netData )
	
end

function LabelSet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(LabelSet, "LabelSet")


--------------------------------register--------------------------------
GleeCore:registerLuaController("LabelSet", LabelSet)


