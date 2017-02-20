local config = require "Config"



local GameStart = class(LuaController)

function GameStart:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."GameStart.cocos.zip")
    return self._factory:createDocument("GameStart.cocos")
end

--@@@@[[[[
function GameStart:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_bg_pic1 = set:getElfNode("root_bg_pic1")
   self._root_bg_pic2 = set:getElfNode("root_bg_pic2")
   self._root_line = set:getElfNode("root_line")
   self._root_start = set:getAddColorNode("root_start")
end
--@@@@]]]]

--------------------------------override functions----------------------
function GameStart:onInit( userData, netData )
	self:initBg()
	
	SystemHelper:setIgnoreBigTimeDelta(true)

	local FightController = require 'FightController'

	require 'LoadFight'

	local Swf = require 'framework.swf.Swf'

	local func = function ( ... )
		-- body
		print('进入战斗!!!!!!!')

		FightController:start()

		if not userData or not userData.type then
			GleeCore:replaceController('FightScene', { type = 'pvp', data = userData} )
		else
			GleeCore:replaceController('FightScene', userData)
		end

	end
	
	--播放动画, 然后开始
	local nodeMap = {
		-- self._root_bg,
		self._root_line,
		self._root_start
	}

	local startSwf = Swf.new('Swf_Kaisi', nodeMap)
	startSwf:play(nil, nil, func)
	
	require 'framework.helper.MusicHelper'.playBackgroundMusic(require 'Res'.Music.battle, true)

	-- self:runWithDelay(func, 5)
end

function GameStart:initBg()
	-- body
	local resid1, resid2 = require 'BattleBgManager'.getLastBgResid()
	self._root_bg_pic1:setResid(resid1)
	self._root_bg_pic2:setResid(resid2)

	-- self._root_bg_pic1:setColorf(1,0,0,1)
	-- self._root_bg_pic2:setColorf(1,1,0,1)
end

function GameStart:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(GameStart, "GameStart")


--------------------------------register--------------------------------
GleeCore:registerLuaController("GameStart", GameStart)


