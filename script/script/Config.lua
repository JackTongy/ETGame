local Config = {}

Config.COCOS_ZIP_DIR = "zip/"
-- config.DB = "config/V6.85_cn.db"
Config.LANGUAGE = "language/Localizable_cn.plist"

-- Config.SocketAddr = "192.168.1.213"	-- 内网
-- Config.SocketAddr = "192.168.1.114"	-- 内网
-- Config.SocketAddr = "120.193.5.146"	-- 外网
-- Config.SocketAddr = "115.29.199.47"
Config.SocketAddr = "119.81.62.118"

Config.SocketPort = 3001

Config.RoleID = 1

Config.ServerID = 1

Config.Main_Path = nil

Config.Extra_Path = nil

Config.AutoCHomeTest = false

Config.AutoArenaTest = false

Config.AutoArenaBattleTest = false

Config.ArenaCalcBefore = false

Config.ArenaCalcAfter = true

--[[
1.Chome AutoCHomeTest
--]]

--[[
2.Arena AutoArenaTest AutoCHomeTest AutoArenaBattleTest
--]]

Config.InfoName = require 'script.info.Info'.CFG_NAME
Config.LangName  = require 'script.info.Info'.LANG_NAME

return Config