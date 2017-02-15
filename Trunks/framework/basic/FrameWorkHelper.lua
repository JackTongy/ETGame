local metaHelper = require 'framework.basic.MetaHelper'

local helper = {}

local direct = CCDirector:sharedDirector()

function helper.getRunningScene()
	-- body
	return direct:getRunningScene()
end

function helper.getRunningController()
	-- body
	return GleeCore:getRunningController()
end

return metaHelper.createShell( helper )