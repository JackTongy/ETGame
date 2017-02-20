local IpadAdapter = {}

function IpadAdapter.adapt()
	-- body
	print('IpadAdapter.adapt')

	CCEGLView:sharedOpenGLView():setDesignResolutionSize(960,640, 5)
	CCDirector:sharedDirector():setProjection(kCCDirectorProjection2D)

	require 'framework.sync.TimerHelper'.tick(function ()
		-- body
		local scene = GleeControllerManager:getInstance():getRootScene()
		assert( scene )

		local layer = ElfLayer:create()

		-- 上下条
		local nodeUp = ElfNode:create()
		nodeUp:setAnchorPoint(ccp(0.5,0))
		nodeUp:setResid('ipad_up.png')
		nodeUp:setPosition(ccp(0, 320))
		nodeUp:setScale(960/1024)
		layer:addChild(nodeUp)

		local nodeDown = ElfNode:create()
		nodeDown:setAnchorPoint(ccp(0.5,1))
		nodeDown:setResid('ipad_down.png')
		nodeDown:setPosition(ccp(0, -320))
		nodeDown:setScale(960/1024)
		layer:addChild(nodeDown)

		-- 上下屏蔽
		local shieldUp = ShieldNode:create()
		shieldUp:setWidth(960)
		shieldUp:setHeight(200)
		shieldUp:setAnchorPoint(ccp(0.5,0))
		shieldUp:setPosition(ccp(0, 320))
		layer:addChild(shieldUp)

		local shieldDown = ShieldNode:create()
		shieldDown:setWidth(960)
		shieldDown:setHeight(200)
		shieldDown:setAnchorPoint(ccp(0.5,1))
		shieldDown:setPosition(ccp(0, -320))
		layer:addChild(shieldDown)

		scene:addChild(layer, 10000)
		return true
	end)
	

end

return IpadAdapter