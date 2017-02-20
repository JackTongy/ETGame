local config = require "Config"
local FightSettings = require 'FightSettings'
local EventCenter = require 'EventCenter'
local FightEvent = require 'FightEvent'
local UIHelper = require 'UIHelper'
local Res = require 'Res'

local GamePause = class(LuaDialog)

function GamePause:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."GamePause.cocos.zip")
    return self._factory:createDocument("GamePause.cocos")
end

--@@@@[[[[
function GamePause:onInitXML()
	local set = self._set
    self._motion = set:getElfMotionNode("motion")
    self._motion_KeyStorage_show = set:getElfNode("motion_KeyStorage_show")
    self._motion_KeyStorage_show_root_Visible = set:getElfNode("motion_KeyStorage_show_root_Visible")
    self._motion_KeyStorage_show_root_Color = set:getElfNode("motion_KeyStorage_show_root_Color")
    self._motion_KeyStorage_hide = set:getElfNode("motion_KeyStorage_hide")
    self._motion_KeyStorage_hide_root_Visible = set:getElfNode("motion_KeyStorage_hide_root_Visible")
    self._motion_KeyStorage_hide_root_Color = set:getElfNode("motion_KeyStorage_hide_root_Color")
    self._motion_root = set:getElfNode("motion_root")
    self._motion_root_pane = set:getElfNode("motion_root_pane")
    self._motion_root_pane_p1 = set:getElfNode("motion_root_pane_p1")
    self._motion_root_pane_p1_btn0 = set:getColorClickNode("motion_root_pane_p1_btn0")
    self._motion_root_pane_p1_btn1 = set:getColorClickNode("motion_root_pane_p1_btn1")
    self._motion_root_pane_p2 = set:getElfNode("motion_root_pane_p2")
    self._motion_root_pane_p2_dialog_title = set:getLabelNode("motion_root_pane_p2_dialog_title")
    self._motion_root_pane_p2_btn1 = set:getClickNode("motion_root_pane_p2_btn1")
    self._motion_root_pane_p2_btn0 = set:getClickNode("motion_root_pane_p2_btn0")
    self._motion_root_pane_p2_richlabel = set:getRichLabelNode("motion_root_pane_p2_richlabel")
--    self._@rect = set:getRectangleNode("@rect")
end
--@@@@]]]]

--------------------------------override functions----------------------
function GamePause:onInit( userData, netData )
	-- print('GamePause')

  --[image=image/N_ZC_sc.png][/image]*1000
    FightSettings.pause()

    self._motion_root_pane_p2:setVisible(false)
    self._motion_root_pane_p1:setVisible(true)

    self._motion:runAnimate(0, 300, 'KeyStorage_show')

    self._motion_root_pane_p2_richlabel:setString(Res.locString('Battle$quitGameTips'))
    --退出
    self._motion_root_pane_p1_btn0:setTriggleSound( require 'Res'.Sound.back )
    self._motion_root_pane_p1_btn0:setListener(function ()
        -- body
        if require 'ServerRecord'.getMode() == 'arena-record' then
            --退出游戏
            self:close()
            FightSettings.resume()
            -- FightSettings.quit()
            -- GleeCore:popController()
            if require 'ServerRecord'.getMode() == 'champion' then
                UIHelper.toast2(Res.locString('Battle$CanNotBackOff'))--('这是荣誉之战,不能退缩!')
            else
                local data = require 'ServerRecord'.createGameOverData(false)

                if require 'ServerRecord'.getMode() == 'arena-record' then
                    data.directExit = true
                end

                EventCenter.eventInput(FightEvent.Pve_GameOverQuick, data )
            end

        else
            self._motion_root_pane_p2:setVisible(true)
            self._motion_root_pane_p1:setVisible(false)
        end

        -- self._motion_root_pane_p2:setVisible(true)
        -- self._motion_root_pane_p1:setVisible(false)
    end)

    --继续
    self._motion_root_pane_p1_btn1:setTriggleSound( require 'Res'.Sound.yes )
    self._motion_root_pane_p1_btn1:setListener(function ()
        -- body
        self._motion:setListener(function ()
            -- body
            self:close()
            
        end)
        self._motion:runAnimate(0, 300, 'KeyStorage_hide')
        FightSettings.resume()
    end)

    --是
    self._motion_root_pane_p2_btn0:setTriggleSound( require 'Res'.Sound.yes )
    self._motion_root_pane_p2_btn0:setListener(function ()
        -- body

        --退出游戏
        self:close()
        FightSettings.resume()
        -- FightSettings.quit()
        -- GleeCore:popController()
        if require 'ServerRecord'.getMode() == 'champion' then
            UIHelper.toast2(Res.locString('Battle$CanNotBackOff'))--('这是荣誉之战,不能退缩!')
        else
            local data = require 'ServerRecord'.createGameOverData(false)

            if require 'ServerRecord'.getMode() == 'arena-record' then
                data.directExit = true
            end

            EventCenter.eventInput(FightEvent.Pve_GameOverQuick, data )
        end
    end)

    --否
    self._motion_root_pane_p2_btn1:setTriggleSound( require 'Res'.Sound.back )
    self._motion_root_pane_p2_btn1:setListener(function ( ... )
        -- body
        self._motion:setListener(function ( ... )
            -- body
            self:close()
        end)
        self._motion:runAnimate(0, 300, 'KeyStorage_hide')
        FightSettings.resume()
    end)


end

function GamePause:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(GamePause, "GamePause")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("GamePause", GamePause)
