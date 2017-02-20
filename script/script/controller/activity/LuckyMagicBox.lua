-- local Config = require "Config"

-- local LuckyMagicBox = class(LuaController)

-- function LuckyMagicBox:createDocument()
--     self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."LuckyMagicBox.cocos.zip")
--     return self._factory:createDocument("LuckyMagicBox.cocos")
-- end

--@@@@[[[[
-- function LuckyMagicBox:onInitXML()
-- 	local set = self._set
--     self._bg_btn = set:getClickNode("bg_btn")
--     self._bg_btn_label = set:getLabelNode("bg_btn_label")
--     self._bg_time = set:getLabelNode("bg_time")
--     self._bg_layout_maxCount = set:getLabelNode("bg_layout_maxCount")
-- --    self._@view = set:getElfNode("@view")
-- end
--@@@@]]]]

-- --------------------------------override functions----------------------
-- function LuckyMagicBox:onInit( userData, netData )
	
-- end

-- function LuckyMagicBox:onBack( userData, netData )
	
-- end

-- --------------------------------custom code-----------------------------


-- --------------------------------class end-------------------------------
-- require 'framework.basic.MetaHelper'.classDefinitionEnd(LuckyMagicBox, "LuckyMagicBox")


-- --------------------------------register--------------------------------
-- GleeCore:registerLuaController("LuckyMagicBox", LuckyMagicBox)

local formatTime = function ( time )
	local timestamp = require 'TimeManager'.getTimestamp(time)
  	local ldt = os.date('*t',timestamp)
  	local ret = require 'LangAdapter'.selectLangkv({German=function ( ... )
      return string.format(require 'Res'.locString('Activity$DateFormat1'),ldt.day,ldt.month,ldt.hour)
  	end})

  	return ret or string.format(require "Res".locString("Activity$DateFormat1"),ldt.month,ldt.day,ldt.hour)
end

local update = function ( self,view )
	require "LangAdapter".setVisible(view["bg_#layout"],nil,nil,nil,nil,nil,nil,nil,nil,nil,false)

	local actData = require "ActivityInfo".getDataByType(23)
	view["bg_layout_maxCount"]:setString(require "Toolkit".getLuckyMagicBoxMaxCount(actData))
	view["bg_time"]:setString(string.format("%s-%s",formatTime(actData.OpenAt),formatTime(actData.CloseAt)))
	view["bg_btn"]:setListener(function ( ... )
		local unlockLv = require "UnlockManager":getUnlockLv("MagicBoxUnlock")
		if require "UserInfo".getLevel()>=unlockLv then
			self:close()
			require "framework.sync.TimerHelper".tick(function ( ... )
				GleeCore:showLayer("DMagicBox",{ShowIndex = 2})
				return true
			end)
		else
			self:toast(string.format(require "Res".locString("Activity$EquipCenterLockTip"),unlockLv))
		end
	end)
end

return {update = update}
