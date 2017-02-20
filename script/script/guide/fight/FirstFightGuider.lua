local Config        = require 'Config'
local CfgHelper     = require 'CfgHelper'
local FightSettings = require 'FightSettings'

local FirstFightGuider = class(LuaMenu)

function FirstFightGuider:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."FirstFightGuider.cocos.zip")
    return self._factory:createDocument("FirstFightGuider.cocos")
end

--@@@@[[[[
function FirstFightGuider:onInitXML()
	local set = self._set
    self._arrow1 = set:getElfMotionNode("arrow1")
    self._arrow1_KeyStorage = set:getElfNode("arrow1_KeyStorage")
    self._arrow1_KeyStorage_arr_Position = set:getElfNode("arrow1_KeyStorage_arr_Position")
    self._arrow1_KeyStorage_p0_Position = set:getElfNode("arrow1_KeyStorage_p0_Position")
    self._arrow1_KeyStorage_p1_Position = set:getElfNode("arrow1_KeyStorage_p1_Position")
    self._arrow1_KeyStorage_p2_Position = set:getElfNode("arrow1_KeyStorage_p2_Position")
    self._arrow1_KeyStorage_p3_Position = set:getElfNode("arrow1_KeyStorage_p3_Position")
    self._arrow1_KeyStorage_p0_Visible = set:getElfNode("arrow1_KeyStorage_p0_Visible")
    self._arrow1_KeyStorage_p1_Visible = set:getElfNode("arrow1_KeyStorage_p1_Visible")
    self._arrow1_KeyStorage_p2_Visible = set:getElfNode("arrow1_KeyStorage_p2_Visible")
    self._arrow1_KeyStorage_p3_Visible = set:getElfNode("arrow1_KeyStorage_p3_Visible")
    self._arrow1_KeyStorage_p4_Visible = set:getElfNode("arrow1_KeyStorage_p4_Visible")
    self._arrow1_KeyStorage_p4_Position = set:getElfNode("arrow1_KeyStorage_p4_Position")
    self._arrow1_root = set:getElfNode("arrow1_root")
    self._arrow1_root_arr = set:getElfNode("arrow1_root_arr")
    self._arrow1_root_p0 = set:getElfNode("arrow1_root_p0")
    self._arrow1_root_p1 = set:getElfNode("arrow1_root_p1")
    self._arrow1_root_p2 = set:getElfNode("arrow1_root_p2")
    self._arrow1_root_p3 = set:getElfNode("arrow1_root_p3")
    self._arrow1_root_p4 = set:getElfNode("arrow1_root_p4")
    self._arrow2 = set:getElfMotionNode("arrow2")
    self._arrow2_KeyStorage = set:getElfNode("arrow2_KeyStorage")
    self._arrow2_KeyStorage_arr_Position = set:getElfNode("arrow2_KeyStorage_arr_Position")
    self._arrow2_KeyStorage_p0_Position = set:getElfNode("arrow2_KeyStorage_p0_Position")
    self._arrow2_KeyStorage_p1_Position = set:getElfNode("arrow2_KeyStorage_p1_Position")
    self._arrow2_KeyStorage_p2_Position = set:getElfNode("arrow2_KeyStorage_p2_Position")
    self._arrow2_KeyStorage_p3_Position = set:getElfNode("arrow2_KeyStorage_p3_Position")
    self._arrow2_KeyStorage_p0_Visible = set:getElfNode("arrow2_KeyStorage_p0_Visible")
    self._arrow2_KeyStorage_p1_Visible = set:getElfNode("arrow2_KeyStorage_p1_Visible")
    self._arrow2_KeyStorage_p2_Visible = set:getElfNode("arrow2_KeyStorage_p2_Visible")
    self._arrow2_KeyStorage_p3_Visible = set:getElfNode("arrow2_KeyStorage_p3_Visible")
    self._arrow2_KeyStorage_p4_Visible = set:getElfNode("arrow2_KeyStorage_p4_Visible")
    self._arrow2_KeyStorage_p4_Position = set:getElfNode("arrow2_KeyStorage_p4_Position")
    self._arrow2_root = set:getElfNode("arrow2_root")
    self._arrow2_root_arr = set:getElfNode("arrow2_root_arr")
    self._arrow2_root_p0 = set:getElfNode("arrow2_root_p0")
    self._arrow2_root_p1 = set:getElfNode("arrow2_root_p1")
    self._arrow2_root_p2 = set:getElfNode("arrow2_root_p2")
    self._arrow2_root_p3 = set:getElfNode("arrow2_root_p3")
    self._arrow2_root_p4 = set:getElfNode("arrow2_root_p4")
    self._arrow3 = set:getElfMotionNode("arrow3")
    self._arrow3_KeyStorage = set:getElfNode("arrow3_KeyStorage")
    self._arrow3_KeyStorage_arr_Position = set:getElfNode("arrow3_KeyStorage_arr_Position")
    self._arrow3_root = set:getElfNode("arrow3_root")
    self._arrow3_root_arr = set:getElfNode("arrow3_root_arr")
    self._arrow4 = set:getElfMotionNode("arrow4")
    self._arrow4_KeyStorage = set:getElfNode("arrow4_KeyStorage")
    self._arrow4_KeyStorage_arr_Position = set:getElfNode("arrow4_KeyStorage_arr_Position")
    self._arrow4_root = set:getElfNode("arrow4_root")
    self._arrow4_root_arr = set:getElfNode("arrow4_root_arr")
    self._arrow5 = set:getElfMotionNode("arrow5")
    self._arrow5_KeyStorage = set:getElfNode("arrow5_KeyStorage")
    self._arrow5_KeyStorage_arr_Position = set:getElfNode("arrow5_KeyStorage_arr_Position")
    self._arrow5_KeyStorage_p0_Position = set:getElfNode("arrow5_KeyStorage_p0_Position")
    self._arrow5_KeyStorage_p1_Position = set:getElfNode("arrow5_KeyStorage_p1_Position")
    self._arrow5_KeyStorage_p2_Position = set:getElfNode("arrow5_KeyStorage_p2_Position")
    self._arrow5_KeyStorage_p3_Position = set:getElfNode("arrow5_KeyStorage_p3_Position")
    self._arrow5_KeyStorage_p0_Visible = set:getElfNode("arrow5_KeyStorage_p0_Visible")
    self._arrow5_KeyStorage_p1_Visible = set:getElfNode("arrow5_KeyStorage_p1_Visible")
    self._arrow5_KeyStorage_p2_Visible = set:getElfNode("arrow5_KeyStorage_p2_Visible")
    self._arrow5_KeyStorage_p3_Visible = set:getElfNode("arrow5_KeyStorage_p3_Visible")
    self._arrow5_KeyStorage_p4_Visible = set:getElfNode("arrow5_KeyStorage_p4_Visible")
    self._arrow5_KeyStorage_p4_Position = set:getElfNode("arrow5_KeyStorage_p4_Position")
    self._arrow5_root = set:getElfNode("arrow5_root")
    self._arrow5_root_arr = set:getElfNode("arrow5_root_arr")
    self._arrow5_root_p0 = set:getElfNode("arrow5_root_p0")
    self._arrow5_root_p1 = set:getElfNode("arrow5_root_p1")
    self._arrow5_root_p2 = set:getElfNode("arrow5_root_p2")
    self._arrow5_root_p3 = set:getElfNode("arrow5_root_p3")
    self._arrow5_root_p4 = set:getElfNode("arrow5_root_p4")
    self._arrow6 = set:getElfMotionNode("arrow6")
    self._arrow6_KeyStorage = set:getElfNode("arrow6_KeyStorage")
    self._arrow6_KeyStorage_arr_Position = set:getElfNode("arrow6_KeyStorage_arr_Position")
    self._arrow6_KeyStorage_p0_Position = set:getElfNode("arrow6_KeyStorage_p0_Position")
    self._arrow6_KeyStorage_p1_Position = set:getElfNode("arrow6_KeyStorage_p1_Position")
    self._arrow6_KeyStorage_p2_Position = set:getElfNode("arrow6_KeyStorage_p2_Position")
    self._arrow6_KeyStorage_p3_Position = set:getElfNode("arrow6_KeyStorage_p3_Position")
    self._arrow6_KeyStorage_p0_Visible = set:getElfNode("arrow6_KeyStorage_p0_Visible")
    self._arrow6_KeyStorage_p1_Visible = set:getElfNode("arrow6_KeyStorage_p1_Visible")
    self._arrow6_KeyStorage_p2_Visible = set:getElfNode("arrow6_KeyStorage_p2_Visible")
    self._arrow6_KeyStorage_p3_Visible = set:getElfNode("arrow6_KeyStorage_p3_Visible")
    self._arrow6_KeyStorage_p4_Visible = set:getElfNode("arrow6_KeyStorage_p4_Visible")
    self._arrow6_KeyStorage_p4_Position = set:getElfNode("arrow6_KeyStorage_p4_Position")
    self._arrow6_root = set:getElfNode("arrow6_root")
    self._arrow6_root_arr = set:getElfNode("arrow6_root_arr")
    self._arrow6_root_p0 = set:getElfNode("arrow6_root_p0")
    self._arrow6_root_p1 = set:getElfNode("arrow6_root_p1")
    self._arrow6_root_p2 = set:getElfNode("arrow6_root_p2")
    self._arrow6_root_p3 = set:getElfNode("arrow6_root_p3")
    self._arrow6_root_p4 = set:getElfNode("arrow6_root_p4")
--    self._@bg = set:getElfNode("@bg")
end
--@@@@]]]]

--------------------------------override functions----------------------
local EventCenter   = require 'EventCenter'
local FightEvent    = require 'FightEvent'

function FirstFightGuider:initEvents()
    -- body
    -- Dialogue
    --  [21] = {    ID = 21,    CID = 302,  PetID = -1, Content = [[有敌人靠近啦！主人，一旦他们走到最右侧，战斗就会失败，所以要在那之前把他们全部消灭！]],   Type = 0,   Sound = [[htp_battle_07.mp3]],},

    EventCenter.addEventFunc(FightEvent.FirstFightGuider_ShowArrow, function ( data )
        -- body
        local index = data.index
        assert(index)

        print('FirstFightGuider_ShowArrow '..index)

        if index == 5 then
            GleeCore:showLayer('DGuide', { CID = 302, callback = function ()
                -- body
                FightSettings.resume()
                GleeCore:hideLayer('DGuide', nil, '-first')
            end,
            initcall = function ()
                -- body
                FightSettings.pause()
            end}, '-first')
            
            return nil
        end
        
        local arrowMotion
        if index == 1 then
            arrowMotion = self._arrow1
        elseif index == 2 then
            arrowMotion = self._arrow2
        elseif index == 3 then
            arrowMotion = self._arrow3
        elseif index == 4 then
            arrowMotion = self._arrow4

        elseif index == 6 then
            arrowMotion = self._arrow5
        elseif index == 7 then
            arrowMotion = self._arrow6
        elseif index == 8 then
            arrowMotion = self._arrow7
        elseif index == 9 then
            arrowMotion = self._arrow8
        end

        if arrowMotion then

            local life = 2000*arrowMotion:getMotionSpeed()
            arrowMotion:setVisible(true)
            arrowMotion:setListener(function ()
                arrowMotion:setVisible(false)
            end)
            arrowMotion:runAnimate(0, life, 'KeyStorage')
        end

    end, 'Fight')


    local player1_id = 4 --index1
    local player2_id = 3 --index2

    local idIndexMap = {
        [4] = 'index1',
        [3] = 'index2',
    }

    local idIndexMap2 = {
        [4] = 'index3',
        [3] = 'index4',
    }

    self._touchPlayerMap = {}
    -- EventCenter.eventInput(FightEvent.FingerView_goToPosition, { player=player, pos = pos} )
    EventCenter.addEventFunc(FightEvent.FingerView_goToPosition, function ( data )
        -- body
        local player = data.player
        if player then
            local playerId = player.roleDyVo.playerId
            local key = idIndexMap[playerId]
            if key then
                self._touchPlayerMap[key] = true
            end
        end

    end, 'Fight')

     -- EventCenter.eventInput(FightEvent.FingerView_goToTarget, {player1=player1, player2=player2, isfriend=isfriend} )
    EventCenter.addEventFunc(FightEvent.FingerView_goToTarget, function ( data )
        -- body
        local player = data.player1
        if player then
            local playerId = player.roleDyVo.playerId
            local key = idIndexMap[playerId]
            if key then
                self._touchPlayerMap[key] = true
            end
        end

        player = data.player2
        if player then
            local playerId = player.roleDyVo.playerId
            local key = idIndexMap[playerId]
            if key then
                self._touchPlayerMap[key] = true
            end
        end
    end, 'Fight')

    -- EventCenter.eventInput(FightEvent.Pve_TriggerBigSkill, data)
    EventCenter.addEventFunc(FightEvent.Pve_TriggerBigSkill, function ( data )
        -- body
        print('Pve_TriggerBigSkill')
        print(data)
        
        local playerId = data.playerId
        local key = idIndexMap2[playerId]

        if key then
            self._touchPlayerMap[key] = true
        end
    end, 'Fight')

    -- EventCenter.addEventFunc(FightEvent.Pve_SetMana, function ( data )
    --     -- body
    --     local playerId  = data.playerId
    --     local mana      = data.mana
    --     local maxPoint  = data.maxPoint

    --     assert(playerId)
    --     assert(mana)
    --     assert(maxPoint)

    --     if mana >= require 'ManaManager'.ManaStep then
    --         if not self._touchPlayerMap['skill'..playerId] then
    --             self._touchPlayerMap['skill'..playerId] = true
    --             if playerId == 3 then
    --                 EventCenter.eventInput(FightEvent.FirstFightGuider_ShowArrow, { index = 4 } )
    --             elseif playerId == 4 then
    --                 EventCenter.eventInput(FightEvent.FirstFightGuider_ShowArrow, { index = 3 } )
    --             end
    --         end
    --     end
    -- end, 'Fight')
end


function FirstFightGuider:initUpdateHandle()
    -- body
    self._updateProgress = 0

    local delay_times = require 'FightGuiderConfig'[1].first_fight_times or { 4, 9, 15, 20, 10 }
    -- local delay_times = { 4, 9, 15, 20, 10 }

    print('delay_times')
    print(delay_times)

    self._handler = require 'FightTimer'.addFunc(function ( dt )
        -- body
        self._updateProgress = self._updateProgress + dt

        for i,v in ipairs(delay_times) do
            if not self._touchPlayerMap['index'..i] then
                if self._updateProgress > v then
                    self._touchPlayerMap['index'..i] = true
                    EventCenter.eventInput(FightEvent.FirstFightGuider_ShowArrow, { index = i } )
                end
            end
        end

        -- -- 近战引导
        -- local jinzhanId = 4
        -- local jinzhanTime = 4
        -- if not self._touchPlayerMap[jinzhanId] then
        --     if self._updateProgress > jinzhanTime then
        --         self._touchPlayerMap[jinzhanId] = true
        --         EventCenter.eventInput(FightEvent.FirstFightGuider_ShowArrow, { index = 1 } )
        --     end
        -- end

        -- -- 远程引导
        -- local yuanchenId = 3
        -- local yuanchenTime = 9
        -- if not self._touchPlayerMap[yuanchenId] then
        --     if self._updateProgress > yuanchenTime then
        --         self._touchPlayerMap[yuanchenId] = true
        --         EventCenter.eventInput(FightEvent.FirstFightGuider_ShowArrow, { index = 2 } )
        --     end
        -- end

        -- local time3 = 12
        -- if not self._touchPlayerMap['index=3'] then
        --     if self._updateProgress > time3 then
        --         self._touchPlayerMap['index=3'] = true
        --         EventCenter.eventInput(FightEvent.FirstFightGuider_ShowArrow, { index = 3 } )
        --     end
        -- end

        -- local time4 = 16

    end)
end

function FirstFightGuider:initUi()
    -- body
    local WinSize = CCDirector:sharedDirector():getWinSize()
    self._arrow1:setScaleX(WinSize.width/1136)
    self._arrow2:setScaleX(WinSize.width/1136)
    self._arrow3:setScaleX(WinSize.width/1136)
    self._arrow4:setScaleX(WinSize.width/1136)
    self._arrow5:setScaleX(WinSize.width/1136)
    self._arrow6:setScaleX(WinSize.width/1136)
end

function FirstFightGuider:onInit( userData, netData )
    self:initEvents()
    self:initUpdateHandle()
    self:initUi()
end



function FirstFightGuider:onBack( userData, netData )
    
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(FirstFightGuider, "FirstFightGuider")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("FirstFightGuider", FirstFightGuider)
