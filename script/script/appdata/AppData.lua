local gameInterface = {}		-- 游戏数据接口
local gameData = {}			-- 游戏数据

gameData.userInfo = require "UserInfo"
gameData.petInfo = require "PetInfo"
gameData.teamInfo = require "TeamInfo"
gameData.partnerInfo = require "PartnerInfo"
gameData.equipInfo = require "EquipInfo"
gameData.gemInfo = require "GemInfo"
gameData.friendsInfo = require "FriendsInfo"
gameData.bagInfo = require "BagInfo"
gameData.itemMallInfo = require "ItemMallInfo"
gameData.trainInfo = require "TrainInfo"
gameData.Acs = require 'ActivityInfo'
gameData.TownInfo = require 'TownInfo'
gameData.BroadCastInfo = require 'BroadCastInfo'
gameData.taskLoginInfo = require "TaskLoginInfo" 
gameData.tempInfo = require "TempInfo" 
gameData.RechargeInfo = require 'RechargeInfo'
gameData.GuildInfo = require 'GuildInfo'
gameData.NapkinInfo = require 'NapkinInfo'
gameData.LoginInfo = require 'LoginInfo'
gameData.ExploreInfo = require 'ExploreInfo'
gameData.RedPaperInfo = require "RedPaperInfo"
gameData.MibaoInfo = require "MibaoInfo"
gameData.Card21Info = require "Card21Info"
gameData.GuildCopyInfo = require "GuildCopyInfo"
gameData.RuneInfo = require "RuneInfo"
gameData.TimeLimitExploreInfo = require "TimeLimitExploreInfo"
gameData.HatchEggInfo = require "HatchEggInfo"
gameData.PerlBookInfo = require "PerlBookInfo"
gameData.SilverCoinInfo = require "SilverCoinInfo"
gameData.BlacklistInfo = require "BlacklistInfo"

gameData.initAnnounce = {}
gameData.sysNotifyList = {}

function gameInterface.cleanLocalData()
	gameData.userInfo.cleanData()
	gameData.petInfo.cleanData()
	gameData.teamInfo.cleanData()
	gameData.partnerInfo.cleanData()
	gameData.equipInfo.cleanData()
	gameData.gemInfo.cleanData()
	gameData.friendsInfo.cleanData()
	gameData.bagInfo.cleanData()
	gameData.itemMallInfo.cleanData()
	gameData.trainInfo.cleanData()
	gameData.Acs.cleanData()
	gameData.TownInfo.cleanData()
	gameData.BroadCastInfo.cleanData()
	gameData.taskLoginInfo.cleanData()
	gameData.tempInfo.cleanData()
	gameData.RechargeInfo.cleanData()
	gameData.GuildInfo.cleanData()
	gameData.NapkinInfo.cleanData()
	gameData.ExploreInfo.cleanData()
	gameData.LoginInfo.cleanData()
	gameData.RedPaperInfo.cleanData()
	gameData.MibaoInfo.cleanData()
	gameData.Card21Info.cleanData()
	gameData.GuildCopyInfo.cleanData()
	gameData.RuneInfo.cleanData()
	gameData.TimeLimitExploreInfo.cleanData()
	gameData.HatchEggInfo.cleanData()
	gameData.PerlBookInfo.cleanData()
	gameData.SilverCoinInfo.cleanData()
	gameData.BlacklistInfo.cleanData()
end

-- 用户信息模块
function gameInterface.getInitAnnoucne()
	return gameData.initAnnounce
end

function gameInterface.setInitAnnoucne(announce)
	gameData.initAnnounce = announce
end

-- 系统通知列表
function gameInterface.getSysNotifyList()
	return gameData.sysNotifyList
end

function gameInterface.setSysNotifyList(list)
	gameData.sysNotifyList = list
end

-- 用户信息模块
function gameInterface.getUserInfo(  )
	return gameData.userInfo
end

-- 精灵模块
function gameInterface.getPetInfo(  )
	return gameData.petInfo
end

-- 队伍模块
function gameInterface.getTeamInfo(  )
	return gameData.teamInfo
end

-- 小伙伴模块
function gameInterface.getPartnerInfo( )
	return gameData.partnerInfo
end

-- 装备模块
function gameInterface.getEquipInfo(  )
	return gameData.equipInfo
end

-- 宝石模块
function gameInterface.getGemInfo(  )
	return gameData.gemInfo
end

-- 好友模块
function gameInterface.getFriendsInfo(  )
	return gameData.friendsInfo
end

-- 背包模块
function gameInterface.getBagInfo(  )
	return gameData.bagInfo
end

-- 道具商城模块
function gameInterface.getItemMallInfo(  )
	return gameData.itemMallInfo
end

-- 训练模块
function gameInterface.getTrainInfo(  )
	return gameData.trainInfo
end

-- 探宝模块
function gameInterface.getExploreInfo(  )
	return gameData.ExploreInfo
end

-- 红包模块
function gameInterface.getRedPaperInfo( ... )
	return gameData.RedPaperInfo
end

-- 秘宝模块
function gameInterface.getMibaoInfo( ... )
	return gameData.MibaoInfo
end

-- 更新Resource
function gameInterface.updateResource( res )
	if res then
		if res.Role then
			gameData.userInfo.setData(res.Role)
		end
		if res.Pets then
			gameData.petInfo.addPets(res.Pets)
		end
		if res.Equipments then
			gameData.equipInfo.addEquipments(res.Equipments)
		end
		if res.Gems then
			gameData.gemInfo.addGemList(res.Gems)
		end
		if res.Materials then
			gameData.bagInfo.exchangeItem(res.Materials)
		end
		if res.PetPieces then
			gameData.petInfo.updatePetPieces(res.PetPieces)
		end
		if res.Packs then
			gameData.bagInfo.updatePackList(res.Packs)
		end
		if res.Egg then
			gameData.bagInfo.setEgg(res.Egg)
		end
		if res.Mibaos then
			gameData.MibaoInfo.updateMibaoList(res.Mibaos)
		end
		if res.MibaoPieces then
			gameData.MibaoInfo.updateMibaoPieceList(res.MibaoPieces)
		end
		if res.Runes then
			gameData.RuneInfo.updateRuneList(res.Runes)
		end
		if res.Books then
			gameData.PerlBookInfo.updateBooks(res.Books)
		end
		if res.BookPieces then
			gameData.PerlBookInfo.updateBookPieces(res.BookPieces)
		end
		if res.Perls then
			gameData.PerlBookInfo.updatePerls(res.Perls)
		end
	end
end

-- 羁绊
function gameInterface.fetterIsActive( fetter, fetterPetIdList )
	local function canFindFetter( fetterPetIdList, dbPetId )
		local dbManager = require "DBManager"
		local dbPet = dbManager.getCharactor(dbPetId)
		if dbPet then
			for i,v in ipairs(fetterPetIdList) do
				local dbPet2 = dbManager.getCharactor(v)
				if dbPet2.id == dbPet.id or (require "PetInfo".isPetInSameBranch(dbPet2, dbPet) and dbPet2.evove_level > dbPet.evove_level) then
					return true
				end
			end
		end
		return false
	end

	if fetter.Type == 1 and fetterPetIdList ~= nil then
		local dbFetterPetList = fetter.Keys
		if fetter.Keys and #fetter.Keys > 1 then
			for k,v in pairs(fetter.Keys) do
				if not canFindFetter(fetterPetIdList, v) then
					return false
				end
			end
			return true
		end
	end
	return false
end

function gameInterface.getRewardStringList( reward )
	local dbManager = require "DBManager"
	local res = require "Res"
	local list = {}
	if reward.Gold and reward.Gold>0 then
		table.insert(list,res.locString("Global$Gold").."x"..reward.Gold)
	end
	if reward.Coin and reward.Coin>0 then
		table.insert(list,res.locString("Global$SpriteStone").."x"..reward.Coin)
	end
	if reward.Soul and reward.Soul > 0 then
		table.insert(list,res.locString("Global$Soul").."x"..reward.Soul)
	end
	if reward.Ap and reward.Ap>0 then
		table.insert(list,res.locString("Global$AP").."x"..reward.Ap)
	end
	if reward.Exp and reward.Exp>0 then
		table.insert(list,res.locString("Global$Exp").."x"..reward.Exp)
	end
	if reward.Pets and #reward.Pets>0 then
		table.foreach(reward.Pets,function ( _,v )
			if v.Amount>0 then
				table.insert(list,dbManager.getCharactor(v.PetId).name.."x"..v.Amount)
			end
		end)
	end
	if reward.Equipments and #reward.Equipments>0 then
		table.foreach(reward.Equipments,function ( _,v )
			if v.Amount>0 then
				table.insert(list,dbManager.getInfoEquipment(v.EquipmentId).name.."x"..v.Amount)
			end
		end)
	end
	if reward.Gems and #reward.Gems>0 then
		table.foreach(reward.Gems,function ( _,v )
			if v.Amount>0 then
				table.insert(list,dbManager.getInfoGem(v.GemId).name.."Lv"..v.Lv.."x"..v.Amount)
			end
		end)
	end

	if reward.Materials and #reward.Materials>0 then
		table.foreach(reward.Materials,function ( _,v )
			if v.Amount>0 then
				table.insert(list, dbManager.getInfoMaterial(v.MaterialId).name.."x"..v.Amount)
			end
		end)
	end
	if reward.PetPieces and #reward.PetPieces>0 then
		table.foreach(reward.PetPieces,function ( _,v )
			if v.Amount>0 then
				table.insert(list,dbManager.getCharactor(v.PetId).name .. res.locString("Global$Fragment") .."x"..v.Amount)
			end
		end)
	end
	if reward.Packs and #reward.Packs>0 then
		table.foreach(reward.Packs,function ( _,v )
			if v.Amount>0 then
				table.insert(list, v.Name .."x"..v.Amount)
			end
		end)
	end
	if reward.Honor and reward.Honor > 0 then
		table.insert(list,res.locString("Global$ArenaHonor").."x"..reward.Honor)
	end
	return list
end

function gameInterface.getActivityInfo( ... )
	return gameData.Acs
end

function gameInterface.getTownInfo( ... )
	return gameData.TownInfo
end

function gameInterface.getBroadCastInfo( ... )
	return gameData.BroadCastInfo
end

function gameInterface.getTaskLoginInfo( ... )
	return gameData.taskLoginInfo
end

-- 游戏内存中保存的临时信息
function gameInterface.getTempInfo( ... )
	return gameData.tempInfo
end

function gameInterface.getRechargeInfo( ... )
	return gameData.RechargeInfo
end

function gameInterface.getGuildInfo( ... )
	return gameData.GuildInfo
end

function gameInterface.getNapkinInfo( ... )
	return gameData.NapkinInfo
end

function gameInterface.getLoginInfo( ... )
	return gameData.LoginInfo
end

function gameInterface.getCard21Info( ... )
	return gameData.Card21Info
end

function gameInterface.getGuildCopyInfo( ... )
	return gameData.GuildCopyInfo
end

function gameInterface.getRuneInfo( ... )
	return gameData.RuneInfo
end

function gameInterface.getTimeLimitExploreInfo( ... )
	return gameData.TimeLimitExploreInfo
end

function gameInterface.getHatchEggInfo( ... )
	return gameData.HatchEggInfo
end


function gameInterface.getPerlBookInfo( ... )
	return gameData.PerlBookInfo
end

function gameInterface.getSilverCoinInfo( ... )
	return gameData.SilverCoinInfo
end

function gameInterface.getBlacklistInfo( ... )
	return gameData.BlacklistInfo
end

return gameInterface
