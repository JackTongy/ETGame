local Log = {}

local Utils = require 'framework.helper.Utils'

Log.d = function ( data )
	-- body

	local message = Utils.dump(data)

	local info = string.format('debug:%s:%s', tostring(message), os.date() )
	--写文件
	print(info)
end

-- Log.d({"hello world", {"hello"}})

--重定向
--如果是要debug
-- FileHelper:setRedirect()

return Log