--[[
  其中标签页 用法示例：
]]
local TabEmpty = class(TabLayer)

function TabEmpty:onInitXML( )
  local set = self._set
  
end

function TabEmpty:onEnter( userData )
	--从非选中状态变为选中状态
	--self._parent
end

function TabEmpty:onLeave( )
	--从选中状态变为非选中状态
end

function TabEmpty:onRelease(  )
	--被移除
end


return TabEmpty