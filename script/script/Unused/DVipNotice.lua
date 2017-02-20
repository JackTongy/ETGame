local config = require "Config"

local DVipNotice = class(LuaController)

function DVipNotice:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."DVipNotice.cocos.zip")
    return self._factory:createDocument("DVipNotice.cocos")
end

--@@@@[[[[  created at Wed Jun 04 09:58:57 CST 2014 By null
function DVipNotice:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_elf = set:getElfNode("root_elf")
   self._root_elf_confirm = set:getButtonNode("root_elf_confirm")
   self._root_elf_confirm_des = set:getLabelNode("root_elf_confirm_des")
   self._root_elf_cancel = set:getButtonNode("root_elf_cancel")
   self._root_elf_cancel_des = set:getLabelNode("root_elf_cancel_des")
   self._root_elf_title = set:getLabelNode("root_elf_title")
   self._root_elf_cotent = set:getLabelNode("root_elf_cotent")
   self._root_elf_green = set:getLabelNode("root_elf_green")
   self._root_elf_layout_content0 = set:getRichLabelNode("root_elf_layout_content0")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DVipNotice:onInit( userData, netData )
	
end

function DVipNotice:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DVipNotice, "DVipNotice")


--------------------------------register--------------------------------
GleeCore:registerLuaController("DVipNotice", DVipNotice)


