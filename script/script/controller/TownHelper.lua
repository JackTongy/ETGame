local netModel = require "netModel"
local dbManager = require 'DBManager'
local Res = require 'Res'
local GuideHelper = require 'GuideHelper'
local gameFunc = require "AppData"
local userFunc = gameFunc.getUserInfo()
local townFunc = gameFunc.getTownInfo()

local helper = {}

function helper.stageReset( self, nStage, callback )
	local vipInfo = dbManager.getVipInfo(userFunc.getVipLevel())
	if vipInfo then
		local resetTimes = nStage.ResetTimes
		if resetTimes < vipInfo.StageReset then
			local param = {}
			local resetCost = dbManager.getResetCost(resetTimes + 1).Cost
			param.title = Res.locString("Global$Reset")
			param.content = string.format(Res.locString("Dungeon$ResetTip"), resetCost)
			param.tip = string.format(Res.locString("Dungeon$ResetTip2"), vipInfo.StageReset - resetTimes)
			param.RightBtnText = Res.locString("Global$Reset")
			param.callback = function ( ... )
				if userFunc.getCoin() < resetCost then
					require "Toolkit".showDialogOnCoinNotEnough()
				else
					self:send(netModel.getModelResetStage(nStage.StageId), function ( data )
						print("ResetStage")
						print(data)
						if data and data.D then
							if data.D.Role then
								userFunc.setData(data.D.Role)
							end
							if callback then
								callback(data)
							end
						end
					end)
				end
			end
			GleeCore:showLayer("DResetNotice", param)
		else
			local param = {}
			param.title = Res.locString("Global$Reset")
			param.content = Res.locString("Dungeon$VipResetTip")
			param.tip = Res.locString("VIP$BetterVip")
			param.RightBtnText = Res.locString("Global$BtnRecharge")
			param.callback = function ( ... )
				GleeCore:showLayer("DRecharge")
			end
			GleeCore:showLayer("DResetNotice", param)		
		end
	end
end

function helper.stageBattleSpeed( self, nStage, callback, useFastTicket )
	local stageId = nStage.StageId
	useFastTicket = useFastTicket or false
	self:send(netModel.getModelStageCombatFast(stageId, useFastTicket), function ( data )
		print("tageCombatFast")
		print(data)
		if data and data.D then
			local oldlv = gameFunc.getUserInfo().getLevel()
			local oldRole = gameFunc.getUserInfo().getData()

			if data.D.BattleResult then
				if data.D.BattleResult.Resource then
					gameFunc.updateResource(data.D.BattleResult.Resource)
				end

				local param = {}
				param.Results = {[1] = data.D.BattleResult} 
				local newlv = gameFunc.getUserInfo().getLevel()
				if newlv > oldlv then
					param.newRole = gameFunc.getUserInfo().getData()
					oldRole.Ap = math.max(oldRole.Ap - nStage.CostAp, 0)
					param.oldRole = oldRole
				end

				param.callback = function ( ... )
					require 'UnlockManager':userLv(oldlv,newlv,'DStageList')
				end
				GleeCore:showLayer("DBattleSpeed", param)
			end

			if callback then
				callback(data)
			end
		end
	end)
end

function helper.stageChallengeSpeed( self, nStage, callback )
	local stageId = nStage.StageId
	self:send(netModel.getModelStageFast(stageId), function ( data )
		print("StageFast")
		print(data)
		if data and data.D then
			local oldlv = gameFunc.getUserInfo().getLevel()
			local oldRole = gameFunc.getUserInfo().getData()

			if data.D.Role then
				local isUpdateAp = data.D.Role.Ap ~= userFunc.getAp()
				if isUpdateAp then
					userFunc.setData(data.D.Role)
					require 'EventCenter'.eventInput("UpdateAp")
				end
			end
			if data.D.Town then
				gameFunc.getTownInfo().updateTowns({[1] = data.D.Town})
			end

			if data.D.Resource then
				gameFunc.updateResource(data.D.Resource)
			end

			if data.D.Results then
				for i,v in ipairs(data.D.Results) do
					if v.LvUpPets then
						petFunc.addPets(v.LvUpPets)
					end
				end
			end
			-- if data.D.Egg then
			-- 	gameFunc.getBagInfo().setEgg({})
			-- end

			local newlv = gameFunc.getUserInfo().getLevel()
			if newlv > oldlv then
				data.D.newRole = data.D.Role
				oldRole.Ap = math.max(oldRole.Ap - nStage.CostAp, 0)
				data.D.oldRole = oldRole
			end
			-- add by te
			data.D.callback = function ( ... )
				require 'UnlockManager':userLv(oldlv,newlv,'DStageList')
			end
			
			GleeCore:showLayer("DBattleSpeed", data.D)
			
			if callback then
				callback(data)
			end
		end
	end)
end

function helper.getStageNetData( nStageId,stagelist )
	local nStage
	if stagelist then
		for k,v in pairs(stagelist) do
			if v.StageId == nStageId then
				nStage = v
				break
			end
		end
	end
	return nStage
end

function helper.isStageReset( nStage )
	return nStage and nStage.TodayTimes == 0 and nStage.CostAp > 0 or false
end

function helper.canBattleSpeed( ... )
	return userFunc.getLevel() >= dbManager.getUnLockLvConfig("BattleSpeed")
end

function helper.updateStageData( nStage,StageList )
	if nStage and StageList then
		for i,v in ipairs(StageList) do
			if v.StageId == nStage.StageId then
				StageList[i] = nStage
				break
			end
		end
	end
end

-- set结构见DMaterialDetail.xml @item
function helper.updateSet( self,set,v,stagelist,speedcallback,resetcallback,useFastTicket)
	local dbstage = dbManager.getInfoStage(v)
	local dbTown = dbManager.getInfoTownConfig(dbstage.TownId)
	local dbarea = dbManager.getArea(dbTown.AreaId)
	local PlayBranchList = townFunc.getPlayBranchList()
	local PlayBranch = PlayBranchList.PlayBranchNormal
	if dbstage.Senior > 0 then
		PlayBranch = PlayBranchList.PlayBranchSenior
	elseif dbstage.Hero > 0 then
		PlayBranch = PlayBranchList.PlayBranchHero
	end

	local isNotNormal = PlayBranch ~= PlayBranchList.PlayBranchNormal
	local unlock = townFunc.isTownOpen(dbstage.TownId, PlayBranch)
	local nTownInfo = townFunc.getTownById(dbstage.TownId)
	local nStage = helper.getStageNetData(v,stagelist)
	local isReset = helper.isStageReset(nStage)
	local isClear = nil

	set['icon']:setResid(string.format('%s.png',dbTown.Town_pic))
	townFunc.PlayBranchEvent(function ( ... )
		isClear = nTownInfo and nTownInfo.Clear or false
		set['name']:setString( dbarea.Name .. "-" .. dbTown.Name)
	end, function ( ... )
		isClear = nTownInfo and nTownInfo.SeniorClear or false
		set['name']:setString( dbarea.Name .. "-" .. dbTown.Name .. Res.locString("TownHelp$Senior") )
	end, function ( ... )
		isClear = nTownInfo and nTownInfo.HeroClear or false
		set['name']:setString( dbarea.Name .. "-" .. dbTown.Name .. Res.locString("TownHelp$Hero") )
	end, PlayBranch)

	if unlock then
		if isClear then
			set['tip']:setString(string.format(Res.locString("TownHelp$ChallengeTimes"), nStage.TodayTimes, dbstage.DailyTimes))
			set['tip']:setFontFillColor(Res.color4F.green,true)
		else
			set['tip']:setString( Res.locString("TownHelp$unClear") )
			set['tip']:setFontFillColor(Res.color4F.red,true)
		end
	else
		set['tip']:setString( Res.locString("TownHelp$Lock") )
		set['tip']:setFontFillColor(Res.color4F.red,true)
	end
	
	set['lock']:setVisible(not unlock)
	local battleSpeedVisible = unlock and ( (not helper.canBattleSpeed()) or (not isReset and (isNotNormal or dbstage.StageType == 1) and isClear) )
	if useFastTicket then
		battleSpeedVisible = battleSpeedVisible and userFunc.getData().FastTicket > 0
	end
	-- if not useFastTicket then
	-- 	battleSpeedVisible = battleSpeedVisible and helper.canBattleSpeed()
	-- end 
	require "LangAdapter".LabelNodeAutoShrink(set["btnBattleSpeed_#text"], 106)
	
	set["btnBattleSpeed"]:setVisible(battleSpeedVisible)
	set["btnBattleSpeed"]:setListener(function ( ... )
		if helper.canBattleSpeed() then
			if isNotNormal then
				if useFastTicket then
					if userFunc.getData().FastTicket <= 0 then
						GleeCore:toast(Res.locString("Dungeon$PetTicketNone"))
					else
						helper.stageBattleSpeed(self, nStage, speedcallback, useFastTicket)
					end
				else
					if userFunc.getAp() < nStage.CostAp then
						Res.doEventAddAP()
					else
						helper.stageBattleSpeed(self, nStage, speedcallback)
					end	
				end
			else
				if userFunc.getAp() < nStage.CostAp then
					Res.doEventAddAP()
				else
					if userFunc.getVipLevel() >= 1 or nTownInfo.Stars >= 3 then
						helper.stageChallengeSpeed(self, nStage, speedcallback)
					else
						GleeCore:toast(Res.locString("Dungeon$BattleSpeedFailTip"))
					end
				end	
			end
		else
			GleeCore:toast(string.format(Res.locString("Dungeon$BattleSpeedUnlock"), dbManager.getUnLockLvConfig("BattleSpeed")))
		end
	end)
	set["btnReset"]:setVisible(isReset and (isNotNormal or dbstage.StageType == 1))
	set["btnReset"]:setListener(function ( ... )
		helper.stageReset(self, nStage, resetcallback)
	end)

	local btnGoto = set['btnGoto']
	btnGoto:setVisible(unlock and (not set["btnReset"]:isVisible()) and (not battleSpeedVisible) )
	if btnGoto and nTownInfo then
		btnGoto:setListener(function ( ... )
			if useFastTicket and userFunc.getData().FastTicket <= 0 then
				GleeCore:toast(Res.locString("Dungeon$PetTicketNone"))
			end
			require 'EventCenter'.eventInput("GoToTown", {PlayBranch = PlayBranch, townId = dbstage.TownId, stageId = dbstage.Id})	
		end)
	end

end

return helper