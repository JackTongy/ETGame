local config            = require "Config"
local FightSettings     = require 'FightSettings'
local XmlCache          = require 'XmlCache'
local Swf               = require 'framework.swf.Swf'
local EventCenter       = require 'EventCenter'
local FightEvent        = require 'FightEvent'
local Res               = require 'Res'
local Swf               = require 'framework.swf.Swf'
local SwfActionFactory  = require 'framework.swf.SwfActionFactory'

local ScaleDataRate = 0.6
local ScaleData= {
    [1] = { f = 1, v = false},
    [2] = { f = 7,  s = {ScaleDataRate*1.00/2.58, ScaleDataRate*1.00/2.58},   a = 0, v = true },
    [3] = { f = 8,  s = {ScaleDataRate*1.63/2.58, ScaleDataRate*1.63/2.58},   a = 92 },
    [4] = { f = 9,  s = {ScaleDataRate*2.12/2.58, ScaleDataRate*2.12/2.58},   a = 164 },
    [5] = { f = 10, s = {ScaleDataRate*2.47/2.58, ScaleDataRate*2.47/2.58},   a = 215 },
    [6] = { f = 11, s = {ScaleDataRate*2.69/2.58, ScaleDataRate*2.69/2.58},   a = 246 },
    [7] = { f = 12, s = {ScaleDataRate*2.76/2.58, ScaleDataRate*2.76/2.58},   a = 255 },
    [8] = { f = 13, s = {ScaleDataRate*2.58/2.58, ScaleDataRate*2.58/2.58},    },
}

local RewardBoxBGData = {
    [1] = { f = 1,  i = 'N_ZD_diaoluo_baoxiang1.png', v = true },
    [1] = { f = 8,  i = 'N_ZD_diaoluo_baoxiang2.png'},
}

local RewardBallBGData = {
    [1] = { f = 1,  i = 'N_ZD_diaoluo_qiu.png', v = true },
    [1] = { f = 8,  i = 'N_ZD_diaoluo_qiu2.png'},
}

local GameOverLost = class(LuaController)

function GameOverLost:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."GameOverLost.cocos.zip")
    return self._factory:createDocument("GameOverLost.cocos")
end

--@@@@[[[[
function GameOverLost:onInitXML()
    local set = self._set
   self._bg = set:getElfNode("bg")
   self._bg_pic1 = set:getElfNode("bg_pic1")
   self._bg_pic2 = set:getElfNode("bg_pic2")
   self._title = set:getElfNode("title")
   self._title_bg = set:getElfNode("title_bg")
   self._title_zdsb = set:getElfNode("title_zdsb")
   self._title_zdsb_z = set:getElfNode("title_zdsb_z")
   self._title_zdsb_d = set:getElfNode("title_zdsb_d")
   self._title_zdsb_s = set:getElfNode("title_zdsb_s")
   self._title_zdsb_b = set:getElfNode("title_zdsb_b")
   self._center = set:getElfNode("center")
   self._title = set:getElfNode("title")
   self._title_bg = set:getElfNode("title_bg")
   self._title_light = set:getElfNode("title_light")
   self._title_explode = set:getElfNode("title_explode")
   self._title_zdsl = set:getElfNode("title_zdsl")
   self._tip = set:getRichLabelNode("tip")
   self._layer = set:getElfNode("layer")
   self._llayout_name = set:getLabelNode("llayout_name")
   self._llayout2_honor = set:getLabelNode("llayout2_honor")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout_label = set:getLabelNode("llayout_label")
   self._llayout_label1 = set:getLabelNode("llayout_label1")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout_label3 = set:getLabelNode("llayout_label3")
   self._llayout2_gold = set:getLabelNode("llayout2_gold")
   self._llayout_name = set:getLabelNode("llayout_name")
   self._llayout2_icon = set:getElfNode("llayout2_icon")
   self._llayout2_num = set:getLabelNode("llayout2_num")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout2_label = set:getLabelNode("llayout2_label")
   self._llayout2_icon = set:getElfNode("llayout2_icon")
   self._llayout2_des = set:getLabelNode("llayout2_des")
   self._llayout = set:getLinearLayoutNode("llayout")
   self._llayout_name = set:getLabelNode("llayout_name")
   self._llayout2_des = set:getLabelNode("llayout2_des")
   self._llayout = set:getLinearLayoutNode("llayout")
   self._llayout_V = set:getLabelNode("llayout_V")
   self._llayout2 = set:getLinearLayoutNode("llayout2")
   self._fake_result = set:getElfNode("fake_result")
   self._fake_result_rewardBar = set:getLayoutNode("fake_result_rewardBar")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._nextButton = set:getButtonNode("nextButton")
   self._ActionFadeIn = set:getElfAction("ActionFadeIn")
   self._ActionLight = set:getElfAction("ActionLight")
   self._ActionRewardLight = set:getElfAction("ActionRewardLight")
   self._ActionScaleOut = set:getElfAction("ActionScaleOut")
--   self._@winDialog = set:getElfNode("@winDialog")
--   self._@ArenaReward = set:getElfNode("@ArenaReward")
--   self._@CMReward = set:getElfNode("@CMReward")
--   self._@SDNReward = set:getElfNode("@SDNReward")
--   self._@BossReward = set:getElfNode("@BossReward")
--   self._@CatReward = set:getElfNode("@CatReward")
--   self._@LeagueReward = set:getElfNode("@LeagueReward")
--   self._@GuildBossReward = set:getElfNode("@GuildBossReward")
--   self._@GuildMatchReward = set:getElfNode("@GuildMatchReward")
--   self._@GuildFubenReward = set:getElfNode("@GuildFubenReward")
--   self._@rewardToolItem = set:getElfNode("@rewardToolItem")
--   self._@rewardPetItem = set:getElfNode("@rewardPetItem")
end
--@@@@]]]]

--------------------------------override functions----------------------
function GameOverLost:onInit( userData, netData )
    self._tip:setString(Res.locString('Battle$prompteTips'))
    GleeCore:closeAllLayers()
    FightSettings.resume()

    self._callback = userData and userData.callback
    print('GameOverLost')
    print(userData)

    self:initBg()
    
    local mode = userData and userData.mode
    local winfake = (mode == 'bossBattle') or (mode == 'CMBossBattle') or (mode == 'SDNBossBattle') or (mode == 'fuben_cat') or (mode == 'guildboss')

    if winfake then
        self:initWinDialog()
    else
        self:initForLost()
    end

    self:initForArena(userData)
    self:initForArenaRecord(userData)
    self:initLeague(userData)
    
    self:runWithDelay(function ()
        -- body
        self:initForBossBattle(userData)
        self:initForCMBossBattle(userData)
        self:initForSDNBossBattle(userData)
        self:initFubenCat(userData)
        self:initForGuildBossBattle(userData)
        self:initForGuildMatchBattle(userData)
        self:initForGuildFuben(userData)
        self:initForLimitFuben(userData)
        self:initForGuildFubenRob(userData)
        self:initForGuildFubenRevenge(userData)
        self:initForRemainsFuben(userData)
        self:initFriend(userData)
    end, 0.5)
end

function GameOverLost:initBg()
    -- body
    local resid1, resid2 = require 'BattleBgManager'.getLastBgResid()
    self._bg_pic1:setResid(resid1)
    self._bg_pic2:setResid(resid2)

    CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )
end

function GameOverLost:initWinDialog()
    -- body
    self._title:setVisible(false)
    self._tip:setVisible(false)

    local win_luaset = self:createLuaSet('@winDialog')
    win_luaset[1]:setVisible(true)

    self._center:addChild(win_luaset[1])

    win_luaset['title_bg']:setVisible(false)
    win_luaset['title_light']:setVisible(false)
    win_luaset['title_explode']:setVisible(false)
    win_luaset['title_zdsl']:setVisible(false)

    local nodeMap = {
      [1] = self._layer_shade,
      [2] = win_luaset['title_zdsl'],
      [3] = win_luaset['title_explode'],
      -- [4] = win_luaset['dialog'],
    }

    local swf = Swf.new('Swf_ZhanDouJieSuan', nodeMap)
    swf:play()

    self:runWithDelay(function ()
        -- body
        require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.star )
    end, 0.5)

    win_luaset['title_light']:runAction(self._ActionLight:clone())
    
    self._win_luaset = win_luaset

    self:runWithDelay(function ()
        -- body
        if self._nextButton then
            self._nextButton:setListener(function ()
                -- body
                CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )
                GleeCore:popController()
                FightSettings.unLock()
                -- require 'framework.helper.MusicHelper'.setBackgroundMusicVolume(1)
            end)
        end
    end, 0.6)

    XmlCache.cleanXmlCache('Fight')
end


function GameOverLost:initForLost()
  -- body
    -- local nodeMap = {
    --   [1] = self._layer_shade,
    --   [2] = win_luaset['title_zdsl'],
    --   [3] = win_luaset['title_explode'],
    -- }

    -- local swf = Swf.new('Swf_ZhanDouJieSuan', nodeMap)
    -- swf:play()
    self._title:setVisible(true)
    self._tip:setVisible(true)

    local action = CCRepeatForever:create( CCRotateBy:create(120, 360) )
    self._title_bg:runAction(action)

    require 'framework.helper.MusicHelper'.playBackgroundMusic( require 'Res'.Sound.bt_lose )
    -- require 'framework.helper.MusicHelper'.stopBackgroundMusic()

    self._nextButton:setListener(function ()
        -- body
        GleeCore:popController()
        FightSettings.unLock()
        -- require 'framework.helper.MusicHelper'.setBackgroundMusicVolume(1)
    end)

    XmlCache.cleanXmlCache('Fight')
end

function GameOverLost:initForBossBattle( userData )
    -- body
    if userData and userData.mode == 'bossBattle' then
        print('initForBossBattle')
        print(userData)

        local info = string.format('%s:%d(%.3f%%)', Res.locString('Battle$DPS'), math.floor(userData.hurtValue), userData.hurtPercent )
        self._tip:setString(info)
        self._tip:setVisible(true)

        local reward = userData.Reward
        
        if reward then
            local myPetPiece = nil

            local rewardArr = {}
            if reward.Materials then
                print('reward.Materials')
                for _i, _v in ipairs(reward.Materials) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'Materials' } )
                end
            end
            if reward.Equipments then
                print('reward.Equipments')
                for _i, _v in ipairs(reward.Equipments) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'Equipments' } )
                end
            end
            if reward.PetPieces then
                print('reward.PetPieces')
                for _i, _v in ipairs(reward.PetPieces) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'PetPieces' } )
                end

                myPetPiece = reward.PetPieces[1]
            end

            if reward.Pets then
                print('reward.Pets')
                for _i, _v in ipairs(reward.Pets) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'Pets' } )
                end
            end

            local rewardNum = #rewardArr
            local timeRate = 1

            -- for i,v in ipairs(rewardArr) do
            --     -- 
            --     self:runWithDelay(function ()
            --         local rewardItem
            --         if v.type == 'Equipments' then
            --             rewardItem = self:createLuaSet('@rewardToolItem')
            --             Res.setNodeWithEquipNetData( rewardItem['icon'], v.data, v.data.Amount )
            --             v.isPet = false
            --         elseif v.type == 'Materials' then
            --             rewardItem = self:createLuaSet('@rewardToolItem')
            --             Res.setNodeWithMaterialNetData( rewardItem['icon'], v.data, v.data.Amount )
            --             v.isPet = false
            --         elseif v.type == 'PetPieces' then
            --             rewardItem = self:createLuaSet('@rewardPetItem')
            --             Res.setNodeWithPetPieceNetData( rewardItem['icon'], v.data, v.data.Amount )
            --             v.isPet = true
            --         elseif v.type == 'Pets' then
            --             rewardItem = self:createLuaSet('@rewardPetItem')
            --             Res.setNodeWithPetNetData( rewardItem['icon'], v.data, v.data.Amount )
            --             v.isPet = true
            --         end
            --         assert(rewardItem)
                    
            --         rewardItem['icon']:setVisible(false)
            --         v.set = rewardItem
            --         rewardItem[1]:setColorf(1,1,1,0)
            --         self._fake_result_rewardBar:addChild( rewardItem[1] )

            --         self:runWithDelay(function ()
            --             -- body
            --             local fadeIn = CCFadeIn:create(0.5)
            --             rewardItem[1]:runAction(fadeIn)
            --         end, (i*10)/20*timeRate)
                   
            --     end, (10)/20*timeRate)
                
            -- end

            -- -- open rewards
            -- self:runWithDelay(function ()
            --     -- body
            --     for i,v in ipairs(rewardArr) do
            --         -- explode
            --         v.set['explode']:setVisible(true)
            --         -- light
            --         v.set['light']:runAction( self._ActionRewardLight:clone() )
            --         -- box
            --         if v.isPet then
            --             v.set['box']:runAction( SwfActionFactory.createAction( RewardBallBGData ) ) 
            --         else
            --             v.set['box']:runAction( SwfActionFactory.createAction( RewardBoxBGData ) ) 
            --         end
                    
            --         -- icon
            --         v.set['icon']:runAction( SwfActionFactory.createAction( ScaleData ) )
            --     end
            -- end, (10 + rewardNum*10 + 10)/20*timeRate)

            print('myPetPiece')
            print(myPetPiece)

            -- DPetAcademyEffectV3
            if myPetPiece then
                myPetPiece.isPieces = true
                self._nextButton:setListener(function ()
                    -- body
                    local myFinalFunc = function ()
                        -- body
                        CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )
                        GleeCore:popController()
                        FightSettings.unLock()
                    end

                    local dialogData = {}
                    dialogData.callback = myFinalFunc
                    dialogData.pets = { myPetPiece }

                    GleeCore:showLayer('DPetAcademyEffectV3', dialogData)

                end)

                self._nextButton = nil
            end

        end
    end
end

function GameOverLost:initForCMBossBattle( userData )
    -- body
    if userData and userData.mode == 'CMBossBattle' then
        print('initForCMBossBattle')
        print(userData)

        self._tip:setVisible(false)

        local luaset = self:createLuaSet('@CMReward')
        luaset['llayout_num']:setString( tostring(math.floor(userData.hurtValue)) )
		require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
		    luaset['llayout_#label']:setScaleX(0)
		    luaset['llayout_#label1']:setString('에게')
		    luaset['llayout_#label3']:setString('데미지를 입혔다!!')
		end)

        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])
    end
end

function GameOverLost:initForSDNBossBattle( userData )
    -- body
    if userData and userData.mode == 'SDNBossBattle' then
        print('initForSDNBossBattle')
        print(userData)

        self._tip:setVisible(false)

        local luaset = self:createLuaSet('@SDNReward')
        luaset['llayout_num']:setString( tostring(math.floor(userData.hurtValue)) )

        require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
            luaset['llayout_#label']:setVisible(false)
            luaset['llayout_#label1']:setString(Res.locString('Battle$SAnumber4'))
            luaset['llayout_#label3']:setString('데미지를 입혔습니다!')
        end)
        

        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])
    end
end

function GameOverLost:initForGuildBossBattle( userData )
    if userData and userData.mode == 'guildboss' then
        self._tip:setVisible(false)

        local luaset = self:createLuaSet('@GuildBossReward')
        luaset[1]:setVisible(true)
        luaset['llayout_num']:setString(tostring(userData.AtkHarms))
        -- luaset['llayout_name']:setString(tostring(require 'ServerRecord'.getArenaEnemyName()) )
        luaset['llayout2_des']:setString(tostring(userData.D.Coin))
        require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
            luaset['llayout_#label1']:setVisible(false)
            luaset['llayout_#label3']:setString('데미지를 입혔다!')
        end)

        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])
    end
end

function GameOverLost:initForGuildMatchBattle( userData )
    if userData and userData.mode == 'guildmatch' then
        self._tip:setVisible(false)

        local luaset = self:createLuaSet('@GuildMatchReward')
        luaset[1]:setVisible(true)

        luaset['llayout_name']:setString(tostring(require 'ServerRecord'.getArenaEnemyName()))
        luaset['llayout2_des']:setString(string.format(Res.locString('GuildBattle$guildmatchret'),tostring(userData.AtkHarms),tostring(userData.D.AtkHonor)))

        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])
    end
end

function GameOverLost:initForGuildFuben( userData )
    if userData and userData.mode == 'guildfuben' then
        self._tip:setVisible(false)

        local luaset = self:createLuaSet('@GuildFubenReward')
        luaset[1]:setVisible(true)
        luaset['llayout_V']:setString(string.format('%d%%',userData.NpcTotalhpP))
        require 'RewardViewHelper'.BattleRewardShow(self,userData.D.Reward,luaset['llayout2'])
        
        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])
    end
end

function GameOverLost:initForLimitFuben( userData )
    if userData and userData.mode == 'limit_fuben' then
        self._tip:setVisible(true)

    end
end

function GameOverLost:initForGuildFubenRob( userData )
    if userData and userData.mode == 'guildfuben_rob' then
        self._tip:setString(Res.locString('GuildBattle$GuildFubenRobLost'))
        self._tip:setVisible(true)

    end
end

function GameOverLost:initForGuildFubenRevenge( userData )
    if userData and userData.mode == 'guildfuben_revenge' then
        self._tip:setString(Res.locString('GuildBattle$GuildFubenRevengeLost'))
        self._tip:setVisible(true)

    end
end

function GameOverLost:initForArena( userData )
	-- body
	if userData and userData.mode == 'arena' then
        print('initForArena')
        print(userData)

        self._tip:setVisible(false)
        
        local reward = require 'ServerRecord'.getArenaReward()
        if reward then
          local luaset = self:createLuaSet('@ArenaReward')
      		
  	    	luaset['llayout_name']:setString( tostring(require 'ServerRecord'.getArenaEnemyName()) )
  	    	luaset['llayout2_honor']:setString( string.format('%s+%s %s+%s', Res.locString('Global$Honor'), tostring(reward.Honor), Res.locString('Global$Gold'), tostring(reward.Gold)) )
            
            require "MATHelper":Change(6, reward.Honor, 0)
            
            require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
                luaset['llayout_#label']:setScaleX(0)
                luaset['llayout_#label1']:setString('님과의 결투에서 패배했습니다!')
            end,nil,nil,function ( ... )
                luaset['llayout_#label']:setString('Você foi derrotado por')
            end)

  		    luaset[1]:runAction(self._ActionFadeIn:clone())
  		    self._layer:addChild(luaset[1])
        end

        -- EventCenter.eventInput(FightEvent.ArenaGameOver, false)
    end
end

function GameOverLost:initFriend( userData )
    -- body
    if userData and userData.mode == 'friend' then
        
        self._tip:setVisible(false)
        local luaset = self:createLuaSet('@ArenaReward')
        luaset['llayout_name']:setString( tostring(require 'ServerRecord'.getArenaEnemyName()) )
        luaset['#llayout2']:setVisible(false)

        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])
        
        -- EventCenter.eventInput(FightEvent.ArenaGameOver, false)
    end
end


function GameOverLost:initForArenaRecord( userData )
    -- body
    if userData and userData.mode == 'arena-record' then
        print('initForArena')
        print(userData)

        self._tip:setVisible(false)
        
    end
end

function GameOverLost:initFubenCat( userData )
    -- body
    if userData and userData.mode == 'fuben_cat' then
        print('initForFubenCat')
        print(userData)

        self._tip:setVisible(false)

        local luaset = self:createLuaSet('@CatReward')
            
        luaset['llayout_num']:setString( tostring(math.floor(userData.hurtValue)) )
        luaset['llayout2_gold']:setString( string.format('+%s', tostring(userData.gold)) )
        require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
            luaset['llayout_label']:setScaleX(0)
            luaset['llayout_label1']:setString('에게')
            luaset['llayout_label3']:setString('데미지를 입혔다!')
        end)
        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])
    end
end

function GameOverLost:initLeague( userData )
    -- body
    if userData and userData.mode == 'league' then
        self._tip:setVisible(false)
        
        local reward = require 'ServerRecord'.getLeagueReward()

        -- assert(reward)

        if reward then
          local luaset = self:createLuaSet('@LeagueReward')
          
          luaset['llayout_name']:setString( tostring(require 'ServerRecord'.getArenaEnemyName()) )
          
          luaset['llayout2_num']:setString( tostring(reward.D.Honor) )
          -- luaset['llayout2_honor']:setString( string.format('积分+%s', tostring(reward.D.Score)) )
          require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
            luaset['llayout_#label']:setScaleX(0)
            luaset['llayout_#label1']:setString('님에게 패배했습니다!')
          end)
          luaset[1]:runAction(self._ActionFadeIn:clone())
          self._layer:addChild(luaset[1])
        end
    end
end

function GameOverLost:initForRemainsFuben( userData )
    if userData and userData.mode == 'RemainsFuben' then
        self._tip:setVisible(true)

    end
end

function GameOverLost:onBack( userData, netData )
	
end

function GameOverLost:onRelease( ... )
    require 'FightTimer'.reset()
    require 'LayerManager'.reset()
    EventCenter.resetGroup('Fight')

    require 'GuideHelper':check('BattleEndLost')
    if self._callback then
        self._callback()
    end

    local data = {
        mode = require 'ServerRecord'.getMode(),
        isWin = false,
        userData = self:getUserData()
    }
    EventCenter.eventInput("OnBattleCompleted", data)

    require 'ServerRecord'.reset()
end
--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(GameOverLost, "GameOverLost")


--------------------------------register--------------------------------
GleeCore:registerLuaController("GameOverLost", GameOverLost)


