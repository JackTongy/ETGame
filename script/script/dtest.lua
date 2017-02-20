local Config = require "Config"

local dtest = class(LuaDialog)

function dtest:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."dtest.cocos.zip")
    return self._factory:createDocument("dtest.cocos")
end

--@@@@[[[[
function dtest:onInitXML()
    local set = self._set
   self._flashmain_root = set:getElfNode("flashmain_root")
   self._flashmain_root_tag-1 = set:getAddColorNode("flashmain_root_tag-1")
   self._flashmain_root_tag-2 = set:getAddColorNode("flashmain_root_tag-2")
   self._flashmain_root_tag-3 = set:getAddColorNode("flashmain_root_tag-3")
   self._flashmain_root_tag-4 = set:getAddColorNode("flashmain_root_tag-4")
   self._flashmain_root_tag-5 = set:getAddColorNode("flashmain_root_tag-5")
   self._flashmain_root_tag-7 = set:getAddColorNode("flashmain_root_tag-7")
   self._flashmain_root_tag-8 = set:getAddColorNode("flashmain_root_tag-8")
   self._flashmain_root_tag-9 = set:getAddColorNode("flashmain_root_tag-9")
end
--@@@@]]]]

--------------------------------override functions----------------------

function dtest:onInit( userData, netData )
	
end

function dtest:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(dtest, "dtest")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("dtest", dtest)
