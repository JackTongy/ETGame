
-- local RAW_require = require

-- require = function( name )
-- 	if package.loaded[name] == nil then
-- 		local ret = RAW_require( name )
-- 		print('Load Model:'.. name )
-- 		return ret
-- 	else
-- 		return package.loaded[name]
-- 	end
-- end

require 'framework.basic.Debug'

require 'framework.basic.Constants'

require 'framework.basic.BasicClass'
require 'framework.basic.RawCFunc'

require 'framework.basic.MetaHelper'

require "framework.basic.List"
require "framework.basic.IO"
require "framework.basic.String"
require "framework.basic.Table"
require "framework.basic.Localize"

require "framework.basic.Device"
require "framework.basic.DB"

require "framework.basic.GleeCore"
require 'framework.basic.Redirect'

require 'framework.interface.LuaInterface'
require 'framework.interface.LuaController'
require 'framework.interface.LuaDialog'
require 'framework.interface.LuaMenu'
require 'framework.interface.LuaNetView'

require "framework.net.Net"

require "framework.event.EventCenter"
require "framework.helper.Utils"

require "framework.xml.LuaXml"

require 'framework.helper.Security'

require 'framework.helper.MusicHelper'

XMLFactory:setManifestToLayerOrScene(true)

local EventCenter = require "framework.event.EventCenter"
--[[
	处理c++事件中心的消息
--]]
GleeCore:unregisterScriptHandlerEventManager()
GleeCore:registerScriptHandlerEventManager( function ( event,ccobj,tag )
	if tag == 0 then
		EventCenter.eventInput(tostring(event),ccobj)
	else
		EventCenter.eventInput(tostring(event),{ccobj,tag})
	end
end)
