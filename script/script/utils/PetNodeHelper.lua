local PetNodeHelper = {}
--@@@@[[[[
function PetNodeHelper:onInitXML()
	local set = self._set
--    self._@star = set:getElfNode("@star")
--    self._@star5 = set:getSimpleAnimateNode("@star5")
--    self._@star6_1 = set:getSimpleAnimateNode("@star6_1")
--    self._@star6_2 = set:getSimpleAnimateNode("@star6_2")
--    self._@star_gray = set:getElfGrayNode("@star_gray")
--    self._@star5_gray = set:getElfGrayNode("@star5_gray")
--    self._@star6_1_gray = set:getElfGrayNode("@star6_1_gray")
--    self._@star6_2_gray = set:getElfGrayNode("@star6_2_gray")
end
--@@@@]]]]
--no used above
--------------------------------override functions----------------------
local config = require 'Config'
local utils = require 'framework.helper.Utils'

local factory = XMLFactory:getInstance()
factory:setZipFilePath(config.COCOS_ZIP_DIR.."PetNodeHelper.cocos.zip")
local document = factory:createDocument("PetNodeHelper.cocos")
document:retain()

local createCellSet = function ( name )
   local element = factory:findElementByName(document, name)
   assert(element) 

   local cset = factory:createWithElement(element)
   local luaset = utils.toluaSet(cset)
   if luaset then
      luaset[1]:setVisible(true)
   end
   return luaset
end

local adjustPosition = function ( node,offsetx,offsety )
   if node and not node.posadjusted then
      local x,y = node:getPosition()
      node:setPosition(ccp(x+offsetx,y+offsety))
      node.posadjusted = true
   end
end
------------------------------------------------------------------------------------------------------------
local gameFunc = require "AppData"
local res = require "Res"
local dbManager = require "DBManager"
local eventCenter = require 'EventCenter'
local GuideHelper = require 'GuideHelper'
local netModel = require 'netModel'
local Toolkit = require 'Toolkit'

local PetNodeHelper = {}
local unkown = "???"

--[[
   set结构见DPetDetailV.xml @fetter
]]
function PetNodeHelper.updateFetter(self,set,dbPet,fetterPetIdListWithPartners)
   local petids = {}

   local isSelfPetFunc  = function ( petid,dbpet )
      dbpet = dbpet or dbManager.getCharactor(petid)

      if dbpet and dbpet.skin_id == dbPet.skin_id and dbPet.evove_level > dbpet.evove_level then

         for k,v in pairs(dbPet.evove_branch) do
            if table.find(dbpet.evove_branch,v) then
               return true
            end
         end

         return false
      end
      if petid == dbPet.id then
         return true
      end
      return false
   end

   local foundPetIdFunc = function ( ids,petid,dbpet )
      if isSelfPetFunc(petid,dbpet) then
         return true
      end

      if ids then
         for i,v in ipairs(ids) do
            if petid == v then
               return true
            end
         end
      end
      return false
   end

   local fetterPetIdsFunc = function ( ids )
      for i,v in ipairs(ids) do
         if not foundPetIdFunc(petids,v) then
            table.insert(petids,v)
         end
      end
   end
   
   local getPetNamesFunc = function ( ids, enable,Values)
      local names = {}
      for i,v in ipairs(ids) do
         local dbpet = dbManager.getCharactor(v)
         if not isSelfPetFunc(v,dbpet) then
            table.insert(names,string.format('\\[%s\\]',(dbpet and dbpet.name or unkown) ))
         end
      end
      
      local ret = table.concat(names,'')
      if require 'script.info.Info'.LANG_NAME == 'kor' then
         ret = table.concat(names,'&')
      end

      if enable then
         ret = string.format('[color=ffcb12ff]%s[/color]',ret)
      end

      Values = string.split(Values,'|')
      local vstr1 = (tonumber(Values[1]) > 0 and string.format(res.locString('PetInfo$ATKadd'),Values[1])) or ''
      local vstr2 = (tonumber(Values[2]) > 0 and string.format(res.locString('PetInfo$HPadd'),Values[2])) or ''
      local strdiv = (tonumber(Values[1]) > 0 and tonumber(Values[2]) > 0 and ',') or ''
      return ret,string.format('%s%s%s',vstr1,strdiv,vstr2) 
   end

   local enablepetids = {}
   for i,v in ipairs(dbPet.relate_arr) do
      local fetterTable = dbManager.getInfoFetterConfig(v)
      local enable  = gameFunc.fetterIsActive(fetterTable,fetterPetIdListWithPartners) == true and not self.isPetFromDbPet
      local itemset = self:createLuaSet('@item')
      local des = string.format(res.locString('PetInfo$feeterFormat'),getPetNamesFunc(fetterTable.Keys,enable,fetterTable.Values))

      itemset['layout_state']:setResid(enable and 'N_JH_dg.png' or 'N_JH_x.png')
      -- itemset['layout_des']:setDimensions(CCSizeMake(400,0))
      itemset['layout_des']:setString(des)
      itemset['layout_des']:setOpacity(enable and 255 or 128)
      local dessize  = itemset['layout_des']:getContentSize()
      local itemsize = itemset[1]:getContentSize()
      itemset[1]:setContentSize(CCSizeMake(itemsize.width,math.max(itemsize.height,dessize.height)))

      set['linearlayout']:addChild(itemset[1])
      for i1,v1 in ipairs(fetterTable.Keys) do
         enablepetids[v1] = enable   
      end
      fetterPetIdsFunc(fetterTable.Keys)
   end

   for i,v in ipairs(petids) do
      local petset = self:createLuaSet('@pet')
      set['linearlayout_pets_layout']:addChild(petset[1])   

      local dbpet = dbManager.getCharactor(v)
      petset["pz"]:setResid(res.getPetPZ(0))
      if dbpet then
         petset['icon']:setResid(res.getPetIcon(dbpet.id))
         petset["name"]:setString(dbpet.name)
      else
         petset['name']:setString(unkown)
         petset['icon']:setResid('FB_wenti.png')
         petset['icon']:setPosition(ccp(0,-8))
      end
      require 'LangAdapter'.LabelNodeAutoShrink(petset['name'],70)
      petset[1]:setOpacity(enablepetids[v] and 255 or 128)

      petset["name"]:setDimensions(CCSize(0,0))
      require "LangAdapter".LabelNodeAutoShrink( petset["name"], 60 )
   end
end

--set 结构见DPetSSCall @item
function PetNodeHelper.updatePetItem(self, set,petid,nPet )

   nPet = nPet or require 'PetInfo'.getPetInfoByPetId(petid)
   local dbPet = dbManager.getCharactor(nPet.PetId)
   
   set['pet_icon']:setResid(res.getPetIcon(nPet.PetId))
   set["pet_pz"]:setResid(res.getPetPZ(nPet.AwakeIndex))
   -- set["pet_property"]:setResid(res.getPetPropertyIcon(dbPet.prop_1,true))
   set["pet_career"]:setResid(res.getPetCareerIcon(dbPet.atk_method_system))
   PetNodeHelper.updateStarLayout(set['starLayout'],dbPet)

end

--因为每处可能对于星星的排版间隔都有所不同，所以父节点为layout, isLeftMode＝true表示星星左对齐，默认居中
function PetNodeHelper.updateStarLayout( layout,dbPet,petid, isLeftMode, gray )
   layout:removeAllChildrenWithCleanup(true)
   local dbPet = dbPet or dbManager.getCharactor(petid)
   if dbPet then
      local subfix = (gray and '_gray') or ''
      if dbPet.star_level < 5 or dbPet.quality < 15 then
         for i=1, dbPet.star_level do
            local star = createCellSet('@star'..subfix)
            layout:addChild(star[1])
         end
      elseif dbPet.star_level == 5 and dbPet.quality >= 15 then
      	local star = createCellSet('@star5'..subfix)
   		if isLeftMode then
   			local pNode = ElfNode:create()
   			layout:addChild(pNode)
   			pNode:addChild(star[1])
   			star[1]:setPosition(ccp(42.857132, 0))
   		else
   			layout:addChild(star[1])
   		end
      elseif dbPet.star_level == 6 and dbPet.quality < 18 then
         local star = createCellSet('@star6_1'..subfix)
         if isLeftMode then
      		local pNode = ElfNode:create()
      		layout:addChild(pNode)
      		pNode:addChild(star[1])
      		star[1]:setPosition(ccp(52.5, 0))
         else
         	layout:addChild(star[1])
         end
         
      elseif dbPet.star_level == 6 and dbPet.quality >= 18 then
         local star = createCellSet('@star6_2'..subfix)
         if isLeftMode then
      		local pNode = ElfNode:create()
      		layout:addChild(pNode)
      		pNode:addChild(star[1])
      		star[1]:setPosition(ccp(52.5, 0))
         else
         	layout:addChild(star[1])
         end
      end
      layout:layout()
   end
end

function PetNodeHelper.updateStarLayoutX(layout, dbPet, scale)
   local scale = scale or 1
   if dbPet then
      layout:removeAllChildrenWithCleanup(true)
      if dbPet.star_level == 5 and dbPet.quality >= 15 then
         local star = createCellSet('@star5')
         star[1]:setScale(scale)
         layout:addChild(star[1])
      elseif dbPet.star_level == 6 and dbPet.quality < 18 then
         local star = createCellSet('@star6_1')
         star[1]:setScale(scale)
         layout:addChild(star[1])
      elseif dbPet.star_level == 6 and dbPet.quality >= 18 then
         local star = createCellSet('@star6_2')
         star[1]:setScale(scale)
         layout:addChild(star[1])
      end
   end
end

return PetNodeHelper
