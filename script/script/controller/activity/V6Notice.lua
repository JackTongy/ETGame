-- local Config = require "Config"

-- local V6Notice = class(LuaController)

-- function V6Notice:createDocument()
--     self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."V6Notice.cocos.zip")
--     return self._factory:createDocument("V6Notice.cocos")
-- end

--@@@@[[[[
-- function V6Notice:onInitXML()
-- 	local set = self._set
--     self._bg_btn = set:getClickNode("bg_btn")
--     self._bg_btn_label = set:getLabelNode("bg_btn_label")
--     self._bg_icon = set:getElfNode("bg_icon")
--     self._bg_iconBtn = set:getButtonNode("bg_iconBtn")
--     self._bg_starLayout = set:getLayoutNode("bg_starLayout")
--     self._bg_layout_discount = set:getLabelNode("bg_layout_discount")
-- --    self._@view = set:getElfNode("@view")
-- --    self._@star = set:getElfNode("@star")
-- end
--@@@@]]]]

-- --------------------------------override functions----------------------
-- function V6Notice:onInit( userData, netData )
	
-- end

-- function V6Notice:onBack( userData, netData )
	
-- end

-- --------------------------------custom code-----------------------------


-- --------------------------------class end-------------------------------
-- require 'framework.basic.MetaHelper'.classDefinitionEnd(V6Notice, "V6Notice")


-- --------------------------------register--------------------------------
-- GleeCore:registerLuaController("V6Notice", V6Notice)

local res = require "Res"

local update = function ( self,view )
	view["bg_layout_discount"]:setString(5000)
	selectLang(nil,nil,function ( ... )
		view["bg_layout_discount"]:removeFromParentAndCleanup(true)
		view["bg_layout_#l2"]:removeFromParentAndCleanup(true)
		view["bg_layout_#l1"]:setString(res.locString("Activity$V6NoticeDes2"))
		view["bg_#layout"]:layout()
	end)
	
	local pet = require "PetInfo".getPetInfoByPetId(145)
	require "Res".setPetDetail(view["bg_icon"],pet)
	require "PetNodeHelper".updateStarLayout(view["bg_starLayout"],nil,145)
	view["bg_iconBtn"]:setListener(function ( ... )
		GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
	end)

	local vip = require "UserInfo".getVipLevel()
	if vip>=6 then
		view["bg_btn_label"]:setString(res.locString("Global$Receive"))
	end

	view["bg_btn"]:setListener(function ( ... )
		self:close()
		require "framework.sync.TimerHelper".tick(function ( ... )
			GleeCore:showLayer("DRecharge",vip>=6 and {ShowIndex = 3})
			return true
		end)
	end)
end

return {update = update}
