local dbManager = require "DBManager"
local res = require "Res"
local gameFunc = require "AppData"
local netModel = require "netModel"
local userFunc = gameFunc.getUserInfo()

local function updateLayer( self, view, Pray )
	print("updateLayer_Pray")
	print(Pray)
	if not Pray then
		return
	end
	local todayWished = not Pray.CanPray
	local wishCount = Pray.Cnt
	local wishRewardInfo = dbManager.getWishReward( Pray.Cid )

	local wishCountAll = wishRewardInfo.days

	local dbRewardList = {}
	if wishRewardInfo.ws_reward then
		for i,v in ipairs(wishRewardInfo.ws_reward) do
			table.insertTo(dbRewardList, dbManager.getReward(v))
		end
	end

	view["bg1_countLayout"]:removeAllChildrenWithCleanup(true)
	view["bg1_pointBase"]:removeAllChildrenWithCleanup(true)
	local lineLst = {}
	for i=1,wishCountAll - 1 do
		local line = view.createLuaSet("@line")
		view["bg1_countLayout"]:addChild(line[1])
		line[1]:setContentSize(CCSize(600 / (wishCountAll - 1), line[1]:getHeight()))
		line[1]:setResid(i <= wishCount - 1 and "N_GK_88.png" or "N_GK_96.png")
		table.insert(lineLst, line)
	end
	view["bg1_countLayout"]:layout()

	local ptPos
	for i,line in ipairs(lineLst) do
		local point = view.createLuaSet("@point")
		view["bg1_pointBase"]:addChild(point[1])
		point[1]:setResid(i <= wishCount - 1 and "N_GK_85.png" or "N_GK_95.png")
		local pt = NodeHelper:getPositionInScreen(line[1])
		NodeHelper:setPositionInScreen(point[1], NodeHelper:getPositionInScreen(line[1]))
		point["sel"]:setVisible(i == wishCount - 1)
		point["day"]:setResid(string.format("N_HD_XY_LX%d.png", i + 1))
		point["day"]:setOpacity(i <= wishCount - 1 and 255 or 128)

		if i == 1 then
			ptPos = NodeHelper:getPositionInScreen(line[1])
			ptPos.x = ptPos.x - line[1]:getWidth()
		end
	end

	local point = view.createLuaSet("@point")
	view["bg1_pointBase"]:addChild(point[1])
	point[1]:setResid(wishCount >= 1 and "N_GK_85.png" or "N_GK_95.png")
	NodeHelper:setPositionInScreen(point[1], ptPos)
	point["sel"]:setVisible(wishCount == 1)
	point["day"]:setResid(string.format("N_HD_XY_LX%d.png", 1))
	point["day"]:setOpacity(wishCount >= 1 and 255 or 128)

	view["bg1_layoutTitle_pre"]:setString(string.format(res.locString("Activity$WishListTitlePre"), wishCountAll))
	require 'LangAdapter'.LabelNodeAutoShrink(view['bg1_layoutTitle_pre'],210)
	require 'LangAdapter'.fontSize(view['bg1_layoutTitle_pre'],nil,nil,nil,nil,18)
	require 'LangAdapter'.fontSize(view['bg1_layoutTitle_title'],nil,nil,nil,nil,16)
	require 'LangAdapter'.selectLangkv({German=function ( ... )
		view['bg1_#layoutTitle']:setOrientation(Vertical)
	end})
	view["bg1_rewardLayout"]:removeAllChildrenWithCleanup(true)
	if dbRewardList then
		for i,dbReward in ipairs(dbRewardList) do
			local item = view.createLuaSet("@item")
			require 'LangAdapter'.LabelNodeAutoShrink(item['name'],72)
			view["bg1_rewardLayout"]:addChild(item[1])
			require 'LangAdapter'.LabelNodeAutoShrink(item['name'],75)
			if dbReward.itemtype == 6 then -- 精灵
				res.setNodeWithPet(item["icon"], gameFunc.getPetInfo().getPetInfoByPetId( dbReward.itemid ), dbReward.amount)
				local dbPet = dbManager.getCharactor(dbReward.itemid)
				item["name"]:setString(dbPet.name)
			elseif dbReward.itemtype == 7 then -- 装备
				local dbEquip = dbManager.getInfoEquipment(dbReward.itemid)
				res.setNodeWithEquip(item["icon"], dbEquip, dbReward.amount)
				item["name"]:setString(dbEquip.name)
			elseif dbReward.itemtype == 8 then -- 宝石
				local dbGem = dbManager.getInfoGem(dbReward.itemid)
				res.setNodeWithGem(item["icon"], dbGem.gemid, dbReward.args[1], dbReward.amount)
				item["name"]:setString(dbGem.name .. " Lv." .. dbReward.args[1])
			elseif dbReward.itemtype == 9 then -- 道具
				local dbMaterial = dbManager.getInfoMaterial(dbReward.itemid)
				res.setNodeWithMaterial(item["icon"], dbMaterial, dbReward.amount)
				item["name"]:setString(dbMaterial.name)
			elseif dbReward.itemtype == 1 then -- 金币
				res.setNodeWithGold(item["icon"], dbReward.amount)
				item["name"]:setString(res.locString("Global$Gold"))
			elseif dbReward.itemtype == 2 then -- 精灵石
				res.setNodeWithCoin(item["icon"], dbReward.amount)
				item["name"]:setString(res.locString("Global$Coin"))
			elseif dbReward.itemtype == 10 then -- 精灵碎片
				res.setNodeWithPetPiece(item["icon"], gameFunc.getPetInfo().getPetInfoByPetId( dbReward.itemid ), dbReward.amount)
				local dbPet = dbManager.getCharactor(dbReward.itemid)
				item["name"]:setString(dbPet.name)
			elseif dbReward.itemtype == 3 then -- 精灵之魂
				res.setNodeWithSoul(item["icon"], dbReward.amount)
				item["name"]:setString(res.locString("Global$Soul"))
			end

			require 'LangAdapter'.selectLang(nil, nil, function ( ... )
				item["name"]:setVisible(false)
			end, nil, nil, nil, nil, function ( ... )
				local w = item["name"]:getWidth()
				if w > 74 then
					item["name"]:setScale(74/w)
				else
					item["name"]:setScale(1)
				end
			end)
		end
	end

	local textString
	if todayWished then
		if wishCount == wishCountAll then
			textString = res.locString("Activity$WishBtnWish3")
		else
			textString = res.locString("Activity$WishBtnWish2")
		end
	else
		textString = res.locString("Activity$WishBtnWish1")
	end
	view["bg1_btnOk_text"]:setString(textString)
	view["bg1_btnOk"]:setEnabled( (not todayWished) or (wishCount == wishCountAll))
	view["bg1_btnOk"]:setListener(function ( ... )
		if wishCount == wishCountAll then
			self:send(netModel.getModelPrayFinalReward(), function ( data )
				if data and data.D then
					if data.D.Resource then
						gameFunc.updateResource(data.D.Resource)
					end
					if data.D.Pray then
						updateLayer(self, view, data.D.Pray)
					end
					res.doActionGetReward(data.D.Reward)
				end
			end)
		else
			self:send(netModel.getModelPrayPray(), function ( data )
				if data and data.D then
					if data.D.Resource then
						gameFunc.updateResource(data.D.Resource)
					end
					if data.D.Pray then
						updateLayer(self, view, data.D.Pray)
					end
					res.doActionGetReward(data.D.Reward)
				end
			end)
		end
	end)

	local espt = function ( ... )
		view['bg1_layoutTitle_title']:setString('')
	end
	require 'LangAdapter'.selectLang(nil, nil, function ( ... )
		view["bg1_layoutTitle_pre"]:setFontSize(16)
		view["bg1_layoutTitle_title"]:setFontSize(16)
	end,nil,nil,espt,espt)
end

local update = function ( self, view, data )
	if data and data.D and data.D.Pray then
		updateLayer(self, view, data.D.Pray)
	end
end

local getNetModel = function ( )
	return netModel.getModelPrayGet()
end

return {update = update, getNetModel = getNetModel}