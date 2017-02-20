local config = require "Config"

local MainScene = class(LuaController)

function MainScene:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."MainScene.cocos.zip")
    return self._factory:createDocument("MainScene.cocos")
end

--@@@@[[[[
function MainScene:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._pveButton = set:getButtonNode("pveButton")
    self._pvpButton = set:getButtonNode("pvpButton")
    self._hero = set:getFlashMainNode("hero")
    self._debugCheckBox = set:getCheckBoxNode("debugCheckBox")
end
--@@@@]]]]

--------------------------------override functions----------------------

function MainScene:onInit( userData, netData )

	local function innerInit( )
		-- body
		self._hero:setScale(0.5)
		self._hero:getModifierControllerByName('#近战暴击'):setLoopMode(LOOP)
		
		self._pveButton:setListener(function ( ... )
			-- body
			-- print('pve !!!')
			-- GleeCore:replaceController('FightScene')
			-- require 'ServerController'.start()

			GleeCore:replaceController('SelectScene')
		end)

		self._pvpButton:setListener(function ( ... )
			-- body
			GleeCore:replaceController('Login')
		end)

	end

	innerInit()
end

function MainScene:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(MainScene, "MainScene")


--------------------------------register--------------------------------
GleeCore:registerLuaController("MainScene", MainScene)


