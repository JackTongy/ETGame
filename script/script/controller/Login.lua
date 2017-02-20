local config = require "Config"

local Login = class(LuaController)

function Login:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."Login.cocos.zip")
    return self._factory:createDocument("Login.cocos")
end

--@@@@[[[[  created at Thu Apr 17 08:15:12 CST 2014 By null
function Login:onInitXML()
    local set = self._set
	self._bg = set:getElfNode("bg")
	self._serverList = set:getListNode("serverList")
	self._tab = set:getTabNode("tab")
	self._label = set:getLabelNode("label")
	self._tab = set:getTabNode("tab")
	self._label = set:getLabelNode("label")
	self._button = set:getButtonNode("button")
	self._shadow = set:getElfNode("shadow")
	self._shadow_info = set:getLabelNode("shadow_info")
	self._ActionHideWait = set:getElfAction("ActionHideWait")
	self._ActionShowWait = set:getElfAction("ActionShowWait")
--   self._@item = set:getElfNode("@item")
--   self._@item = set:getElfNode("@item")
end
--@@@@]]]]

--------------------------------override functions----------------------
local HasConnected

function Login:onInit( userData, netDat0a )

	local items = {
		{ addr='192.168.1.213',	port=2012,	title='内网213' },
		{ addr='192.168.1.225',	port=2012,	title='内网225' },
		{ addr='120.193.5.146',	port=2012,	title='外网146' },
		-- Config.SocketAddr = "120.193.5.146"	-- 外网
	} 

	assert(self._serverList)

	for i,v in ipairs (items) do 
		local lset = self:createLuaSet('@item')
		lset['label']:setString(v.title)
		lset['tab']:setListener(function ()
			self['addr'] = v.addr
			self['port'] = v.port
		end)
		self._serverList:addListItem( lset[1] )

		if i == 1 then
			lset['tab']:trigger(lset['tab'])
		end
	end

	self._serverList:layout()

	self._button:setListener(function ()
		if HasConnected then
			GleeCore:replaceController("PVPRoom", 2)
			return 
		end

		local addr = self['addr']
		local port = self['port']
		local client = require 'SocketClientPvp'

		self._shadow_info:setString('connect to '..addr..':'..port..'...')
   		client:connect(addr,port,function ( suc )

			if suc then
				require 'TimeManager'.serverTimeAdjust()

				local action = self._ActionHideWait:clone()
   				self._shadow:runElfAction(action)
   				self:setEnabled(true)

   				HasConnected = true

   				GleeCore:replaceController("PVPRoom", 2)
   				
			else
				self._shadow_info:setString('connect to '..addr..':'..port..' faild!')
				self:runWithDelay(function ( ... )
					-- body
					local action = self._ActionHideWait:clone()
   					self._shadow:runElfAction(action)
   					self:setEnabled(true)
				end, 3)
			end
   		end)

   		local action = self._ActionShowWait:clone()
   		self._shadow:runElfAction(action)
   		self:setEnabled(false)
	end)


	--test toast
	-- self:toast('hello world')
	
end

function Login:onBack( userData, netData )
	
end



--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(Login, "Login")


--------------------------------register--------------------------------
GleeCore:registerLuaController("Login", Login)


