local Config = require "Config"

local CfgHelper = require 'CfgHelper'
local Global = require 'Global'

local BattleStory = class(LuaDialog)

function BattleStory:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."BattleStory.cocos.zip")
    return self._factory:createDocument("BattleStory.cocos")
end

--@@@@[[[[
function BattleStory:onInitXML()
	local set = self._set
    self._bg = set:getElfNode("bg")
    self._bg_pic1 = set:getElfNode("bg_pic1")
    self._bg_pic2 = set:getElfNode("bg_pic2")
    self._rect = set:getRectangleNode("rect")
    self._tips = set:getElfNode("tips")
    self._tips_portrait = set:getElfNode("tips_portrait")
    self._tips_portrait_pic = set:getElfNode("tips_portrait_pic")
    self._tips_bg2 = set:getElfNode("tips_bg2")
    self._tips_bg = set:getElfNode("tips_bg")
    self._tips_bg_name = set:getLabelNode("tips_bg_name")
    self._tips_bg_info = set:getLabelNode("tips_bg_info")
    self._button = set:getButtonNode("button")
end
--@@@@]]]]

--------------------------------override functions----------------------
function BattleStory:onInit( userData, netData )

	assert(userData, 'No userData')
    assert(userData.StoryId, 'No StoryId')
    assert(userData.callback, 'No callback')
    assert(userData.defaultPetId, '')

    local bg1, bg2 = require 'BattleBgManager'.getLastBgResid()
    self._bg_pic1:setResid(bg1)
    self._bg_pic2:setResid(bg2)

    -- 获得剧情
    local storyTable = require 'BattleStoryA'
    assert(storyTable)

    local array = {}
    for i,v in ipairs(storyTable) do
        if v.StoryId == userData.StoryId then
            table.insert(array, v)
        end
    end

    local index = 0
    local function doNext()
        -- body
        index = index + 1
        if index > #array then
            index = 0
            self:close()
            userData.callback()
        else
            local v = array[index]
            assert(v)

            if v.PetId == -1 then

                local defaultCfg = CfgHelper.getCache('GuideRoleCfg2', 'id', string.format('%03d',userData.defaultPetId))
                -- assert(defaultCfg)

                local newV = {}
                if defaultCfg then 
                    newV.Pos = {defaultCfg.x, defaultCfg.y}
                    newV.Scale = defaultCfg.scale
                else
                    newV.Pos = v.Pos
                    newV.Scale = v.Scale
                end

                newV.PetId = userData.defaultPetId

                newV.Text = v.Text

                local charCfg = CfgHelper.getCache('charactorConfig', 'id', userData.defaultPetId)
                newV.name = charCfg.name

                newV.Raw = v.Raw

                v = newV
            elseif v.PetId == -2 then
                -- 1 -> 3
                -- 4 -> 6
                -- 7 -> 9
                local finalPetId = userData.defaultPetId

                while true do
                    local nextPet = CfgHelper.getCache('charactorConfig', 'id', finalPetId, 'ev_pet')
                    if nextPet and nextPet[1] then
                        finalPetId = nextPet[1]
                    else
                        break
                    end
                end
                
                userData.defaultPetId = finalPetId
                
                local defaultCfg = CfgHelper.getCache('GuideRoleCfg2', 'id', string.format('%03d',userData.defaultPetId))
                -- assert(defaultCfg)
                
                local newV = {}
                if defaultCfg then 
                    newV.Pos = {defaultCfg.x, defaultCfg.y}
                    newV.Scale = defaultCfg.scale
                else
                    newV.Pos = v.Pos
                    newV.Scale = v.Scale
                end

                newV.PetId = userData.defaultPetId

                newV.Text = v.Text

                local charCfg = CfgHelper.getCache('charactorConfig', 'id', userData.defaultPetId)
                newV.name = charCfg.name

                newV.Raw = v.Raw

                v = newV
            else
                assert(v.Pos, v.ID)
            end

            --
            local picData = require 'SkinManager'.getRoleBigIcon2ByCharactorId( v.PetId )
            self._tips_portrait_pic:setResid(picData[1])

            local mainScale = (Global.getWidth() / 1136)

            self._tips_portrait_pic:setPosition(ccp( (-1136/2+v.Pos[1])*mainScale , 320 - v.Pos[2]))
            self._tips_portrait_pic:setScaleX( v.Scale )
            self._tips_portrait_pic:setScaleY( math.abs(v.Scale) )

            self._tips_bg_info:setString( v.Text )
            self._tips_bg_name:setString( v.name )

            if v.Raw then
                require 'framework.helper.MusicHelper'.stopAllEffects()
                require 'framework.helper.MusicHelper'.playEffect(v.Raw)
            end
        end
    end

    self._button:setListener(function ()
        -- body
        doNext()
    end)

    doNext()

end

function BattleStory:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(BattleStory, "BattleStory")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("BattleStory", BattleStory)


