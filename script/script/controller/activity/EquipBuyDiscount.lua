-- local Config = require "Config"

-- local EquipBuyDiscount = class(LuaController)

-- function EquipBuyDiscount:createDocument()
--     self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."EquipBuyDiscount.cocos.zip")
--     return self._factory:createDocument("EquipBuyDiscount.cocos")
-- end

-- --@@@@[[[[
-- function EquipBuyDiscount:onInitXML()
-- 	local set = self._set
--     self._bg_btn = set:getClickNode("bg_btn")
--     self._bg_btn_label = set:getLabelNode("bg_btn_label")
--     self._bg_discount = set:getLabelNode("bg_discount")
--     self._bg_time = set:getLabelNode("bg_time")
-- --    self._@view = set:getElfNode("@view")
-- end
-- --@@@@]]]]

-- --------------------------------override functions----------------------
-- function EquipBuyDiscount:onInit( userData, netData )
	
-- end

-- function EquipBuyDiscount:onBack( userData, netData )
	
-- end

-- --------------------------------custom code-----------------------------


-- --------------------------------class end-------------------------------
-- require 'framework.basic.MetaHelper'.classDefinitionEnd(EquipBuyDiscount, "EquipBuyDiscount")


-- --------------------------------register--------------------------------
-- GleeCore:registerLuaController("EquipBuyDiscount", EquipBuyDiscount)

local formatTime = function ( time )
	local timestamp = require 'TimeManager'.getTimestamp(time)
  	local ldt = os.date('*t',timestamp)
  	local ret = require 'LangAdapter'.selectLangkv({German=function ( ... )
      return string.format(require 'Res'.locString('Activity$DateFormat1'),ldt.day,ldt.month,ldt.hour)
  	end})

  	return ret or string.format(require "Res".locString("Activity$DateFormat1"),ldt.month,ldt.day,ldt.hour)
end

local update = function ( self,view )
	local actData = require "ActivityInfo".getDataByType(24)
	local discount = tostring(math.floor(actData.Data.Discount*100+0.5)/10)
	selectLang(nil,nil,nil,nil,function (  )
		discount = string.format("%d%%OFF",100-math.floor(actData.Data.Discount*100+0.5))
		view["bg_discount"]:setPosition(60,150)
	end,nil,nil,nil,nil,function (  )
		discount = string.format("%d%%Rabatt",100-math.floor(actData.Data.Discount*100+0.5))
		view["bg_discount"]:setPosition(67,150)
	end)
	view["bg_discount"]:setString(discount)

	view["bg_time"]:setString(string.format("%s-%s",formatTime(actData.OpenAt),formatTime(actData.CloseAt)))
	view["bg_btn"]:setListener(function ( ... )
		local unlockLv = require "UnlockManager":getUnlockLv("MagicBoxUnlock")
		if require "UserInfo".getLevel()>=unlockLv then
			self:close()
			require "framework.sync.TimerHelper".tick(function ( ... )
				GleeCore:showLayer("DMagicBox")
				return true
			end)
		else
			self:toast(string.format(require "Res".locString("Activity$EquipCenterLockTip"),unlockLv))
		end	
	end)
end

return {update = update}
