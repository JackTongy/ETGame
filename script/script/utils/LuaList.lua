-- require "framework.basic.BasicClass"
local LuaList = class()

function LuaList:ctor( listNode, createSet, assignSet )
	self._listNode = listNode
	self._listNode:getContainer():removeAllChildrenWithCleanup(true)
	self._createSet = createSet
	self._assignSet = assignSet

	self._setArray = {}
end

function LuaList:update( dataArray, layout, loadCountFirstTime )
	if dataArray then
		self:updateCellNodeList(dataArray, loadCountFirstTime)
		for i,v in ipairs(self._setArray) do
			local cell = self:getCellAtIndex(i)
			self._assignSet(cell, dataArray[i], i)
		end
		if layout == true then
			self._listNode:layout()
		else
			self._listNode:onScroll(nil, 0, 0)
		end
	end	
end

function LuaList:updateCellNodeList( dataArray, loadCountFirstTime )
	self._listNode:stopAllActions()
	local cellCount = #dataArray
	if #self._setArray > cellCount then
		for i=#self._setArray,cellCount + 1, -1 do
			self._setArray[i][1]:removeFromParentAndCleanup(true)
			table.remove(self._setArray, i)
		end
	elseif #self._setArray < cellCount then
		local count = cellCount - #self._setArray
		local loadCountFirst = loadCountFirstTime or 20
		local utils = require 'framework.helper.Utils'
		for i=1,count do
			if i < loadCountFirst then
				local set = self._createSet()
				local zOrder = self._listNode:getContainer():getChildrenCount() + 1
				self._listNode:getContainer():addChild(set[1], zOrder)
				table.insert(self._setArray, set)
			else
				utils.delay(function (  )
					local set = self._createSet()
					local zOrder = self._listNode:getContainer():getChildrenCount() + 1
					self._listNode:getContainer():addChild(set[1], zOrder)
					table.insert(self._setArray, set)
					self._assignSet(set, dataArray[zOrder], zOrder)
				end, 0.1 * (i - loadCountFirst), self._listNode)
			end
		end
	end
end

function LuaList:getCellAtIndex( index )
	return self._setArray[index]
end

return LuaList