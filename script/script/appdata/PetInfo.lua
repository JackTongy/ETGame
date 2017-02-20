--[[
	精灵 (Pet)
	字段				类型				说明
	Rid					Int					玩家id
	PetId				Int					精灵系统id(配置id)
	Name				String				昵称
	Star				Byte				星级
	Lv					Byte				等级
	Atk					Int					攻击力
	Def					Int					防御力
	Hp					Int					生命值
	Exp				Int					经验值
	Crit				Double				暴击率
	HpP				Double				生命成长值
	AtkP				Double				攻击成长值
	AtkMethod			Byte				攻击类型
	Prop				Byte				属性
	Intimacy			Int					亲密度
	Potential			Int					潜力
	AwakeIndex		Int					觉醒阶数
	Fetter				List<int>			羁绊列表
	MoveSpeed		Double				移动速度
	AtkSpeed			Double				攻击速度
]]

local dbManager = require "DBManager"
local eventCenter = require 'EventCenter'

-- 精灵模块
local petFunc = {}
local petData = {}
local petPieces = {}
local petArchived
local petArchivedDict
local petIdCollectionList
local petPiecesSynced = false

function petFunc.cleanData()
	petData = {}
	petPieces = {}
	petArchivedDict = nil
	petArchived = nil
	petIdCollectionList = nil
	petPiecesSynced = false
end

function petFunc.getPetInfoByPetId( id,awakeIndex,powerc )
	local dbInfo = dbManager.getCharactor(id)
	local pet = {}
	
	pet.Id = id		-- Id 动态Id
	pet.Power = (powerc and petFunc.getDbPetPower(dbInfo)) or 0
	pet.PetId = id   ---静态Id
	pet.Name = dbInfo.name
	pet.Star = dbInfo.star_level
	pet.Lv = 1
	pet.Atk = dbInfo.atk
	pet.Def = dbInfo.def
	pet.Hp = dbInfo.hp
	pet.Exp = 0
	pet.Crit = dbInfo.crit
	pet.HpP = dbInfo.hp_grow
	pet.AtkP = dbInfo.atk_grow
	pet.AtkMethod = dbInfo.atk_method
	pet.Prop = dbInfo.prop_1
	pet.Intimacy = dbInfo.intimacy
	pet.Potential = dbInfo.star_level>2 and 1 or 0
	pet.AwakeIndex = awakeIndex or 0
	pet.Fetter = dbInfo.relate_arr
	pet.MoveSpeed = dbInfo.Spd
	pet.AtkTime = 0
	pet.MotiCnt = 0
	pet.ResCnt = 0
	pet.quality = dbInfo.quality
	pet.fromdb = true
	return pet
end

function petFunc.getPetAwakeColor(awake)
	local awakeColor = nil
	local Res = require 'Res'
    if awake == 4 then --绿色
        awakeColor = Res.locString("Global$ColorGreen")
    elseif awake == 8 then -- 蓝色
        awakeColor = Res.locString("Global$ColorBlue")
    elseif awake == 12 then -- 紫色
        awakeColor = Res.locString("Global$ColorPurple")
    elseif awake == 16 then -- 橙色
        awakeColor = Res.locString("Global$ColorOrange")
    elseif awake == 20 then -- 金色
        awakeColor = Res.locString("Global$ColorGolden")
    elseif awake == 24 then -- 红色
        awakeColor = Res.locString("Global$ColorRed")
    end

    return awakeColor
end

function petFunc.getDbPetPower( dbpet )
	local atk = (dbpet.crit*dbpet.atk*(1.5+dbpet.Cv) + (1-dbpet.crit)*dbpet.atk*1)*(1)+dbpet.Sv
	local dfd = dbpet.hp/(1-0.0006*dbpet.def/(7+0.0006*dbpet.def))+dbpet.Fv
	return math.floor(atk*0.2+dfd*0.2)
end

-- 返回精灵列表
function petFunc.getPetList(  )
	return petData
end

-- 设置精灵列表
function petFunc.setPetList( list )
	petData = list
	for i,v in ipairs(petData) do
		petFunc.convertToC(v)
	end
end
 
function petFunc.getPetArchived( ... )
	return petArchived
end

function petFunc.setPetArchived( list )
	petArchived = list or {}
end

function petFunc.getPetArchivedDict( ... )
	return petArchivedDict
end

function petFunc.setPetArchivedDict( dict )
	petArchivedDict = dict or {}
end

function petFunc.getPetIdCollectionList( ... )
	return petIdCollectionList
end

function petFunc.setPetIdCollectionList( list )
	petIdCollectionList = list or {}
end

-- 返回相应ID的精灵
function petFunc.getPetWithId( id )
	for k,v in pairs(petData) do
		if v.Id == id then
			return v
		end
	end
	return nil
end

function petFunc.addPets( pets )
	if pets then
		table.foreach(pets,function ( _,v )
			petFunc.setPet(v, pets)
		end)
		eventCenter.eventInput('UpdateBattleValue')
	end
end

-- 设置单个精灵
function petFunc.setPet( pet, pets )

	if pet and (not pet.Id or pet.Id == 0) then
		--精灵没有唯一ID时 已有精灵数量已达上限
		require 'Toolkit'.showDialogOnPetListMax()
		return 
	end

	petFunc.convertToC(pet)

	local has = false
	local isEvolve = false
	for k,v in pairs(petData) do
		if v.Id == pet.Id then
			petData[k] = pet
			has = v.PetId == pet.PetId -- 进化后PetId变化，Id不变
			isEvolve = v.PetId ~= pet.PetId
			break
		end
	end

	if not has then
		if not isEvolve then
			table.insert(petData,pet)
		end
		petFunc.doTeamPetUpdate(pet.Id)

		if petIdCollectionList and not table.find(petIdCollectionList, pet.PetId) then -- 图鉴加成
			local CSValueConverter = require "CSValueConverter"

			table.insert(petIdCollectionList, pet.PetId)
			local groupList = dbManager.getInfoCollectionGroupConfig()
			for i,v in ipairs(groupList) do
				if table.find(v.Group, pet.PetId) and petFunc.isCollectionGroupSuccess(v.Group) then
					for _,nPet in ipairs(petData) do
						local canFind = false
						for k,v in pairs(pets) do
							if v.Id == nPet.Id then
								canFind = true
								break
							end
						end
						if not canFind then
							nPet.Atk = nPet.Atk + v.Attack
							nPet.Hp = nPet.Hp + v.Hp
							nPet._Atk = CSValueConverter.toC( CSValueConverter.toS(nPet._Atk) + v.Attack )
							nPet._Hp = CSValueConverter.toCHp( CSValueConverter.toSHp(nPet._Hp) + v.Hp )
						end
					end
					break
				end
			end
		end
	end
end

function petFunc.convertToC( nPet )
	if nPet then
		local CSValueConverter = require "CSValueConverter"
		nPet._Hp = CSValueConverter.toCHp(nPet.Hp)
		nPet._Atk = CSValueConverter.toC(nPet.Atk)
		nPet._Def = CSValueConverter.toC(nPet.Def)
		
		-- nPet._Crit = CSValueConverter.toC(nPet.Crit)
		nPet._Crit = nPet.Crit
		-- nPet._MoveSpeed = CSValueConverter.toC(nPet.MoveSpeed)
		nPet._MoveSpeed = nPet.MoveSpeed

		nPet.Sv = nPet.Sv or 0
		nPet.Fv = nPet.Fv or 0

		nPet._HpMax = CSValueConverter.toCHp(nPet.HpMax)
		
		nPet.Eb = nPet.Eb or {}
		nPet._Sv = CSValueConverter.toC(nPet.Sv + (nPet.Eb['2'] or 0) )
		nPet._Fv = CSValueConverter.toC(nPet.Fv + (nPet.Eb['5'] or 0) )
		nPet._Cv = CSValueConverter.toC(nPet.Cv + (nPet.Eb['8'] or 0) )
		nPet._Bd = CSValueConverter.toC(nPet.Bd + (nPet.Eb['7'] or 0) )

		print('------npet------')
		print(nPet)
	end
end

function petFunc.petCollected(petID)
	if petIdCollectionList then
		for k, v in pairs(petIdCollectionList) do
			if v == petID then
				return true
			end
		end
	end
	return false
end

function petFunc.isCollectionGroupSuccess( pedIdList )
	local result = false
	if petIdCollectionList then
		result = true
		for k,v in pairs(pedIdList) do
			local canFind = false
			for k2,v2 in pairs(petIdCollectionList) do
				if v2 == v then
					canFind = true
					break
				end
			end
			if not canFind then
				result = false
				break
			end
		end
	end
	return result
end

function petFunc.isPetInMyPetList( petId )
	for k,v in pairs(petData) do
		if petId == v.PetId then
			return true
		end
	end
	return false
end

function petFunc.isPetInSameBranch( dbPet1, dbPet2 )
	if dbPet1 and dbPet2 and dbPet1.skin_id == dbPet2.skin_id then
		if dbPet1.evove_branch and dbPet2.evove_branch and #dbPet1.evove_branch > 0 and #dbPet2.evove_branch > 0 then
			for i,v in ipairs(dbPet1.evove_branch) do
				if table.find(dbPet2.evove_branch, v) then
					return true
				end
			end
		else
			return true
		end
	end
	return false
end

function petFunc.isPetClash( dbPet, pidList, expectPetId )
	for i,v in ipairs(pidList) do
		if not (expectPetId and expectPetId == v) then
			local dbPet1 = dbManager.getCharactor(petFunc.getPetWithId(v).PetId)
			if dbPet1.id == dbPet.id or (petFunc.isPetInSameBranch(dbPet1, dbPet) and dbPet1.evove_level ~= dbPet.evove_level) then
				return true
			end
		end
	end
	return false
end

-- offloadPetId 小伙伴的卸下PetId
function petFunc.sortWithTeam( list, pidList, expectPetId, offloadPetId )
	local function interSort( nPet1, nPet2 )
		if nPet1._dbPet.quality == nPet2._dbPet.quality then
			if nPet1.AwakeIndex == nPet2.AwakeIndex then
				if nPet1.Lv == nPet2.Lv then
					return nPet1._dbPet.id < nPet2._dbPet.id
				else
					return nPet1.Lv > nPet2.Lv
				end
			else
				return nPet1.AwakeIndex > nPet2.AwakeIndex
			end
		else
			return nPet1._dbPet.quality > nPet2._dbPet.quality
		end
	end

	local list = list or petData

	for i,v in ipairs(list) do 			-- 增加排序信息
		list[i]._dbPet = dbManager.getCharactor(v.PetId)
		list[i]._isClash = petFunc.isPetClash( list[i]._dbPet, pidList, expectPetId )
		if offloadPetId then
			if table.find(pidList, v.Id) then
				list[i]._isInPartner = true
				list[i]._isClash = false
			else
				list[i]._isInPartner = false
			end
		else
			list[i]._isInActiveTeam = petFunc.isPetInActiveTeam(v.Id)
		end
	end

	if offloadPetId then
		table.sort(list, function ( pet1, pet2 )
			if offloadPetId == pet1.Id then
				return true
			elseif offloadPetId == pet2.Id then
				return false
			end

			if pet1._isClash == pet2._isClash then
				if pet1._isInPartner == pet2._isInPartner then
					return interSort(pet1, pet2)
				else
					return pet2._isInPartner
				end
			else
				return pet2._isClash
			end
		end)
	else
		table.sort(list, function ( pet1, pet2 )
			if pet1._isInActiveTeam == pet2._isInActiveTeam then
				if pet1._isInActiveTeam then
					return interSort(pet1, pet2)
				else
					if pet1._isClash == pet2._isClash then
						return interSort(pet1, pet2)
					else
						return pet2._isClash
					end
				end
			else
				return pet1._isInActiveTeam
			end
		end)
	end

	for i,v in ipairs(list) do  				-- 去除排序信息，还原数据
		list[i]._isInActiveTeam = nil
		list[i]._dbPet = nil
		list[i]._isClash = nil
		list[i]._isInPartner = nil
	end
end

-- 排序：上阵、资质降序、觉醒阶数、等级降序、职业升序、属性升序、攻击力降序，ID升序
function petFunc.sortPetList( list )
	local list = list or petData
	table.sort(list, function ( pet1, pet2 )
		local isInTeam1 = petFunc.inTeamOrPartner(pet1.Id)
		local isInTeam2 = petFunc.inTeamOrPartner(pet2.Id)
		if isInTeam1 and not isInTeam2 then
			return true
		elseif isInTeam1 == isInTeam2 then
			local dbPet1 = dbManager.getCharactor(pet1.PetId)
			local dbPet2 = dbManager.getCharactor(pet2.PetId)
			if dbPet1 and dbPet2 then
				if dbPet1.quality > dbPet2.quality then
					return true
				elseif dbPet1.quality == dbPet2.quality then
					if pet1.AwakeIndex > pet2.AwakeIndex then
						return true
					elseif pet1.AwakeIndex == pet2.AwakeIndex then
						if pet1.Lv > pet2.Lv then
							return true
						elseif pet1.Lv == pet2.Lv then
							if dbPet1.atk_method_system < dbPet2.atk_method_system then
								return true
							elseif dbPet1.atk_method_system == dbPet2.atk_method_system then
								if pet1.Prop < pet2.Prop then
									return true
								elseif pet1.Prop == pet2.Prop then
									if pet1.Atk > pet2.Atk then
										return true
									elseif pet1.Atk == pet2.Atk then
										if pet1.PetId < pet2.PetId then
											return true
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function petFunc.isPetInActiveTeam( petId )
	local gameFunc = require "AppData"
	local teamFunc = gameFunc.getTeamInfo()
	local teamActive = teamFunc.getTeamActive()
	if teamActive.PetIdList then
		for k,v in pairs(teamActive.PetIdList) do
			if v == petId then
				return true
			end
		end
	end
	return teamActive.BenchPetId == petId
end

function petFunc.isPetInTeam( petId )
	local gameFunc = require 'AppData'
	local teamFunc = gameFunc.getTeamInfo()
	return teamFunc.isInTeam(petId)
end

function petFunc.getPetByCondition(func,petlist)
	petlist = petlist or petData
	local count = 0
	for k,v in pairs(petlist) do
		if func(v) then
			count = count + 1
		end
	end
	return count
end

function petFunc.removePetById( Id )
	for k,v in pairs(petData) do
		if v.Id == Id then
			table.remove(petData,k)
			require "GemInfo".getOffGem(Id)
			petFunc.modify()
			break
		end
	end
end

function petFunc.removePetByIds( ids )
	for k,v in pairs(ids) do
		petFunc.removePetById(v)
	end
end

function petFunc.getPetIDsByIds( list )
	local petids = {}
	if list and type(list) == 'table' then
		for k1,v1 in pairs(list) do
			for k,v in pairs(petData) do
				if v.Id == v1 then
					table.insert(petids,v.PetId)
				end
			end
		end
	end
	return petids
end

function petFunc.modify( data )
	eventCenter.eventInput("PetInfoModify",data)
end

--[[
用于继承的精灵所需排除的列表 （星级高于自己和等级低于自己的）
]]
function petFunc.getRemoveIdsforPassOn( pet )
	local petids = {}
	for k,v in pairs(petData) do
		if v.Star > pet.Star or v.Lv < pet.Lv then
			table.insert(petids,v.Id)
		end
	end
	table.insert(petids,pet.Id)
	return petids	
end

--[[
获取同类精灵中等级最低的精灵且没有上阵
]]
function petFunc.getPetLow( PetId ,exceptIds,Star)

	local tmp = nil
	local tmpquality = nil
	local trainInfo = require 'AppData'.getTrainInfo()
	local teamInfo = require 'AppData'.getTeamInfo()
	local partnerInfo = require 'AppData'.getPartnerInfo()
	local exploreinfo = require 'AppData'.getExploreInfo()
	local dbv 
	local dbtmp

	for k,v in pairs(petData) do
		local inexcepts = false
		for i,vexc in ipairs(exceptIds) do
			if vexc == v.Id then
				inexcepts = true
			end
		end
		if (v.PetId == PetId or v.Star == Star) and not inexcepts and not teamInfo.isInTeam(v.Id) and not trainInfo.isPetInTrain(v.Id) and not partnerInfo.isInPartner(v.Id) and not exploreinfo.petInExploration(v.Id) then
			dbv = dbManager.getCharactor(v.PetId)
			if tmp == nil or tmp.Lv > v.Lv or tmp.AwakeIndex > v.AwakeIndex then
				tmp = v
				dbtmp = dbv
			elseif dbtmp and dbtmp.quality > dbv.quality then
				tmp = v
				dbtmp = dbv
			end
		end
	end

	return tmp
end

function petFunc.getPetsByPetIds( ids,exceptIds )
	local rets = {}
	for k,v in pairs(petData) do
		if table.find(ids,v.PetId) and (not exceptIds or not table.find(exceptIds,v.Id)) then
			table.insert(rets,v)
		end		
	end
	return rets
end

function petFunc.getLowEvoveLevel( pets ,exceptIds)
	local ret = nil
	local dbret = nil
	
	for i=#pets,1,-1 do
		local v = pets[i]
		if not exceptIds or not table.find(exceptIds,v.Id) then
			local dbpet = dbManager.getCharactor(v.PetId)
			if not ret or dbpet.evove_level < dbret.evove_level then
				ret = v
				dbret = dbpet
			end
		end
	end
	return ret
end

function petFunc.getPetAmountList( nPetList )
	local result = {}
	for k,v in pairs(nPetList) do
		local canFind = false
		for k2,v2 in pairs(result) do
			if v.PetId == v2.petId then
				v2.amount = v2.amount + 1
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(result, {petId = v.PetId, amount = 1})
		end
	end
	return result
end

function petFunc.isPetEqualToAnother( pet1, pet2 )
	return pet1.PetId == pet2.PetId
end

function petFunc.getPetCountByStar( list )
	
	local table = {}--[Star]=cnt
	
	for k,v in pairs(list) do
		table[v.Star] = (table[v.Star] == nil and 1) or table[v.Star] + 1
	end
	
	return table

end

--[[
	获取用于献祭的精灵列表 
	排除 上阵（三个队伍中） 6星 小伙伴
	排除 探宝
]]
function petFunc.getPetListForMix( ... )

	local partner = require 'AppData'.getPartnerInfo()
	local teaminfo = require 'AppData'.getTeamInfo()
	local traininfo = require 'AppData'.getTrainInfo()
	local exploreinfo = require 'AppData'.getExploreInfo()
	local T = {}
	for k,v in pairs(petData) do
		if not traininfo.isPetInTrain(v.Id) and not teaminfo.isInTeam(v.Id) and not partner.isInPartner(v.Id) and not exploreinfo.petInExploration(v.Id) then
			table.insert(T,v)
		end
	end
	return T

end

--[[
	献祭时的排序 从低到高反向排序）：资质 > 觉醒阶数 > 等级 > 精灵id
]]
function petFunc.sortPetListInMix( list )

	if list then
		table.sort(list,function ( pet1,pet2 )
			local dbPet1 = dbManager.getCharactor(pet1.PetId)
			local dbPet2 = dbManager.getCharactor(pet2.PetId)

			if dbPet1.quality < dbPet2.quality then
				return true
			elseif dbPet1.quality == dbPet2.quality then
				if pet1.AwakeIndex < pet2.AwakeIndex then
					return true
				elseif pet1.AwakeIndex == pet2.AwakeIndex then
					if pet1.Lv < pet2.Lv then
						return true
					elseif pet1.Lv == pet2.Lv then
						return pet1.PetId < pet2.PetId 
					end	
				end
			end

			return false
		end)
	end

end

-- 精灵是否达到等级和经验上限（随玩家等级提升会变化），
function petFunc.isPetTopLvExp( nPet )
	local userFunc = require "UserInfo"
	local lvCap = dbManager.getPetLvCap(nPet)-- dbManager.getInfoRoleLevelCap(userFunc.getLevel()).petlvcap
	if nPet.Lv == lvCap then
		if nPet.Exp >= dbManager.getInfoPetLvConfig(nPet.Lv).Exp then
			return true
		end
	elseif nPet.Lv > lvCap then
		return true
	end
	return false
end

function petFunc.getPetIndex( nPet )
	
	local petlist = petFunc.getPetList()
	for i,v in ipairs(petlist) do
		if v.Id == nPet.Id then
			return i
		end
	end
	return -1

end

function petFunc.getPetByIndex( Index )
	local petlist = petFunc.getPetList()
	return petlist[Index]
end

function petFunc.setPetPieces( data )
	petPieces = data
	petFunc.sortPetPieces()
	syncPetPieces = true
end

function petFunc.getPetPieces(  )
	return petPieces
end

function petFunc.hasPieces( ... )
	if petPieces and #petPieces > 0 then
		for i,v in ipairs(petPieces) do
			if v.Amount > 0 then
				return true
			end
		end
	end
	return false
end

function petFunc.getPetPieceIndex( PetPiece )
	if petPieces then
		for i,v in ipairs(petPieces) do
			if v.PetId == PetPiece.PetId then
				return i
			end
		end
	end	
	return -1
end

function petFunc.getPetPieceByIndex( Index )
	if petPieces then
		return petPieces[Index]
	end
end

function petFunc.updatePetPieces( Pieces )
	
	if Pieces then
		for k,v in pairs(Pieces) do
			local tmp = nil
			for k1,v1 in pairs(petPieces) do
				if v.PetId == v1.PetId then
					tmp = v1
					break
				end
			end

			if tmp then
				tmp.Amount = v.Amount
			else
				table.insert(petPieces,v)
			end

		end		

		local gameFunc = require 'AppData'
		for k,v in pairs(petPieces) do
			local dbPet = dbManager.getCharactor(v.PetId)
			local mixc = dbManager.getMixConfig(dbPet.star_level,dbPet.quality)
			if v.Amount >= mixc.Compose then
				local BroadCastInfo = require 'BroadCastInfo'
				BroadCastInfo.set('pet_piece',true)
				break
			end
		end


	end
	eventCenter.eventInput('petPiecesModify')
end

function petFunc.updatePetPiece( Piece )
	
	if Piece then
		for k,v in pairs(petPieces) do
			if v.PetId == Piece.PetId then
				v.Amount = Piece.Amount
				if v.Amount == 0 then
					table.remove(petPieces,k)
				end
				break
			end
		end
	end

end

function petFunc.sortPetPieces( ... )

	if petPieces and #petPieces > 1 then
		table.sort(petPieces,function ( v1,v2 )
			local p1 = dbManager.getCharactor(v1.PetId)
			local p2 = dbManager.getCharactor(v2.PetId)
			local mixc1 = dbManager.getMixConfig(p1.star_level,p1.quality)
			local mixc2 = dbManager.getMixConfig(p2.star_level,p2.quality)
			local eq1 = v1.Amount >= mixc1.Compose
			local eq2 = v2.Amount >= mixc2.Compose
			
			if eq1 and not eq2 then
				return true
			elseif (eq1 == eq2) and (p1.quality > p2.quality) then
				return true
			end

			return false

		end)
	end

end

function petFunc.convertToBattlePetList( nPetList )
	local list = {}
	if nPetList then
		for i,v in ipairs(nPetList) do
			table.insert(list, petFunc.convertToDungeonData(v))
		end
	end
	return list
end

 function petFunc.convertToDungeonData( nPet, isFriend, isGuildMember )
 	local temp = {}
 	temp.heroid = nPet.Id
 	temp.charactorId = nPet.PetId
 	temp.awaken = nPet.AwakeIndex
 	temp.intimacy = nPet.Intimacy
	temp.hp = nPet.Hp
	temp.atk = nPet.Atk
	temp.def = nPet.Def
	temp.cri = nPet.Crit
	temp.spd = nPet.MoveSpeed
 	temp.atktime = nPet.AtkTime
 	temp.AwakeIndex = nPet.AwakeIndex
 	temp.Prop = nPet.Prop
 
 	temp.PetId = nPet.PetId
 	temp.ID = nPet.Id
 	temp.Lv = nPet.Lv
	if nPet.HpMax == 0 then
		temp.HpMax = nPet.Hp
 	else
		temp.HpMax = nPet.HpMax
 	end
 	temp.isFriend = isFriend or false
 	temp.isGuildMember = isGuildMember or false

	temp.sv = nPet.Sv
	temp.fv = nPet.Fv
	temp.cv = nPet.Cv
	temp.bd = nPet.Bd
 	temp.hpR = nPet.HpR
 	if nPet.Gb then
 		temp.gb = table.clone(nPet.Gb)
 	else
 		temp.gb = nil
 	end

 	if nPet.Eb then
 		temp.eb = table.clone(nPet.Eb)
 		temp.sv = nPet.Sv + (nPet.Eb['2'] or 0) 
		temp.fv = nPet.Fv + (nPet.Eb['5'] or 0)
		temp.cv = nPet.Cv + (nPet.Eb['8'] or 0)
		temp.bd = nPet.Bd + (nPet.Eb['7'] or 0)
 	else
 		temp.eb = nil
 	end

	temp.energy = nPet.energy or 0
	temp.aiType = nPet.aiType
	temp.MKs = nPet.MKs
	temp.Sk = nPet.Sk

	return temp
 end

function petFunc.convertToDungeonDataEncode( nPet, isFriend, isGuildMember )
	if isGuildMember then
		petFunc.convertToC(nPet)
	end

	local temp = {}
	temp.heroid = nPet.Id
	temp.charactorId = nPet.PetId
	temp.awaken = nPet.AwakeIndex
	temp.intimacy = nPet.Intimacy
	temp.hp = nPet._Hp
	temp.atk = nPet._Atk
	temp.def = nPet._Def
	temp.cri = nPet._Crit
	temp.spd = nPet._MoveSpeed
	temp.atktime = nPet.AtkTime
	temp.AwakeIndex = nPet.AwakeIndex
	temp.Prop = nPet.Prop

	temp.PetId = nPet.PetId
	temp.ID = nPet.Id
	temp.Lv = nPet.Lv
	if nPet._HpMax == 0 then
		temp.HpMax = nPet._Hp
	else
		temp.HpMax = nPet._HpMax
	end
	temp.isFriend = isFriend or false
	temp.isGuildMember = isGuildMember or false

	temp.sv = nPet._Sv
	temp.fv = nPet._Fv
	temp.cv = nPet._Cv
	temp.bd = nPet._Bd
	temp.hpR = nPet.HpR
	if nPet.Gb then
		temp.gb = table.clone(nPet.Gb)
	else
		temp.gb = nil
	end

	if nPet.Eb then
 		temp.eb = table.clone(nPet.Eb)
 	else
 		temp.eb = nil
 	end

	temp.energy = nPet.energy or 0
	temp.aiType = nPet.aiType
	temp.s2cFlag = true
	temp.MKs = nPet.MKs
	temp.Sk = nPet.Sk
	return temp
end

function petFunc.getPetAmount(PetId,idle)

	local partner = require 'AppData'.getPartnerInfo()
	local teaminfo = require 'AppData'.getTeamInfo()
	local exploreinfo = require 'AppData'.getExploreInfo()
	local traininfo = require 'AppData'.getTrainInfo()
	local list = {}
	local amount = 0 
	for k,v in pairs(petData) do
		if v.PetId == PetId and (not idle or (not exploreinfo.petInExploration(v.Id) and not traininfo.isPetInTrain(v.Id) and not teaminfo.isInTeam(v.Id) and not partner.isInPartner(v.Id))) then
			amount = amount + 1
			table.insert(list,v)
		end
	end
	return amount,list
	
end

function petFunc.inTeamOrPartner(PetId)
	local partner = require 'AppData'.getPartnerInfo()
	local teaminfo = require 'AppData'.getTeamInfo()
	return teaminfo.isInTeam(PetId) or partner.isInPartner(PetId)
end

function petFunc.getPetPieceAmount( PetId )
	
	if petPieces then
		for k,v in pairs(petPieces) do
			if v.PetId == PetId then
				return v.Amount
			end
		end
	end

	return 0
end

function petFunc.doTeamPetUpdate( nPetId )
	local team = require "TeamInfo".getTeamActive()
	if team.BenchPetId == 0 or (not (team.PetIdList and #team.PetIdList == 5)) then

		local checkList = {}	
		if team.PetIdList and #team.PetIdList > 0 then
			for k,v in pairs(team.PetIdList) do
				table.insert(checkList, v)
			end
		end
		if team.BenchPetId > 0 then
			table.insert(checkList, team.BenchPetId)
		end
		local partnerList = require "PartnerInfo".getPartnerListWithTeamIndex(team.TeamId)
		if partnerList then
			for k,v in pairs(partnerList) do
				if v.PetId > 0 then
					table.insert(checkList, v.PetId)
				end
			end
		end

		local nPet = petFunc.getPetWithId(nPetId)
		local dbPet = dbManager.getCharactor(nPet.PetId)
		if not table.find(checkList, nPetId) then
			if not petFunc.isPetClash( dbPet, checkList ) then
				require "TempInfo".setValueForKey("TeamPoint", true)
				require "EventCenter".eventInput("UpdatePoint")
			end
		end
	end
end

function petFunc.getPetArchivedCount( petId )
	print(petArchivedDict)
	local count = 0
	if not petArchivedDict or not next(petArchivedDict) then
		return 0
	end

	return petArchivedDict[tostring(petId)] or 0
end

function petFunc.petInStorage(ID)
	if not petArchived or not next(petArchived) then
		return false
	end

	for i,v in ipairs(petArchived) do
		if v.Id == ID then
			return true
		end
	end
	return false
end

function petFunc.removePetById0( pets,Id )
	if pets and #pets > 0 then
		for k,v in pairs(pets) do
			if v.Id == Id then
				table.remove(pets,k)
				require "GemInfo".getOffGem(Id)
				break
			end
		end
	end
end

function petFunc.addPet0( pets,pet )
	if pets then
		petFunc.removePetById0(pets,pet.Id)
		table.insert(pets,pet)
	end
end

function petFunc.updatePetArchived( pets )
	if pets and #pets > 0 then
		for k,v in pairs(pets) do
			if v.Archived then
				petFunc.removePetById0(petData,v.Id)
				petFunc.addPet0(petArchived,v)
				petFunc.sortPetList(petArchived)		

				if petArchivedDict then
					petArchivedDict[tostring(v.PetId)] = petArchivedDict[tostring(v.PetId)] and (petArchivedDict[tostring(v.PetId)] + 1) or 1
				end
				
			else
				petFunc.setPet(v,petData)
				petFunc.removePetById0(petArchived,v.Id)

				if petArchivedDict then
					petArchivedDict[tostring(v.PetId)] = petArchivedDict[tostring(v.PetId)] and (petArchivedDict[tostring(v.PetId)] - 1) or 0
				end
				
			end

			
		end

		petFunc.modify()
	end
end

function petFunc.getPetWithPetIdArchived( PetId )
	if petArchived and #petArchived > 0 then
		for k,v in pairs(petArchived) do
			if v.PetId == PetId then
				return v
			end
		end
	end
end

function petFunc.getPetWithPetId(PetId, returnAll)
	if not returnAll then
		for k, v in pairs(petData) do
			if v.PetId == PetId then
				return v
			end
		end
		if petArchived ~= nil and next(petArchived) ~= nil then
			for k, v in ipairs(petArchived) do
				if v.PetId == PetId then
					return v
				end
			end
		end
	else
		local all = {}
		for k, v in pairs(petData) do
			if v.PetId == PetId then
				table.insert(all, v)
			end
		end
		if petArchived ~= nil and next(petArchived) ~= nil then
			for k, v in ipairs(petArchived) do
				if v.PetId == PetId then
					table.insert(all, v)
				end
			end
		end

		return all
	end
end

function petFunc.getPetWithSkinId(PetId, returnAll)
	local dbpet = dbManager.getCharactor(PetId)
	local skin_id = dbpet and dbpet.skin_id or 0

	local isPetSameSkin = function ( PetId )
		local dbpet1 = dbManager.getCharactor(PetId)
		if dbpet1 and (dbpet1.skin_id == skin_id) and (dbpet1.evove_level >= dbpet.evove_level) then
			for k,v in pairs(dbpet.evove_branch) do
	            if table.find(dbpet1.evove_branch,v) then
	               return true
	            end
	        end
		end
		return false
	end

	if not returnAll then
		for k, v in pairs(petData) do
			if isPetSameSkin(v.PetId) then
				return v
			end
		end
		if petArchived ~= nil and next(petArchived) ~= nil then
			for k, v in ipairs(petArchived) do
				if isPetSameSkin(v.PetId) then
					return v
				end
			end
		end
	else
		local all = {}
		for k, v in pairs(petData) do
			if isPetSameSkin(v.PetId) then
				table.insert(all, v)
			end
		end
		if petArchived ~= nil and next(petArchived) ~= nil then
			for k, v in ipairs(petArchived) do
				if isPetSameSkin(v.PetId) then
					table.insert(all, v)
				end
			end
		end

		return all
	end
end


function petFunc.getAllPets()
	local total = {}
	for k, v in pairs(petData) do
		table.insert(total, v)
	end

	-- if petArchived ~= nil and next(petArchived) ~= nil then
	-- 	for k, v in ipairs(petArchived) do
	-- 		table.insert(total, v)
	-- 	end
	-- end
	return total
end


function petFunc.getPetListByDBID(id)
	local total = {}
	for k, v in pairs(petData) do
		if v.PetId == id then
			table.insert(total, v)
		end
	end
	return total
end

function petFunc.getPetListByDBIDEX(id, exceptIds)
	local total = {}
	--skin_id = 形象编号
--evove_level = 进化阶段
	local DBpet = dbManager.getCharactor(id)
	for k, v in pairs(petData) do
		--if v.PetId == id then
		local dv = dbManager.getCharactor(v.PetId)
		if (dv.skin_id == DBpet.skin_id and dv.evove_level > DBpet.evove_level) or DBpet.id == dv.id then
			local find = false
			for k1, v1 in pairs(exceptIds) do
				if v.Id == v1 then
					find = true
					break
				end
			end
			if not find then
				table.insert(total, v)
			end
		end
	end
	return total
end

function petFunc.isPetInitStatus( nPet )
	return nPet.AwakeIndex == 0 and nPet.Lv == 1 and nPet.Exp == 0 and nPet.Potential == 1
end

function petFunc.getPetInfoWithTeamPets( team, petList )
	local function getPetListInter( petId )
		for i,v in ipairs(petList) do
			if v.Id == petId then
				return v
			end
		end
	end

	local result = {}
	for i,v in ipairs(team.PetIdList) do
		if v > 0 then
			table.insert(result, getPetListInter(v))
		end
	end
	if team.BenchPetId > 0 then
		table.insert(result, getPetListInter(team.BenchPetId))
	end
	return result
end

function petFunc.getPetUpgradeEnable( nPet )
	local AppData 	= require 'AppData'
	local lvconfig 	= (require 'PetLvConfig')
	local maxpetlv 	= lvconfig[#lvconfig].Lv
	local enable 	= nPet.Lv < maxpetlv
	enable = enable and require 'UnlockManager':isUnlock('lvup')
	if enable then
		local grade = nPet.Grade
  		grade = ((grade == nil or grade == 0) and 1) or grade
  		local gradecfg = dbManager.getPetGradeConfig(grade)
		if nPet.NeedBadge then
	  		local cnt = AppData.getBagInfo().getItemCount(gradecfg.BadgeId)
	  		local gold = AppData.getUserInfo().getGold()
	  		enable = cnt >= gradecfg.BadgeAmt and gold >= gradecfg.Gold
	  		enable = enable and (gradecfg.RoleLv <= AppData.getUserInfo().getLevel())
		else
			enable = petFunc.isFruitsEnablefor(nPet,grade)
		end
	end
	
	return enable
end

function petFunc.isFruitsEnablefor( nPet,grade )
	
	local dbPet = dbManager.getCharactor(nPet.PetId)
	local costs = dbManager.getPetLvupCosts(dbPet.prop_1,grade) or {}

	local getcntdes = function ( v )
      local cnt = require 'AppData'.getBagInfo().getItemCount(v.Mid)
      local Fruits = nPet.Fruits
      
      local alreadycost = 0
      if Fruits then
        alreadycost = Fruits[tostring(v.Mid)] or 0
      end

      local Amt = (maxlv and 0) or (v.Amt - alreadycost)
      return cnt,Amt
    end

    for k,v in pairs(costs) do
    	local cnt,Amt = getcntdes(v)
    	if cnt > 0 and Amt > 0 then
    		return true
    	end
    end

    return false
end

function petFunc.getPropID(property)
    local propID
    if property == 8 then
        propID = 43
    elseif property == 6 then
        propID = 44
    elseif property == 2 then
        propID = 45
    elseif property == 7 then
        propID = 46
    elseif property == 3 then
        propID = 47
    end

    return propID
end

function petFunc.satisfyAllEvolveCondition(pet)
	local charactor = dbManager.getCharactor(pet.PetId)
	if not charactor.ev_pet or not next(charactor.ev_pet) then return false end
	for k, v in pairs(charactor.ev_pet) do
        local resuletCharactor = dbManager.getCharactor(v)
        if petFunc.satisfySpecialCondition(v) then

        	-- material
        	local propID = petFunc.getPropID(resuletCharactor.prop_1)
	        local prop = require 'AppData'.getBagInfo().getItemWithItemId(propID)
	        local DBProp = dbManager.getInfoMaterial(propID)
	        local amount = 0
	        if prop and prop.Amount then 
	            amount = prop.Amount
	        end
	        -- enough material and level
	        if (prop and prop.Amount >= resuletCharactor.ev_num) and pet.Lv >= resuletCharactor.ev_lv then
	            return true
	        end
        end
    end

	return false
end

function petFunc.satisfySpecialCondition(petID)
	local AppData = require 'AppData'
    local charactor = dbManager.getCharactor(petID)
    if not charactor.ev_condition then
        return true
    end

    local conditions = {}
    for word in string.gmatch(charactor.ev_condition, '([^|]+)') do
        table.insert(conditions, word)
    end

    if conditions[1] == '1' then --在时间段内
    	local TimeManager = require "TimeManager"
        local curTimer = TimeManager.getCurrentSeverTime() / 1000-- / 3600
        local ldt = os.date('*t',curTimer)
        local hours = {}
        for hour in string.gmatch(conditions[2], '([^,]+)') do
            table.insert(hours, hour)
        end
        if require 'Toolkit'.isTimeBetween(tonumber(hours[1]), 0, tonumber(hours[2]), 0) then
            return true
        else
            return false
        end
    elseif conditions[1] == '2' then --拥有过某只精灵
        return AppData.getPetInfo().petCollected(tonumber(conditions[2]))
    elseif conditions[1] == '3' then --当前拥有金币XX
        if AppData.getUserInfo().getGold() < tonumber(conditions[2]) then
            return false
        else
            return true
        end
    elseif conditions[1] == '4' then --通过某个城镇 负的ID表示未通关
        local townID = tonumber(conditions[2])
        local negtive = false
        if townID < 0 then
            negtive = true
            townID = -townID
        end

        local town = AppData.getTownInfo().getTownById(townID)
        if not town then
            if negtive then
                return true
            else 
                return false
            end
        end

        if (not negtive and town.Clear) or (negtive and not town.Clear) then
            return true
        else
            return false
        end
    elseif conditions[1] == '5' then --当前激活队伍的队长是XX
        local team = AppData.getTeamInfo().getTeamActive() --teamFunc.getTeamActive()
        local CaptainPet = AppData.getPetInfo().getPetWithId(team.CaptainPetId)
        local charactor1 = dbManager.getCharactor(CaptainPet.PetId)
        local charactor2 = dbManager.getCharactor(tonumber(conditions[2]))
        if charactor1.skin_id == charactor2.skin_id then
            return true
        else
            return false
        end
    end
end


function petFunc.getPetIdsForExchage( PetId,Amount )
	local amount,list = petFunc.getPetAmount(PetId,true)
	local pids = {}
	if list then
		petFunc.sortPetList(list)
		local index = #list - Amount + 1 
		index = index < 1 and 1 or index
		for i=index,#list do
			table.insert(pids,list[i].Id)
		end
	end
	return amount,pids
end

function petFunc.removePetPiecesByPetId( PetId,Amount )

	if petPieces then
		for k,v in pairs(petPieces) do
			if v.PetId == PetId then
				v.Amount = v.Amount - Amount
				if v.Amount <= 0 then
					table.remove(petPieces,k)
				end
				break
			end
		end
	end

end

function petFunc.syncPetPieces( self,callback ,force)
	if not petPiecesSynced or force then
		self:send(require 'netModel'.getModelPetGetPieces(),function ( data )
		    petFunc.setPetPieces(data.D.Pieces)
		    return callback and callback(petPieces)
		end)  
	else
		return callback and callback(petPieces)
	end
end

function petFunc.updatePetsAddition( nPetList, prop, rate, noPropRate )
	if nPetList then
		for i,v in ipairs(nPetList) do
			petFunc.updatePetAddition( v, prop, rate, noPropRate )
		end
	end
end

function petFunc.reSetPetsAddition( nPetList, prop, rate, noPropRate )
	if nPetList then
		for i,v in ipairs(nPetList) do
			petFunc.resetPetAddition( v, prop, rate, noPropRate )
		end
	end
end

function petFunc.updatePetsAdditionWithBox( nPetList, boxCount )
	if nPetList and boxCount > 0 then
		local atkAddition = dbManager.getInfoDefaultConfig("GBBUFFATK").Value
		local hpAddition = dbManager.getInfoDefaultConfig("GBBUFFHP").Value
		for i,v in ipairs(nPetList) do
			petFunc.updatePetAdditionWithBox( v, atkAddition * boxCount, hpAddition * boxCount )
		end
	end
end

function petFunc.resetPetsAdditionWithBox( nPetList )
	if nPetList then
		for i,v in ipairs(nPetList) do
			petFunc.resetPetAdditionWithBox( v )
		end
	end
end

function petFunc.updatePetAdditionWithBox( nPet, atkAdd, hpAdd )
	nPet._AtkAddRate = nPet.Atk / (nPet.Atk + atkAdd)
	nPet._HpAddRate = nPet.Hp / (nPet.Hp + hpAdd)

	nPet.Atk = nPet.Atk + atkAdd
	if nPet.HpMax == 0 then
		nPet.HpMax = nPet.Hp + hpAdd
	else
		nPet.HpMax = nPet.HpMax + hpAdd
	end
	nPet.Hp = nPet.Hp + hpAdd
end

function petFunc.resetPetAdditionWithBox( nPet )
	if nPet.Atk and nPet._AtkAddRate then
		nPet.Atk = nPet.Atk * nPet._AtkAddRate
	end
	if nPet.Hp and nPet._HpAddRate then
		nPet.Hp = nPet.Hp * nPet._HpAddRate
	end
	if nPet.HpMax and nPet._HpAddRate then
		nPet.HpMax = nPet.HpMax * nPet._HpAddRate
	end
	if nPet.hpD and nPet._HpAddRate then
		nPet.hpD = nPet.hpD * nPet._HpAddRate
	end
	nPet._AtkAddRate = nil
	nPet._HpAddRate = nil
end

function petFunc.getPetAdditionRate( nPet, prop, rate, noPropRate )
	if nPet and nPet.charactorId and nPet.Prop == nil then
		local c = dbManager.getCharactor(nPet.charactorId)
		nPet.Prop = c and c.prop_1
	end
	local resultRate
	if prop == nPet.Prop then
		resultRate = 1 + (rate + noPropRate) / 100
	else
		resultRate = 1 + noPropRate / 100
	end
	return resultRate
end

function petFunc.updatePetAddition( nPet, prop, rate, noPropRate )
	prop = prop or 0
	rate = rate or 0
	noPropRate = noPropRate or 0
	local resultRate = petFunc.getPetAdditionRate( nPet, prop, rate, noPropRate )
	nPet.Atk = nPet.Atk * resultRate
	if nPet.HpMax == 0 then
		nPet.HpMax = nPet.Hp * resultRate 
	else
		nPet.HpMax = nPet.HpMax * resultRate
	end
	nPet.Hp = nPet.Hp * resultRate
end

function petFunc.resetPetAddition( nPet, prop, rate, noPropRate )
	prop = prop or 0
	rate = rate or 0
	noPropRate = noPropRate or 0
	local resultRate = petFunc.getPetAdditionRate( nPet, prop, rate, noPropRate )
	if nPet.Atk then
		nPet.Atk = nPet.Atk / resultRate
	end
	if nPet.Hp then
		nPet.Hp = nPet.Hp / resultRate
	end
	if nPet.HpMax then
		nPet.HpMax = nPet.HpMax / resultRate 
	end
	if nPet.hpD then
		nPet.hpD = nPet.hpD / resultRate
	end
end

eventCenter.resetGroup('PetInfo')
eventCenter.addEventFunc('PetRefresh',function ( data )
	-- print('精灵列表刷新:')
	-- print(data)
	petFunc.addPets(data.D.Pets)
--	eventCenter.eventInput('UpdateBattleValue')
end,'PetInfo')


return petFunc