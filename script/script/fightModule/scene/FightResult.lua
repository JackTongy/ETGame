local Config = require "Config"

local FightResult = class(LuaController)

function FightResult:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."FightResult.cocos.zip")
    return self._factory:createDocument("FightResult.cocos")
end

--@@@@[[[[
function FightResult:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._layer = set:getElfNode("layer")
    self._title = set:getElfNode("title")
    self._title_bg = set:getElfNode("title_bg")
    self._title_d = set:getElfNode("title_d")
    self._title_j = set:getElfNode("title_j")
    self._title_t = set:getElfNode("title_t")
    self._title_s = set:getElfNode("title_s")
    self._dialog = set:getElfNode("dialog")
    self._dialog_bg = set:getJoint9Node("dialog_bg")
    self._dialog_name = set:getLabelNode("dialog_name")
    self._dialog_star = set:getLayoutNode("dialog_star")
    self._dialog_level_num = set:getLabelNode("dialog_level_num")
    self._dialog_level_num2 = set:getLabelNode("dialog_level_num2")
    self._dialog_hp_num = set:getLabelNode("dialog_hp_num")
    self._dialog_hp_num2 = set:getLabelNode("dialog_hp_num2")
    self._dialog_atk_num = set:getLabelNode("dialog_atk_num")
    self._dialog_atk_num2 = set:getLabelNode("dialog_atk_num2")
    self._dialog_potential_num = set:getLabelNode("dialog_potential_num")
    self._portrait = set:getElfNode("portrait")
    self._JieSuan = set:getElfNode("JieSuan")
    self._title = set:getElfNode("title")
    self._title_bg = set:getElfNode("title_bg")
    self._title_j = set:getElfNode("title_j")
    self._title_s = set:getElfNode("title_s")
    self._title_z = set:getElfNode("title_z")
    self._title_d = set:getElfNode("title_d")
    self._dialog = set:getElfNode("dialog")
    self._dialog_bg = set:getJoint9Node("dialog_bg")
    self._dialog_gray = set:getElfNode("dialog_gray")
    self._dialog_titleL = set:getBMFontNode("dialog_titleL")
    self._dialog_expR = set:getBMFontNode("dialog_expR")
    self._dialog_progress = set:getProgressNode("dialog_progress")
    self._dialog_expM = set:getBMFontNode("dialog_expM")
    self._dialog_condition1 = set:getElfNode("dialog_condition1")
    self._dialog_condition2 = set:getElfNode("dialog_condition2")
    self._dialog_condition3 = set:getElfNode("dialog_condition3")
    self._dialog_getCoins = set:getBMFontNode("dialog_getCoins")
    self._dialog_totalCoins = set:getBMFontNode("dialog_totalCoins")
    self._dialog_percent = set:getBMFontNode("dialog_percent")
    self._JieSuan = set:getElfNode("JieSuan")
    self._title = set:getElfNode("title")
    self._title_bg = set:getElfNode("title_bg")
    self._title_d = set:getElfNode("title_d")
    self._title_j = set:getElfNode("title_j")
    self._title_t = set:getElfNode("title_t")
    self._title_s = set:getElfNode("title_s")
    self._dialog = set:getElfNode("dialog")
    self._dialog_bg = set:getJoint9Node("dialog_bg")
    self._dialog_level_num = set:getLabelNode("dialog_level_num")
    self._dialog_level_num2 = set:getLabelNode("dialog_level_num2")
    self._dialog_power_num = set:getLabelNode("dialog_power_num")
    self._dialog_power_num2 = set:getLabelNode("dialog_power_num2")
    self._dialog_powerLimit_num = set:getLabelNode("dialog_powerLimit_num")
    self._dialog_powerLimit_num2 = set:getLabelNode("dialog_powerLimit_num2")
    self._dialog_friendLimit_num = set:getLabelNode("dialog_friendLimit_num")
    self._dialog_friendLimit_num2 = set:getLabelNode("dialog_friendLimit_num2")
    self._dialog_title = set:getElfNode("dialog_title")
    self._JieSuan = set:getElfNode("JieSuan")
    self._nextButton = set:getButtonNode("nextButton")
--    self._@heroPromote = set:getElfNode("@heroPromote")
--    self._@xx = set:getElfNode("@xx")
--    self._@xx = set:getElfNode("@xx")
--    self._@xx = set:getElfNode("@xx")
--    self._@xx = set:getElfNode("@xx")
--    self._@result = set:getElfNode("@result")
--    self._@playerPromote = set:getElfNode("@playerPromote")
end
--@@@@]]]]

--------------------------------override functions----------------------
function FightResult:onInit( userData, netData )
    --[[
    当前总的金币
    获得的金币

    当前总的经验
    获得的经验
    当前经验的上限值

    三项条件 -> 

    先是英雄升级
    展示战斗奖励, 金币+经验
    玩家升级

    --]]

    local todoList = {}

    local heroPromoteSet
    local resultSet
    local playerPromoteSet

    if userData.HeroPromoteArray then
        
        for i, heroPromoteVo in ipairs(userData.HeroPromoteArray) do
            local func 

            func = function ()
                if not heroPromoteSet then
                    heroPromoteSet = self:createLuaSet('@heroPromote')
                    heroPromoteSet[1]:setVisible(true)
                    self._layer:addChild(heroPromoteSet[1])
                end

                heroPromoteSet['dialog_name']:setString(heroPromoteVo.name)
                heroPromoteSet['dialog_star']:removeAllChildrenWithCleanup(true)
                for i=1, heroPromoteVo.star then
                    local xinxin = self:createLuaSet('@xx')
                    heroPromoteSet['dialog_star']:addChild(xinxin[1])
                end

                heroPromoteSet['dialog_level_num']:setString( tostring(heroPromoteVo.level[1]) )
                heroPromoteSet['dialog_level_num2']:setString( tostring(heroPromoteVo.level[2]) )

                heroPromoteSet['dialog_hp_num']:setString( tostring(heroPromoteVo.hp[1]) )
                heroPromoteSet['dialog_hp_num2']:setString( tostring(heroPromoteVo.hp[2]) )

                heroPromoteSet['dialog_atk_num']:setString( tostring(heroPromoteVo.atk[1]) )
                heroPromoteSet['dialog_atk_num2']:setString( tostring(heroPromoteVo.atk[2]) )

                heroPromoteSet['dialog_potential_num']:setString( tostring(heroPromoteVo.potential) )

            end

            table.insert(todoList, func)
        end
    end


    if userData.Result then
        -- self.condition = { 1, 0, 1 }

        -- self.addMoney = 0
        -- self.totalMoney = 0

        -- self.addExp = 0
        -- self.totalExp = 0
        -- self.nextExp = 0 --下一个等级的经验值
        local func
        func = function ()
            -- body
            resultSet = self:createLuaSet('@result')
            resultSet[1]:setVisible(true)
            self._layer:addChild(resultSet[1])

            if heroPromoteSet then
                heroPromoteSet[1]:removeFromParent()
                heroPromoteSet = nil
            end

            local result = userData.Result

            local count = 0
            for i=1, 3 do
                if result.condition[i] == 1 then count = count + 1 end
                resultSet['dialog_condition'..i]:setVisible(result.condition[i] == 1)
            end

            local percent = '0%'
            if count == 0 then
            elseif count == 1 then percent = '30%'
            elseif count == 2 then percent = '60%'
            elseif count == 3 then percent = '100%'
            end 

            resultSet['dialog_percent']:setString(percent)
            resultSet['dialog_expR']:setString('+ '..result.addExp)
            resultSet['dialog_expM']:setString(''..result.totalExp..'/'..result.nextExp)
            resultSet['dialog_getCoins']:setString(''..result.addMoney)
            resultSet['dialog_totalCoins']:setString(''..result.totalMoney)

        end

        table.insert(todoList, func)
    end

    if userData.PlayerPromote then
        local func
        func = function ()
            -- body
            if heroPromoteSet then
                heroPromoteSet[1]:removeFromParent()
                heroPromoteSet = nil
            end

            if resultSet then
                resultSet[1]:removeFromParent()
                resultSet = nil
            end

            local playerPromoteVo = userData.PlayerPromote
            playerPromoteSet = self:createLuaSet('@playerPromote')
            playerPromoteSet[1]:setVisible(true)
            self._layer:addChild(playerPromoteSet[1])

            -- self.level = {10, 11}
            -- self.power = {110, 150} --体力
            -- self.powerLimit = { 150, 160 }
            -- self.friendLimit = { 30, 35 }

            playerPromoteSet['dialog_level_num']:setString(''..playerPromoteVo.level[1])
            playerPromoteSet['dialog_level_num2']:setString(''..playerPromoteVo.level[2])

            playerPromoteSet['dialog_power_num']:setString(''..playerPromoteVo.power[1])
            playerPromoteSet['dialog_power_num2']:setString(''..playerPromoteVo.power[2])

            playerPromoteSet['dialog_powerLimit_num']:setString(''..playerPromoteVo.powerLimit[1])
            playerPromoteSet['dialog_powerLimit_num2']:setString(''..playerPromoteVo.powerLimit[2])

            playerPromoteSet['dialog_friendLimit_num']:setString(''..playerPromoteVo.friendLimit[1])
            playerPromoteSet['dialog_friendLimit_num2']:setString(''..playerPromoteVo.friendLimit[2])
        end

        table.insert(todoList, func)
    end

    local finnalFunc
    finnalFunc = function ()
        -- body
        GleeCore:popController()
    end

    table.insert(todoList, finnalFunc)

    self._todoList = todoList

    self:doNext()
end

function FightResult:doNext()
    -- body
    self._autoTimeProgress = 0

    local func = self._todoList[1]
    if func then
        table.remove(self._todoList, 1)
        func()
    end
end

function FightResult:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(FightResult, "FightResult")


--------------------------------register--------------------------------
GleeCore:registerLuaController("FightResult", FightResult)


