local Config = require "Config"

local TLGuildTreasure = class(TabLayer)

function TLGuildTreasure:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."TLGuildTreasure.cocos.zip")
    return self._factory:createDocument("TLGuildTreasure.cocos")
end

--@@@@[[[[
function TLGuildTreasure:onInitXML()
    local set = self._set
--   self._@view = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------

function TLGuildTreasure:onInit( userData, netData )
	local set = require "HuntHelper".getTreasureRootNode()
	self._viewSet[1]:addChild(set[1])
end

function TLGuildTreasure:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TLGuildTreasure, "TLGuildTreasure")


return TLGuildTreasure