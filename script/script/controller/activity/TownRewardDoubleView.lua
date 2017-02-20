local res = require "Res"

local update = function ( self, view )
	local data = require "ActivityInfo".getDataByType(12) 
	if data then
		local timeManager = require "TimeManager"
		local openTime = os.date("*t", timeManager.getTimestamp(data.OpenAt))
		local closeTime = os.date("*t", timeManager.getTimestamp(data.CloseAt))
		view["bg_time"]:setString(string.format(res.locString("Activity$TownDoubleTime"), openTime.month, openTime.day, openTime.hour, closeTime.month, closeTime.day, closeTime.hour))
		view["bg_btnGoToTown"]:setListener(function ( ... )
			self:close()
			GleeCore:pushController("CWorldMap")
		end)
		require "LangAdapter".selectLang(nil,nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
			view["bg_time"]:setString(string.format(res.locString("Activity$TownDoubleTime"), openTime.day, openTime.month, openTime.hour, closeTime.day, closeTime.month, closeTime.hour))
		end)
		require "LangAdapter".LabelNodeAutoShrink(view["bg_time"], 380)
	end
end

return {update = update}