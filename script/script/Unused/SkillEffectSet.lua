local config = require "Config"

local SkillEffectSet = class(LuaController)

function SkillEffectSet:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."SkillEffectSet.cocos.zip")
    return self._factory:createDocument("SkillEffectSet.cocos")
end

--@@@@[[[[  created at Wed Apr 16 15:23:19 CST 2014 By null
function SkillEffectSet:onInitXML()
    local set = self._set
--   self._@effect1 = set:getSimpleAnimateNode("@effect1")
end
--@@@@]]]]

--------------------------------override functions----------------------
function SkillEffectSet:getNetModel()
	
end

function SkillEffectSet:onInit( userData, netData )
	
end

function SkillEffectSet:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(SkillEffectSet, "SkillEffectSet")


--------------------------------register--------------------------------
GleeCore:registerLuaController("SkillEffectSet", SkillEffectSet)


