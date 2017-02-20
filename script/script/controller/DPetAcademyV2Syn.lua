local res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local AppData = require 'AppData'

local subViewSyn = {}
local parent = {}



function subViewSyn:release( ... )
  subViewSyn.sets = nil
  parent._root_content3_petSynthesis_BG_list:getContainer():removeAllChildrenWithCleanup(true)
end

function subViewSyn:initSubView(rootView)
  parent = rootView
  subViewSyn.synthesisPrice = dbManager.getDeaultConfig('petmixcost').Value
end

function subViewSyn:updateSynthesisView()--
  subViewSyn:resetAnimate()
  parent:send(require 'netModel'.getModelComposeRecordGet(), function (netData)
      subViewSyn.hidePetsList = netData.D.PetIdList or {}
      subViewSyn:updateList(subViewSyn.hidePetsList)
   end)
end

function subViewSyn:resetAnimate( ... )
  for i = 1, 5 do
    parent[string.format('_root_content3_petSynthesis_material%d_anim', i)]:setVisible(false)
  end
end

function subViewSyn:updateList(hidePets)
  local tempList = dbManager.getCharactorCanSyn()
  local petList = {}
  for i = 1, #tempList do
    local show = true
    for k, v in pairs(hidePets) do
      if tempList[i].id == v then
        show = false
        break
      end
    end
    if show then
      table.insert(petList, tempList[i])
    end
  end

  for i = 1, #petList do
    petList[i].couldSyn = subViewSyn:couldSynthesis(petList[i])
  end
  -- sort pets
  table.sort(petList, function(pet1, pet2)
    if pet1.couldSyn ~= pet2.couldSyn then
      return pet1.couldSyn
    else
      return pet1.quality > pet2.quality
    end
  end)
  for i = 1, #petList do
    subViewSyn:createOrRefreshCell(petList[i], i)
  end
  
  --if not dontTriggle then
  if subViewSyn.sets and next(subViewSyn.sets) then
    parent._root_content3_petSynthesis_BG_list:layout()
    subViewSyn.sets[1][1]:trigger(nil)

    for i = #petList + 1, #subViewSyn.sets do
      subViewSyn.sets[i][1]:setScale(0)
      parent._root_content3_petSynthesis_BG_list:layout()
    end
  end
  -- else
  --  --subViewSyn._root_content3_petSynthesis_BG_list:layout()
  --  subViewSyn.sets[specialIndex][1]:trigger(nil)
  -- end
end

function subViewSyn:createOrRefreshCell(DBPet, index)
  if not subViewSyn.sets then
    subViewSyn.sets = {}
  end

  print('msg:-------------index: '..tostring(index))
  if not subViewSyn.sets[index] then
    local set = parent:createLuaSet('@tabCell')
    set.petID = DBPet.id
    table.insert(subViewSyn.sets, set)
    --subViewSyn.sets[DBPet.id] = set
    parent._root_content3_petSynthesis_BG_list:getContainer():addChild(set[1])
  end
  
  local set = subViewSyn.sets[index]
  subViewSyn:createNumber(set['numberLayout'], tonumber(DBPet.quality), '@litterNum')
  set['normal_name']:setString(DBPet.name)
  set['pressed_name']:setString(DBPet.name)
  set['pet_normal_elf_icon']:setResid(res.getPetIcon(DBPet.id))
    set['pet_normal_elf_frame']:setResid(res.getPetIconFrame())
  set[1]:setListener(function()
      subViewSyn:organizeMaterial(DBPet.need_pet)
      subViewSyn:refreahRightView(DBPet)
      subViewSyn._tarPet = DBPet
    end)
    set['pet']:setListener(function()
      set[1]:trigger(nil)
    end)
    if DBPet.couldSyn then
      set['dot']:setVisible(true)
    else
      set['dot']:setVisible(false)
    end
end

function subViewSyn:createNumber(parentNode, num, cellName)
  local nums = {}
  while num >= 10 do
    table.insert(nums, num % 10)
    num = num / 10
  end
  table.insert(nums, num % 10)

  parentNode:removeAllChildrenWithCleanup(true)
  for i = #nums, 1, -1 do
    local set = parent:createLuaSet(cellName)
    set['v']:setResid(string.format('JLXY_wenzi%d.png', nums[i]))
    parentNode:addChild(set[1])
  end
end

function subViewSyn:updateSynBtnState(DBPet)
  local hasAllSpe = true
  for k, v in pairs(subViewSyn.specialMaterial) do
    if v.missing then
      hasAllSpe = false 
      break
    end
  end
  if AppData.getUserInfo().getGold() < subViewSyn.synthesisPrice or (not hasAllSpe) or #subViewSyn.anyMaterial < 5 - #DBPet.need_pet then
    parent._root_content3_petSynthesis_btnSyn:setEnabled(false)
  else
    parent._root_content3_petSynthesis_btnSyn:setEnabled(true)
  end
end

function subViewSyn:refreahRightView(DBPet)

  parent._root_content3_petSynthesis_result:setListener(function()
    GleeCore:showLayer("DPetDetailV",{PetInfo = AppData.getPetInfo().getPetInfoByPetId(DBPet.id)})
  end)

  --local synPrice = dbManager.getDeaultConfig('petmixcost').Value
  parent._root_content3_petSynthesis_price_value:setString(tostring(subViewSyn.synthesisPrice))
  if AppData.getUserInfo().getGold() < subViewSyn.synthesisPrice then
    parent._root_content3_petSynthesis_price_value:setFontFillColor(ccc4f(1, 0, 0, 1.0),true)
  else
    parent._root_content3_petSynthesis_price_value:setFontFillColor(ccc4f(0, 0, 0, 1.0),true)
  end

  -- if not subViewSyn:couldSynthesisNow(DBPet) then
  --  subViewSyn._root_content3_petSynthesis_btnSyn:setEnabled(false)
  -- else
  --  subViewSyn._root_content3_petSynthesis_btnSyn:setEnabled(true)
  -- end
  subViewSyn:updateSynBtnState(DBPet)

  parent._root_content3_petSynthesis_btnSyn:setListener(function()

    if not subViewSyn:allMaterialsAvailable() then
      return 
    end

    local param = {}
    param.content = subViewSyn:getConfirmTips() --res.locString("PetSynthesis$_Confirm")
    param.callback = function ( ... )
      local ids = {}
      for k, v in pairs(subViewSyn.specialMaterial) do
        table.insert(ids, v.Id)
      end

      for k, v in pairs(subViewSyn.anyMaterial) do
        table.insert(ids, v.Id)
      end

      parent:send(require "netModel".getModelPetSynthesis(ids, DBPet.id), function (data)
              AppData.updateResource(data.D.Resource)
              local rpet = data.D.Resource.Pets[1]
              subViewSyn:playSynAnimate(rpet)
              -- delete pets used
              for k, v in pairs(ids) do
                AppData.getPetInfo().removePetById(v)
              end
          end)
    end
    GleeCore:showLayer("DConfirmNT",param)
  end)

    parent._root_content3_petSynthesis_result_normal_clip_icon:setResid(res.getPetWithPetId(DBPet.id))
    parent._root_content3_petSynthesis_result_normal_career:setResid(res.getPetCareerIcon(DBPet.atk_method_system))

    res.adjustPetIconPositionInParentLT(parent._root_content3_petSynthesis_result_normal_clip, parent._root_content3_petSynthesis_result_normal_clip_icon, DBPet.id, 'academy', 0)

    parent._root_content3_petSynthesis_result_normal_clip_numberLayout:removeAllChildrenWithCleanup(true)

    subViewSyn:createNumber(parent._root_content3_petSynthesis_result_normal_clip_numberLayout, DBPet.quality, '@bigNum')
    parent._root_content3_petSynthesis_result_normal_nameBg_name:setString(DBPet.name)
  --if not subViewSyn.starCreated then
    parent._root_content3_petSynthesis_result_normal_starLayout:removeAllChildrenWithCleanup(true)
    require 'PetNodeHelper'.updateStarLayout(parent._root_content3_petSynthesis_result_normal_starLayout, DBPet)

    -- parent._root_content3_petSynthesis_result_normal_starLayout:removeAllChildrenWithCleanup(true)
    -- for i = 1, DBPet.star_level do
    --   local set = parent:createLuaSet('@star')
    --   parent._root_content3_petSynthesis_result_normal_starLayout:addChild(set[1])
    -- end
    --subViewSyn.starCreated = true
  --end
  
  subViewSyn:refreshMaterial()
end

function subViewSyn:getConfirmTips()
  for k, v in pairs(subViewSyn.specialMaterial) do
    if not AppData.getPetInfo().isPetInitStatus(v) then
      return res.locString("PetSynthesis$_Confirm1")
    end
  end

  for k, v in pairs(subViewSyn.anyMaterial) do
    if not AppData.getPetInfo().isPetInitStatus(v) then
      return res.locString("PetSynthesis$_Confirm1")
    end
  end

  return res.locString("PetSynthesis$_Confirm")
end

function subViewSyn:allMaterialsAvailable()--specialM, anyM
  local total = {}
  for i = 1, #subViewSyn.specialMaterial do
    table.insert(total, subViewSyn.specialMaterial[i])
  end

  for i = 1, #subViewSyn.anyMaterial do
    table.insert(total, subViewSyn.anyMaterial[i])
  end

  for i = 1, #total do
    local DBPet = dbManager.getCharactor(total[i].PetId)
    if AppData.getPetInfo().isPetInTeam(total[i].Id) then
      parent:toast(string.format('%s%s', DBPet.name, res.locString('PetSynthesis$_In_Team')))
      return false
    elseif AppData.getPetInfo().petInStorage(total[i].Id) then
      parent:toast(string.format('%s%s', DBPet.name, res.locString('PetSynthesis$_In_Storage')))
      return false
    elseif AppData.getExploreInfo().petInExploration(total[i].Id) then
      parent:toast(string.format('%s%s', DBPet.name, res.locString('PetSynthesis$_In_Explore')))
      return false
    end
  end

  return true
end

function subViewSyn:organizeMaterial(specialIDs)
  subViewSyn.specialMaterial = {}
  subViewSyn.anyMaterial = {}
  for i = 1, #specialIDs do
    local netPet = subViewSyn:getDefaultSpecialPet(specialIDs[i])

    if not netPet then
      netPet = {missing = true, PetId = specialIDs[i]}
    end
    netPet._targetPetId = specialIDs[i]
    table.insert(subViewSyn.specialMaterial, netPet)
  end

  local any = subViewSyn:getAll5StarPets(true)
  for i = 1, 5 - #specialIDs do
    table.insert(subViewSyn.anyMaterial, any[i])
  end
end

function subViewSyn:petInSpecialM(ID)
  if (not subViewSyn.specialMaterial) or (not next(subViewSyn.specialMaterial)) then
    return false
  end

  for k, v in pairs(subViewSyn.specialMaterial) do
    if v.Id == ID then
      return true
    end
  end
  return false
end

function subViewSyn:petInAnyM(ID)
  if (not subViewSyn.anyMaterial) or (not next(subViewSyn.anyMaterial)) then
    return false
  end

  for k, v in pairs(subViewSyn.anyMaterial) do
    if v.Id == ID then
      return true
    end
  end
  return false
end

function subViewSyn:couldSynthesis(DBPet)
  if AppData.getUserInfo().getGold() < subViewSyn.synthesisPrice then
    return false
  end

  local special = {}
  for i = 1, #DBPet.need_pet do
    local netPet = AppData.getPetInfo().getPetWithSkinId(DBPet.need_pet[i])
    if not netPet then
      return false
    else
      table.insert(special, netPet)
    end
  end

  if #special > 4 then return true end

  -- has two any pets
  local amount = 0
  local pets = AppData.getPetInfo().getAllPets()
  for k, v in pairs(pets) do
    if v.Star == 5 then
      local VDBPet = dbManager.getCharactor(v.PetId)
      if not VDBPet.ev_pet then
        local ok = true
        for k1, v1 in pairs(special) do
          if v1.Id == v.Id then
            ok = false
            break
          end
        end
        if ok then
          amount = amount + 1
          if amount >= 5 - #DBPet.need_pet then
            return true
          end
        end
      end
    end
  end

  return false
end

function subViewSyn:refreshMaterial()
  for i = 1, #subViewSyn.specialMaterial do
    subViewSyn:refreshSpecialM(i, subViewSyn.specialMaterial[i])
  end

  local index = 1
  for i = #subViewSyn.specialMaterial + 1, 5 do
    local pet = subViewSyn.anyMaterial[index]
    subViewSyn:refreshAnyM(i, pet)
    index = index + 1
  end
end

function subViewSyn:getAll5StarPets(reset)
  if reset or not subViewSyn.all5StarsPets then
    subViewSyn.all5StarsPets = {}
    local pets = AppData.getPetInfo().getAllPets()
    --local fiveStar = {}
    for k, v in pairs(pets) do
      local DBPet = dbManager.getCharactor(v.PetId)
      if not DBPet.ev_pet and v.Star == 5 and (not subViewSyn:petInSpecialM(v.Id)) then
        table.insert(subViewSyn.all5StarsPets, v)
      end
    end

    table.sort(subViewSyn.all5StarsPets, function(pet1, pet2)
      local DBPet1 = dbManager.getCharactor(pet1.PetId)
      local DBPet2 = dbManager.getCharactor(pet2.PetId)
      if DBPet1.quality ~= DBPet2.quality then
        return DBPet1.quality < DBPet2.quality
      else
        return pet1.Lv < pet2.Lv
      end
    end)
  end

  return subViewSyn.all5StarsPets
end

function subViewSyn:getDefaultSpecialPet(petID)
  local pets =  AppData.getPetInfo().getPetWithSkinId(petID, true)
  local results = {}
  
  for k, v in pairs(pets) do
    if not subViewSyn:petInAnyM(v.Id) then
      table.insert(results, v)
    end
  end

  if #results > 1 then
    table.sort(results, function(pet1, pet2)
      if pet1.AwakeIndex ~= pet2.AwakeIndex then
        return pet1.AwakeIndex < pet2.AwakeIndex
      else
        return pet1.Lv < pet2.Lv
      end
    end)
  end

  return results[1]
end

function subViewSyn:getFreeSpecialPet(NPet)
  local pets =  AppData.getPetInfo().getPetWithSkinId(NPet._targetPetId or NPet.PetId, true)
  local results = {}
  
  for k, v in pairs(pets) do
    if not subViewSyn:petInAnyM(v.Id) and v.Id ~= NPet.Id then
      table.insert(results, v)
    end
  end

  if #results > 1 then
    table.sort(results, function(pet1, pet2)
      if pet1.AwakeIndex ~= pet2.AwakeIndex then
        return pet1.AwakeIndex < pet2.AwakeIndex
      else
        return pet1.Lv < pet2.Lv
      end
    end)
  end

  table.insert(results, 1, NPet)

  return results
end

function subViewSyn:choosedSpeM(ID)
  for k, v in pairs(subViewSyn.specialMaterial) do
    if v.Id == ID then
      return true
    end
  end
  return false
end

function subViewSyn:refreshSpecialM(index, netPet)
  parent[string.format('_root_content3_petSynthesis_material%d_normal_none', index)]:setVisible(false)
  parent[string.format('_root_content3_petSynthesis_material%d_normal_pet', index)]:setVisible(true)

  local DBPet = dbManager.getCharactor(netPet.PetId)
  parent[string.format('_root_content3_petSynthesis_material%d', index)]:setListener(function()
    if netPet.missing then
      GleeCore:showLayer("DPetDetailV",{PetInfo = AppData.getPetInfo().getPetInfoByPetId(DBPet.id)})

    else
      -- click to change material
      local param = {}
        param.couldCancel = false
        param.petList = subViewSyn:getFreeSpecialPet(netPet)--AppData.getPetInfo().getPetWithPetId(netPet.PetId, true)
        param.selectPets = subViewSyn.specialMaterial

        param.selectCallback = function(selPet)
          
          netPet = selPet

          for i = 1, #subViewSyn.specialMaterial do
            local dbpet1 = dbManager.getCharactor(subViewSyn.specialMaterial[i].PetId)
            local dbpet2 = dbManager.getCharactor(netPet.PetId)

            if dbpet1.skin_id == dbpet2.skin_id then
              selPet._targetPetId = subViewSyn.specialMaterial[i]._targetPetId
              subViewSyn.specialMaterial[i] = selPet
            end
          end

          subViewSyn:refreshSpecialM(index, netPet)
        end

      GleeCore:showLayer('DPetSynChosMaterial', param)
    end
  end)
  parent[string.format('_root_content3_petSynthesis_material%d_name', index)]:setString(DBPet.name)
  parent[string.format('_root_content3_petSynthesis_material%d_normal_pet_icon', index)]:setResid(res.getPetIcon(DBPet.id))
  
  if netPet.missing then
      parent[string.format('_root_content3_petSynthesis_material%d_normal_pet_frame', index)]:setResid(res.getPetIconFrame())
  else
    parent[string.format('_root_content3_petSynthesis_material%d_normal_pet_frame', index)]:setResid(res.getPetIconFrame(netPet))
  end
  --print('msg:-=----------------index:  '..tostring(index))
  if netPet.missing then
    parent[string.format('_root_content3_petSynthesis_material%d', index)]:setColorf(1, 1, 1, 0.5)
    -- subViewSyn[string.format('_root_content3_petSynthesis_material%d_lock', index)]:setVisible(true)
  else
    parent[string.format('_root_content3_petSynthesis_material%d', index)]:setColorf(1, 1, 1, 1)
    --subViewSyn[string.format('_root_content3_petSynthesis_material%d_lock', index)]:setVisible(false)
  end
  --subViewSyn[string.format('_root_content3_petSynthesis_material%d_lock', index)]:setVisible(true)
end

function subViewSyn:refreshAnyM(index, netPet)
  parent[string.format('_root_content3_petSynthesis_material%d', index)]:setColorf(1, 1, 1, 1)
  --subViewSyn[string.format('_root_content3_petSynthesis_material%d_lock', index)]:setVisible(false)
  
  parent[string.format('_root_content3_petSynthesis_material%d', index)]:setListener(function()
    -- have no enough materials
    --local anyMateris = subViewSyn:getAll5StarPets()
    --if #anyMateris <= #subViewSyn.anyMaterial then
    if not netPet and #subViewSyn:getAll5StarPets() < 1 then
      return parent:toast(res.locString('PetSynthesis$_LackOfMaterials'))
    end

    -- have materials to choose
      local param = {}
      param.couldCancel = true
      param.petList = subViewSyn:getAll5StarPets(true)
      param.selectPets = subViewSyn.anyMaterial
      param.selectCallback = function(pets)
        local specialAmount = #subViewSyn._tarPet.need_pet

        subViewSyn.anyMaterial = pets
        for i = 1, 5 - specialAmount do
        subViewSyn:refreshAnyM(i + specialAmount, subViewSyn.anyMaterial[i])
      end
      subViewSyn:updateSynBtnState(subViewSyn._tarPet)
      end

    GleeCore:showLayer('DPetSynChosAnyMaterial', param)
  end)

  if not netPet then
    parent[string.format('_root_content3_petSynthesis_material%d_normal_none', index)]:setVisible(true)
    parent[string.format('_root_content3_petSynthesis_material%d_normal_pet', index)]:setVisible(false)

    parent[string.format('_root_content3_petSynthesis_material%d_name', index)]:setString('')
    -- subViewSyn[string.format('_root_content3_petSynthesis_material%d', index)]:setListener(function()
    --  return parent:toast(res.locString('PetSynthesis$_LackOfMaterials'))
    -- end)   
    return
  else--if subViewSyn[string.format('_root_content3_petSynthesis_material%d_normal_none', index)] then
    parent[string.format('_root_content3_petSynthesis_material%d_normal_none', index)]:setVisible(false)
    parent[string.format('_root_content3_petSynthesis_material%d_normal_pet', index)]:setVisible(true)
  end

  local DBPet = dbManager.getCharactor(netPet.PetId)
  parent[string.format('_root_content3_petSynthesis_material%d_name', index)]:setString(DBPet.name)
  parent[string.format('_root_content3_petSynthesis_material%d_normal_pet_icon', index)]:setResid(res.getPetIcon(DBPet.id))
  
  parent[string.format('_root_content3_petSynthesis_material%d_normal_pet_frame', index)]:setResid(res.getPetIconFrame(netPet))
end

function subViewSyn:playSynAnimate(rpet)
  for i = 1, 5 do
    parent[string.format('_root_content3_petSynthesis_material%d_anim', i)]:setVisible(true)
    parent[string.format('_root_content3_petSynthesis_material%d_anim', i)]:setLoops(1)
    parent[string.format('_root_content3_petSynthesis_material%d_anim', i)]:reset()
    parent[string.format('_root_content3_petSynthesis_material%d_anim', i)]:start()
    parent[string.format('_root_content3_petSynthesis_material%d_anim', i)]:setListener(function()
      parent[string.format('_root_content3_petSynthesis_material%d_anim', i)]:setVisible(false)

      if i == 5 then
        GleeCore:showLayer('DEvolveSucceed', {pet = rpet, titleResid = 'N_HCZZ_z.png'}) --N_JH_jhcg.png
        -- refresh dot
        if rpet.Star == 5 then
            table.insert(subViewSyn.hidePetsList, rpet.PetId)
        end
        subViewSyn:getAll5StarPets(true)
        subViewSyn:updateList(subViewSyn.hidePetsList)
      end
    end)
  end
end

return subViewSyn

