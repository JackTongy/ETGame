local Config = require "Config"
local AppData = require 'AppData'
local Res = require 'Res'
local DBManager = require 'DBManager'

local DStory = class(LuaDialog)

function DStory:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DStory.cocos.zip")
    return self._factory:createDocument("DStory.cocos")
end

--@@@@[[[[
function DStory:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._root_Dialogue = set:getElfNode("root_Dialogue")
    self._root_Dialogue_shield = set:getShieldNode("root_Dialogue_shield")
    self._root_Dialogue_bg = set:getElfNode("root_Dialogue_bg")
    self._root_Dialogue_bg_btn = set:getButtonNode("root_Dialogue_bg_btn")
    self._root_Dialogue_bg_role = set:getElfNode("root_Dialogue_bg_role")
    self._root_Dialogue_bg_bg = set:getElfNode("root_Dialogue_bg_bg")
    self._root_Dialogue_bg_name = set:getLabelNode("root_Dialogue_bg_name")
    self._root_Dialogue_bg_content = set:getRichLabelNode("root_Dialogue_bg_content")
    self._root_Dialogue_bg_n = set:getElfNode("root_Dialogue_bg_n")
    self._Jump = set:getElfAction("Jump")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DStory:onInit( userData, netData )
	self._root_Dialogue_bg_n:runElfAction(self._Jump:clone())

    self:updateDialog(1)
end

function DStory:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DStory:getRoleConfig(petID)
    local roleConfig = require 'GuideRoleCfg2'
    for k, v in pairs(roleConfig) do
        if tonumber(v.id) == petID then
            return v
        end
    end
end

function DStory:getFinalFormPetID(petID)
    local DBPet = DBManager.getCharactor(petID)
    if not DBPet.ev_pet then return petID end
    return self:getFinalFormPetID(DBPet.ev_pet[1])
end

function DStory:updateDialog(index)
    local dialogues = self:getUserData().dialogues
    if index > #dialogues then
        if self:getUserData().callback then
            self:getUserData().callback()
        end
        self:close()
        return
    end

    local dialogue = dialogues[index]
    local petID = dialogue.PetId
    
    if dialogue.PetId == -1 then
        petID = AppData.getUserInfo().getLeaderPetID()

        local temp = self:getRoleConfig(petID)
        dialogue.Scale = temp.scale
        dialogue.Pos = {temp.x, temp.y}
    elseif dialogue.PetId == -2 then
        petID = self:getFinalFormPetID(AppData.getUserInfo().getLeaderPetID())
        local temp = self:getRoleConfig(petID)
        dialogue.Scale = temp.scale
        dialogue.Pos = {temp.x, temp.y}
    end

    local DBPet = DBManager.getCharactor(petID)
    self._root_Dialogue_bg_role:setResid(Res.getPetWithPetId(DBPet.id))

    if dialogue.Pos then
        local pos = ccp(dialogue.Pos[1] - 568, 320 - dialogue.Pos[2])
        self._root_Dialogue_bg_role:setPosition(pos)
    end

    if dialogue.Scale then
        self._root_Dialogue_bg_role:setScaleX(dialogue.Scale)
        self._root_Dialogue_bg_role:setScaleY(math.abs(dialogue.Scale))
    end

    -- local PetID = (Dialogue.PetID == -1 and AppData.getUserInfo().getLeaderPetID()) or Dialogue.PetID
    -- local name = (PetID == 0 and '大木博士')
    self._root_Dialogue_bg_name:setString(DBPet.name)
    self._root_Dialogue_bg_content:setString(dialogue.Text)
    require 'LangAdapter'.selectLangkv({Arabic=function ( ... )
      self._root_Dialogue_bg_content:setDimensions(CCSizeMake(700,0))
      require 'LangAdapter'.LabelNodeAutoShrink(self._root_Dialogue_bg_content,nil,100)
      set['bg_content']:setFontSize(25)
    end})
    
    self._root_Dialogue_bg_btn:setListener(function()
        self:updateDialog(index + 1)
    end)

    if not self.curPet then
        self.curPet = petID
    end
    if self.curPet ~= petID then
        local du = 0.5
        self._root_Dialogue_bg:setColorf(1, 1, 1, 0)
        self._root_Dialogue_bg_btn:setVisible(false)
        local actions = CCArray:create()
        actions:addObject(CCFadeIn:create(du))
        actions:addObject(CCCallFunc:create(function ( ... )
            self:playsound(dialogue.Raw)
            self._root_Dialogue_bg_btn:setVisible(true)
        end))
        self._root_Dialogue_bg:runElfAction(CCSequence:create(actions))

        self.curPet = petID
    else
        self:playsound(dialogue.Raw)
    end
end

function DStory:playsound( filename )
  if filename and filename ~= 0 then
    require 'framework.helper.MusicHelper'.stopAllEffects()
    require 'framework.helper.MusicHelper'.playEffect(filename)
  end
end

-- function DStory:updateDialogdfsaf( ... )
--      local exit = self:isLayerExist('@Dialogue')
--   local set = self:getLayerAndCleanOther('@Dialogue')
--   local Dialogue = stepData.Dialogue
--   local callback = stepData.callback
--   if Dialogue then
--     local PetID = (Dialogue.PetID == -1 and AppData.getUserInfo().getLeaderPetID()) or Dialogue.PetID
--     local name = (PetID == 0 and '大木博士') 
--     if PetID ~= 0 then
--       local dbpet = DBManager.getCharactor(PetID)
--       name = dbpet.name
--     end
    
--     local ccfg = DBManager.getGuideRoleCfg(string.format('%03d',PetID))
--     if ccfg then
--       local pos = ccp(ccfg.x-568,320-ccfg.y)
--       set['bg_role']:setPosition(pos)
--       set['bg_role']:setScaleX(ccfg.scale)
--       set['bg_role']:setScaleY(math.abs(ccfg.scale))
--     end
--     set['bg_role']:setResid(Res.getPetWithPetId(PetID))
--     set['bg_name']:setString(tostring(name))
--     set['bg_content']:setString(tostring(Dialogue.Content))
--   end
  
--   set['bg_n']:runElfAction(self._Jump:clone())
--   set['bg_btn']:setEnabled(true)
--   set['bg_btn']:setListener(function ( ... )
--     if callback then
--       set['bg_btn']:setEnabled(false)
--       self:runWithDelay(callback,0.1)      
--     end  
--   end)

--   if not exit or stepData.FadeIn then
--     local du = stepData.FadeIn or 0.5
--     set['bg']:setColorf(1,1,1,0)
--     set['bg_btn']:setVisible(false)
--     local actions = CCArray:create()
--     actions:addObject(CCFadeIn:create(du))
--     actions:addObject(CCCallFunc:create(function ( ... )
--       self:playsound(Dialogue and Dialogue.Sound)
--       set['bg_btn']:setVisible(true)
--       if stepData and stepData.initcall then
--         stepData.initcall()
--       end
--     end))
--     set['bg']:runElfAction(CCSequence:create(actions))
--   else
--     self:playsound(Dialogue and Dialogue.Sound)
--   end
-- end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DStory, "DStory")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DStory", DStory)


