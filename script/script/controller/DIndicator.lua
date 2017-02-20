local Config = require "Config"
local constants = require 'framework.basic.Constants'
local layerManager = require "framework.interface.LuaLayerManager"

local DIndicator = class(LuaDialog)
local IndicatorCtrl = {}

function DIndicator:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DIndicator.cocos.zip")
    return self._factory:createDocument("DIndicator.cocos")
end

--@@@@[[[[
function DIndicator:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_fly = set:getElfNode("root_fly")
   self._root_fly_rect = set:getRectangleNode("root_fly_rect")
   self._root_fly_icon = set:getElfNode("root_fly_icon")
   self._root_fly_label = set:getLabelNode("root_fly_label")
   self._roate = set:getElfAction("roate")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DIndicator:onInit( userData, netData )
	self._index = constants.NET_VIEW_INDEX

	self:setRectColorA(IndicatorCtrl.getRectAlpha())

	self._root_fly_icon:runElfAction(self._roate:clone())
	local delay = IndicatorCtrl._Delay or userData.delay or 0.8
	self._root_fly:setVisible(false)
	self:runWithDelay(function ( ... )
		self._root_fly:setVisible(true)
	end,delay)
	
end

function DIndicator:onBack( userData, netData )
	
end

function DIndicator:getType()
	-- body
	return 'Layer'
end

--------------------------------custom code-----------------------------

function DIndicator:setRectColorA( alpha )
	self._root_fly_rect:setColorf(0,0,0,alpha)	
end

function DIndicator:notifyIndicator( show,delay )
	if show then
		self._root:stopAllActions()
	else
		self:runWithDelay(function ( ... )
			self:close()
		end,delay or 0.1,self._root)
	end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DIndicator, "DIndicator")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DIndicator", DIndicator)

--
local Cnt = 0
local DefaultAlpha = 0.8
local showIndicator = function ( delay )

	if not IndicatorCtrl._ignoreEnabled then

		local show = GleeCore:isRunningLayer('DIndicator')

		if Cnt > 0 and not show then
			GleeCore:showLayer('DIndicator',{delay=delay})
		-- elseif Cnt <= 0 and show then
			-- GleeCore:hideLayer('DIndicator')
		elseif show then
		    local dialog = layerManager.getRunningLayer('DIndicator')
		    dialog:notifyIndicator(Cnt > 0,delay)
		end

	end
	
end

IndicatorCtrl.show = function ( delay )
	Cnt = Cnt + 1
	showIndicator(delay)
end

IndicatorCtrl.hide = function ( delay )
	Cnt = Cnt - 1
	if Cnt < 0 then 
		Cnt = 0 
	end
	showIndicator( delay )
end

IndicatorCtrl.reset = function ( )
	Cnt = 0
	showIndicator()
end

IndicatorCtrl.getRectAlpha = function ( ... )
	return IndicatorCtrl._RectAlpha or DefaultAlpha
end

IndicatorCtrl.setRectAlpha = function ( alpha )
	IndicatorCtrl._RectAlpha = alpha
end

IndicatorCtrl.resetRectAlpha = function ( )
	IndicatorCtrl._RectAlpha = DefaultAlpha
end

IndicatorCtrl.setIgnoreEnabled = function ( ignoreEnabled )
	-- body
	IndicatorCtrl._ignoreEnabled = ignoreEnabled
end

IndicatorCtrl.setDealy = function ( dealy )
	IndicatorCtrl._Delay = dealy
end

return IndicatorCtrl
