---播放列表 保证只有 一个进行播放

local CallBackManager = class()

function CallBackManager:ctor(  )
	self._timeOut = nil
end

function CallBackManager:setCallback( timeOut )
	if self._timeOut then
		self._timeOut:dispose()
	end
	self._timeOut = timeOut
end

return CallBackManager