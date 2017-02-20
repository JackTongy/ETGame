local EventCenter 			= require 'EventCenter'
local FightEvent 			= require 'FightEvent'
local Res 					= require 'Res'
local FightTimer 			= require 'FightTimer'
local FightConfig			= require 'FightConfig'
local FightSettings 		= require 'FightSettings'
local UIHelper 				= require 'UIHelper'
local StringViewHelper 		= require 'StringViewHelper'
local Swf 					= require 'framework.swf.Swf'

local RoundView = class(require 'BasicView')

function RoundView:ctor(luaset, document)
	-- body
	self._luaset 	= luaset
	self._document 	= document

	--左上角
	self._smallRoundNodes = {
		self._luaset['uiLayer_lt_boshu_llayout_n1'],
		self._luaset['uiLayer_lt_boshu_llayout_n2'],
		self._luaset['uiLayer_lt_boshu_llayout_n3'],
		self._luaset['uiLayer_lt_boshu_llayout_n4'],
		self._luaset['uiLayer_lt_boshu_llayout_n5'],
	}

	--中间每回合
	--uiLayer_labels_RoundView_label_n4
	self._bigRoundNodes = {
		self._luaset['uiLayer_labels_RoundView_label_n0'],
		self._luaset['uiLayer_labels_RoundView_label_n1'],
		self._luaset['uiLayer_labels_RoundView_label_n2'],
		self._luaset['uiLayer_labels_RoundView_label_n3'],
		self._luaset['uiLayer_labels_RoundView_label_n4'],
	}

	self:initEvents()
end

function RoundView:initEvents()
	-- body
	EventCenter.addEventFunc(FightEvent.Pve_NextWaveComing, function ( data )
		-- body
		--[[
		data.waveIndex, data.maxWaveIndex
		--]]
		local str = string.format('%d/%d', data.waveIndex, data.maxWaveIndex)
		
		StringViewHelper.setRoundSmallString( self._smallRoundNodes, str );

		StringViewHelper.setRoundBigString( self._bigRoundNodes, str );

		local nodemap = {
			[1] = self._luaset['layer'],
			[2] = self._luaset['uiLayer_labels_RoundView_bar'],
			[3] = self._luaset['uiLayer_labels_RoundView_label'],
		}

		local myswf = Swf.new('Swf_HuiHe', nodemap)
		myswf:play()

		local Swf_HuiHe = require 'Swf_HuiHe'

		local strlen = #str
		for i=1, strlen do
			local num = self._bigRoundNodes[1]
			num:setVisible(false)

			num:runAction( Swf_HuiHe.createColorAction() )
		end

	end, 'Fight')
end


return RoundView

