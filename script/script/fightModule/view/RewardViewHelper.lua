local RewardViewHelper = {}

local Res = require 'Res'
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

local PetTypes = 
{
    PetPiece=true,
    Pet=true,
}
function RewardViewHelper.BattleRewardShow0( self,reward,parentnode )
    local timeRate = 1

    if reward then
        -- rewardBar['rewardBar']
        
        -- winData.Result.Reward.PetPieces     = netData.D.Result.Reward.PetPieces
        -- winData.Result.Reward.Pets          = netData.D.Result.Reward.Pets
        -- winData.Result.Reward.Materials     = netData.D.Result.Reward.Materials
        -- winData.Result.Reward.Equipments    = netData.D.Result.Reward.Equipments

        -- fade in out
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
        end
        if reward.Pets then
            print('reward.Pets')
            for _i, _v in ipairs(reward.Pets) do
                print(_v)
                table.insert(rewardArr, { data = _v, type = 'Pets' } )
            end
        end
        if reward.Runes then
            print('reward.Runes')
            for _i,_v in ipairs(reward.Runes) do
                print(_v)
                table.insert(rewardArr,{ data = _v, type = 'Runes'})
            end
        end
        if reward.GuildCopyKeys then
            print('reward.GuildCopyKeys')
            for _i,_v in ipairs(reward.GuildCopyKeys) do
                print(_v)
                table.insert(rewardArr,{ data = _v,type = 'GuildCopyKeys'})
            end
        end

        if reward.ExploreStone then
            print('reward.ExploreStone')
            table.insert(rewardArr,{data =reward.ExploreStone,type='ExploreStone'})
        end

        if reward.Coin and reward.Coin > 0 then
            print('reward.Coin')
            table.insert(rewardArr,{data=reward.Coin,type='Coin'})
        end
        if reward.Soul and reward.Soul > 0 then
            print('reward.Soul')
            table.insert(rewardArr,{data=reward.Soul,type='Soul'})
        end

        
        local rewardNum = #rewardArr
        for i,v in ipairs(rewardArr) do
            -- 
            self:runWithDelay(function ()
                local rewardItem
                if v.type == 'Equipments' then
                    rewardItem = self:createLuaSet('@rewardToolItem')
                    Res.setNodeNameWithEquipNetData( rewardItem['icon'], v.data, v.data.Amount )
                    v.isPet = false
                elseif v.type == 'Materials' then
                    rewardItem = self:createLuaSet('@rewardToolItem')
                    Res.setNodeAndNameWithMaterialNetData( rewardItem['icon'], v.data, v.data.Amount )
                    v.isPet = false
                elseif v.type == 'PetPieces' then
                    rewardItem = self:createLuaSet('@rewardPetItem')
                    Res.setNodeNameWithPetPieceNetData( rewardItem['icon'], v.data, v.data.Amount )
                    v.isPet = true
                elseif v.type == 'Pets' then
                    rewardItem = self:createLuaSet('@rewardPetItem')
                    Res.setNodeNameWithPetNetData( rewardItem['icon'], v.data, v.data.Amount )
                    v.isPet = true
                elseif v.type == 'Runes' then
                    rewardItem = self:createLuaSet('@rewardToolItem')
                    print(v)
                    Res.setNodeWithRuneNetData(rewardItem['icon'],v.data.RuneId,v.data.Star,v.data.Lv,v.data.Amount)
                    v.isPet = false
                elseif v.type == 'GuildCopyKeys' then
                    rewardItem = self:createLuaSet('@rewardToolItem')
                    Res.setGuildCopyKeysNetData(rewardItem['icon'],v.data.PropId,v.data.Amount)
                    v.isPet = false
                elseif v.type == 'ExploreStone' then
                    rewardItem = self:createLuaSet('@rewardToolItem')
                    Res.setNodeWithExploreStone(rewardItem['icon'],v.data)
                    v.isPet = false
                elseif v.type == 'Coin' then
                    rewardItem = self:createLuaSet('@rewardToolItem')
                    Res.setNodeWithCoin(rewardItem['icon'],v.data)
                elseif v.type == 'Soul' then
                    rewardItem = self:createLuaSet('@rewardToolItem')
                    Res.setNodeWithSoul(rewardItem['icon'],v.data)
                end
                assert(rewardItem)
                
                rewardItem['icon']:setVisible(false)
                v.set = rewardItem
                rewardItem[1]:setColorf(1,1,1,0)
                print('parentnodetype:')
                print(type(parentnode))
                rewardItem[1]:setContentSize(CCSizeMake(130,100))
                parentnode:addChild( rewardItem[1] )

                self:runWithDelay(function ()
                    -- body
                    local fadeIn = CCFadeIn:create(0.5)
                    rewardItem[1]:runAction(fadeIn)
                end, (i*10)/20*timeRate)
               
            end, timeRate)
            
        end

        -- open rewards
        self:runWithDelay(function ()
            -- body
            for i,v in ipairs(rewardArr) do
                -- explode
                v.set['explode']:setVisible(true)
                -- light
                v.set['light']:runAction( self._ActionRewardLight:clone() )
                -- box
                if v.isPet then
                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBallBGData ) ) 
                else
                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBoxBGData ) ) 
                end
                
                -- icon
                v.set['icon']:runAction( SwfActionFactory.createAction( ScaleData ) )
            end
        end, (rewardNum*10 + 10)/20*timeRate)

    end
end

function RewardViewHelper.setNodeWithResItem(rootnode,item)
    rootnode:setResid(nil)
    rootnode:removeAllChildrenWithCleanup(true)

    local bg = ElfNode:create()
    bg:setResid(item.bg)
    rootnode:addChild(bg)

    local icon = ElfNode:create()
    icon:setResid(item.icon)
    rootnode:addChild(icon)

    if item.isPiece then
        local piece = ElfNode:create()
        piece:setResid("N_TY_suipian.png")
        rootnode:addChild(piece)
        piece:setPosition(ccp(-43.57141,-42.142822))
    end

    local frame = ElfNode:create()
    frame:setResid(item.frame)
    rootnode:addChild(frame)

    if item.Star then
        local starLayout = LayoutNode:create()
        starLayout:setSpace(22)
        starLayout:setMode(0)
        starLayout:setPosition(0,-65)
        for i=1,item.Star do
            local node = ElfNode:create()
            node:setResid("JLXY_xingxing1.png")
            starLayout:addChild(node)
        end
        rootnode:addChild(starLayout)
    end

    local str = string.format('%sx%d',tostring(item.name),item.count)
    str = string.gsub(str,'\r','')
    str = string.gsub(str,'\n','')
    Res.addName(rootnode,str)
end

function RewardViewHelper.BattleRewardShow( self,reward,parentnode )
    local timeRate = 1

    if reward then

        local resitems = Res.getRewardResList(reward)
        local rewardNum = #resitems
        for i,v in ipairs(resitems) do

            v.isPet = PetTypes[v.type] or false
            self:runWithDelay(function ()

                local rewardItem = self:createLuaSet('@rewardToolItem')
                if v.type == 'Equipment' then
                    Res.setNodeNameWithEquipNetData( rewardItem['icon'], v.orgdata, v.orgdata.Amount )
                elseif v.type == 'Material' then
                    Res.setNodeAndNameWithMaterialNetData( rewardItem['icon'], v.orgdata, v.orgdata.Amount )
                else
                    RewardViewHelper.setNodeWithResItem(rewardItem['icon'],v)    
                end
                
                assert(rewardItem)
                
                rewardItem['icon']:setVisible(false)
                v.set = rewardItem
                rewardItem[1]:setColorf(1,1,1,0)
                print('parentnodetype:')
                print(type(parentnode))
                rewardItem[1]:setContentSize(CCSizeMake(130,100))
                parentnode:addChild( rewardItem[1] )

                self:runWithDelay(function ()
                    -- body
                    local fadeIn = CCFadeIn:create(0.5)
                    rewardItem[1]:runAction(fadeIn)
                end, (i*10)/20*timeRate)
               
            end, timeRate)
            
        end

        -- open rewards
        self:runWithDelay(function ()
            -- body
            for i,v in ipairs(resitems) do
                -- explode
                v.set['explode']:setVisible(true)
                -- light
                v.set['light']:runAction( self._ActionRewardLight:clone() )
                -- box
                if v.isPet then
                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBallBGData ) ) 
                else
                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBoxBGData ) ) 
                end
                
                -- icon
                v.set['icon']:runAction( SwfActionFactory.createAction( ScaleData ) )
            end
        end, (rewardNum*10 + 10)/20*timeRate)
    end
end

return RewardViewHelper