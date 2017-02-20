local config = require "Config"

local Weapon1 = class(LuaController)

function Weapon1:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."Weapon1.cocos.zip")
    return self._factory:createDocument("Weapon1.cocos")
end

--@@@@[[[[  created at Thu Apr 24 16:33:21 CST 2014 By null
function Weapon1:onInitXML()
    local set = self._set
   self._DanShouWuQi0 = set:getFlashMainNode("DanShouWuQi0")
   self._DanShouWuQi0_root = set:getElfNode("DanShouWuQi0_root")
   self._DanShouWuQi0_root_ShouZuo = set:getElfNode("DanShouWuQi0_root_ShouZuo")
   self._DanShouWuQi0_root_ShouZuo_WuQiYou = set:getElfNode("DanShouWuQi0_root_ShouZuo_WuQiYou")
   self._DanShouWuQi0_root_TuiYou = set:getElfNode("DanShouWuQi0_root_TuiYou")
   self._DanShouWuQi0_root_TuiZuo = set:getElfNode("DanShouWuQi0_root_TuiZuo")
   self._DanShouWuQi0_root_ShenQian = set:getElfNode("DanShouWuQi0_root_ShenQian")
   self._DanShouWuQi0_root_Tou = set:getElfNode("DanShouWuQi0_root_Tou")
   self._DanShouWuQi0_root_ShouYou = set:getElfNode("DanShouWuQi0_root_ShouYou")
   self._button = set:getButtonNode("button")
end
--@@@@]]]]

--------------------------------override functions----------------------
local animates = {
   "单手武器待机",
   "虚弱待机",
   "单手武器普通移动",
   "虚弱移动",
   "单手近战攻击",
   "单手武器暴击",
   "冲锋",
   "击退"
}

function Weapon1:onInit( userData, netData )
   	local index = 1
	self._button:setListener(function ( ... )
      -- body
      	if index > #animates then index = 1 end
      		self._DanShouWuQi0:play( animates[index], function()
      			print("finished "..animates[index])
      		end)

      		print('play2:'..animates[index])
      	index = index + 1
   	end)
end

function Weapon1:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(Weapon1, "Weapon1")


--------------------------------register--------------------------------
GleeCore:registerLuaController("Weapon1", Weapon1)


