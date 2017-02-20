local Utils = require 'framework.helper.Utils'

local Default = {}

-- 测试模式 Log打开
-- 测试模式 是否100%触发 Buff

Default.Debug = { 
	log = false, 
	trigger = false, 
	state = false, 
}

FileHelper:setWritableRelativePath('main/')
-- local read = Utils.readTableFromFile('../Default.lua')

-- if read then
-- 	Default.Debug = read
-- else
-- 	Utils.writeTableToFile(Default.Debug, '../Default.lua')
-- end

-- if Default.Debug.log then
-- 	--打开输出log
-- 	FileHelper:setRedirect(true)
-- end

local Config = require 'script.Config'
if Default.Debug.state or Config.AutoCHomeTest or Config.AutoArenaTest or Config.AutoArenaBattleTest then
 	CCDirector:sharedDirector():setDisplayStats(true);
else
	CCDirector:sharedDirector():setDisplayStats(false);
end


return Default