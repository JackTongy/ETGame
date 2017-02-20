local Config = require "Config"
local AppData = require 'AppData'
local Res = require 'Res'
local DBManager = require 'DBManager'
local Utils = require 'framework.helper.Utils'
local AccountHelper = require 'AccountHelper'
local manager = {}

--stageID
--battleID
--condition

function manager.getStoryID(userData)
    local storyTable = require 'BattleStoryA'

    local dialogues = {}
    for k, v in pairs(storyTable) do
        if v.Stage_ID == userData.stageID and v.condition == userData.condition then
            if userData.battleID then
                if userData.battleID == v.battleid then
                    return v.StoryId
                end
            else
                return v.StoryId
            end
        end
    end
end

function manager.getDialogues(userData)
    local storyID = manager.getStoryID(userData)
    if not storyID then
        return nil 
    end

    local storyTable = require 'BattleStoryA'

    local dialogues = {}
    for k, v in ipairs(storyTable) do
        if v.StoryId == storyID then
            table.insert(dialogues, v)
        end
    end
    return dialogues
end

function manager.checkDialogue(userData)
    -- print('msg:---------------------------')
    -- print(userData)
    -- if not userData.isWin then
    --     return
    -- end
    if AccountHelper.isItemOFF('PetName') then
        return
    end

    local datas = manager.getDialogues(userData)
    if not datas or not next(datas) then
        print('msg:-----------coming!!')
        if userData.callback then
            print('msg:-----------callBack')
            return userData.callback()
        end
        return
    end

    local userID = AppData.getUserInfo().getId()
    local filename = 'storyRecord'..tostring(userID)
    local storyRecord = Utils.readTableFromFile(filename) or {}
    local find = false
    for k, v in pairs(storyRecord) do
        if v == datas[1].StoryId then
            return
        end
    end

    -- if datas[1].StoryId == storyRecord.StoryId then
    --     return
    -- end

    if datas and next(datas) then
        GleeCore:showLayer('DStory', {dialogues = datas, callback = userData.callback})
    end
    table.insert(storyRecord, datas[1].StoryId)
    Utils.writeTableToFile(storyRecord, filename)
end

return manager