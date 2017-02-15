
local RAW_ElfEditBox_getText = ElfEditBox.getText
ElfEditBox.getText = function ( self )
	-- body
	if not tolua.isnull(self) then
		local ret = RAW_ElfEditBox_getText(self)
		if not ret or #ret == 0 then
			return ElfEditBox.getPlaceHolder(self)
		else
			return ret
		end
	end

	return 'ElfEditBox has disposed!'
end

if SystemHelper:getPlatFormID() == 13 then
	local RAW_ElfGrayNode_setGrayEnabled = ElfGrayNode.setGrayEnabled
	ElfGrayNode.setGrayEnabled = function ( self, enable )
		-- body
		if enable then
			self:setColorf(0.3,0.3,0.3,1)
		else 
			self:setColorf(1,1,1,1)
		end
	end
end

local RAW_LabelNode_setString = LabelNode.setString 
LabelNode.setString = function ( self, str )
	-- body
	if not tolua.isnull(self) then
		str = str or 'nil'
		RAW_LabelNode_setString(self, str)
	end
end


local Raw_ElfNode_setContentSize = ElfNode.setContentSize
ElfNode.setContentSize = function ( self, size )
	-- body
	Raw_ElfNode_setContentSize(self, size)

	local node_type = tolua.type(self)
	if node_type == 'ListNode' then
		local joint9 = self:findNodeByName('#joint9')
		local listscorll = self:findNodeByName('#ListScrollNode')
		if joint9 and listscorll then
			tolua.cast( joint9, 'Joint9Node' )
			tolua.cast( listscorll, 'ListScrollNode' )

			local orientation = self:getOrientation()
			if orientation == Horizontal or orientation == Horizontal_R2L then
				local offset = 9/2

				joint9:setWidth(size.width)
				joint9:setPosition(ccp(0, offset - size.height/2))

				listscorll:setFirstPoint(-size.width/2, offset - size.height/2)
				listscorll:setLastPoint(size.width/2,   offset - size.height/2)
			else
				local offset = 9/2
				
				joint9:setHeight(size.height)
				joint9:setPosition(ccp(size.width/2 - offset, 0))

				listscorll:setFirstPoint(size.width/2 - offset, size.height/2)
				listscorll:setLastPoint( size.width/2 - offset, -size.height/2)
			end
		end
	end
end


local Raw_ElfNode_setWidth = ElfNode.setWidth
ElfNode.setWidth = function ( self, width )
	-- body
	Raw_ElfNode_setWidth(self, width)

	local node_type = tolua.type(self)
	if node_type == 'ListNode' then
		local joint9 = self:findNodeByName('#joint9')
		local listscorll = self:findNodeByName('#ListScrollNode')
		if joint9 and listscorll then
			local size = { width = width, height = self:getHeight() }

			tolua.cast( joint9, 'Joint9Node' )
			tolua.cast( listscorll, 'ListScrollNode' )

			local orientation = self:getOrientation()
			if orientation == Horizontal or orientation == Horizontal_R2L then
				local offset = 9/2

				joint9:setWidth(size.width)
				joint9:setPosition(ccp(0, offset - size.height/2))

				listscorll:setFirstPoint(-size.width/2, offset - size.height/2)
				listscorll:setLastPoint(size.width/2,   offset - size.height/2)
			else
				local offset = 9/2
				
				joint9:setHeight(size.height)
				joint9:setPosition(ccp(size.width/2 - offset, 0))

				listscorll:setFirstPoint(size.width/2 - offset, size.height/2)
				listscorll:setLastPoint( size.width/2 - offset, -size.height/2)
			end
		end
	end
end

local Raw_ElfNode_setHeight = ElfNode.setHeight
ElfNode.setHeight = function ( self, height )
	-- body
	Raw_ElfNode_setHeight(self, height)

	local node_type = tolua.type(self)
	if node_type == 'ListNode' then
		local joint9 = self:findNodeByName('#joint9')
		local listscorll = self:findNodeByName('#ListScrollNode')
		if joint9 and listscorll then
			local size = { width = self:getWidth(), height = height }
			
			tolua.cast( joint9, 'Joint9Node' )
			tolua.cast( listscorll, 'ListScrollNode' )

			local orientation = self:getOrientation()
			if orientation == Horizontal or orientation == Horizontal_R2L then
				local offset = 9/2

				joint9:setWidth(size.width)
				joint9:setPosition(ccp(0, offset - size.height/2))

				listscorll:setFirstPoint(-size.width/2, offset - size.height/2)
				listscorll:setLastPoint(size.width/2,   offset - size.height/2)
			else
				local offset = 9/2
				
				joint9:setHeight(size.height)
				joint9:setPosition(ccp(size.width/2 - offset, 0))

				listscorll:setFirstPoint(size.width/2 - offset, 0)
				listscorll:setLastPoint( size.width/2 - offset, 0)
			end
		end
	end
end

-- local _Current_Music
-- local RAW_MusicFactory_playBackgroundMusic = MusicFactory.playBackgroundMusic
-- MusicFactory.playBackgroundMusic = function ( self, music, loop )
-- 	-- body
-- 	if _Current_Music ~= music then
-- 		_Current_Music = music
-- 		RAW_MusicFactory_playBackgroundMusic(  self, music, loop  )
-- 	end
-- end

-- local _Music_Stack = {}
-- MusicFactory.pushMusic = function ( self, isStop )
-- 	-- body
-- 	local music = MusicFactory:getBackgroundMusic() or ''
-- 	table.insert(_Music_Stack, music)

-- 	if isStop then
-- 		MusicFactory:stopBackgroundMusic()
-- 	end
-- end

-- MusicFactory.popMusic = function ( self )
-- 	-- body
-- 	local music = _Music_Stack[#_Music_Stack]
-- 	table.remove(_Music_Stack, #_Music_Stack)

-- 	MusicFactory:playBackgroundMusic( music )
-- end


-- local Raw_NodeSet_getScale9Node = NodeSet.getScale9Node
-- NodeSet.getScale9Node = function ( self, key )
-- 	-- body
-- end

-- local Raw_NodeSet_getRootScale9Node = NodeSet.getRootScale9Node
-- NodeSet.getRootScale9Node = function ( self )
-- 	-- body
-- end



-- local RAW_CCEGLView_setDesignResolutionSize = CCEGLView.setDesignResolutionSize
-- CCEGLView.setDesignResolutionSize = function ( self, w, h, t )
-- 	-- body
-- end

-- local GLView = CCEGLView:sharedOpenGLView()

-- local RAW_NodeHelper_getPositionInScreen = NodeHelper.getPositionInScreen
-- NodeHelper.getPositionInScreen = function ( self, node )
-- 	-- body
-- 	local pos = RAW_NodeHelper_getPositionInScreen(self, node)
-- 	local rect = GLView:getViewPortRect()

-- 	local scaleX = GLView:getScaleX()
-- 	local scaleY = GLView:getScaleY()

-- 	pos.x  = (pos.x  - rect.origin.x) / scaleX
-- 	pos.y  = (pos.y  - rect.origin.y) / scaleY
-- 	return pos 
-- end

-- local RAW_NodeHelper_setPositionInScreen = NodeHelper.setPositionInScreen
-- NodeHelper.setPositionInScreen = function ( self, node, pos)
-- 	-- body
-- 	local rect = GLView:getViewPortRect()

-- 	local scaleX = GLView:getScaleX()
-- 	local scaleY = GLView:getScaleY()

-- 	pos.x  = pos.x * scaleX + rect.origin.x
-- 	pos.y  = pos.y * scaleY + rect.origin.y

-- 	RAW_NodeHelper_setPositionInScreen(self, node, pos)

-- 	return pos 
-- end

print('=============ReDirect Completed!===============')