local HuntHelper = {}
local res = require "Res"
local netModel = require "netModel"
local GuildCopyFunc = require "GuildCopyInfo"
local socketC = require "SocketClient"

local Config = require "Config"
local utils = require 'framework.helper.Utils'
local factory = XMLFactory:getInstance()
factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DHunt.cocos.zip")
local document = factory:createDocument("DHunt.cocos")
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

function HuntHelper.getTreasureRootNode( ... )
	local setTreasure = createCellSet("@pageTreasure")
	HuntHelper.updateTreasure( setTreasure )
	return setTreasure
end

function HuntHelper.updateTreasure( setTreasure )
	-- local record = GuildCopyFunc.getGuildCopyRecord()
	-- if record then
	-- 	HuntHelper.updateTreasureInterior( setTreasure )
	-- else
		socketC:send(netModel.getModelGuildCopyGet(), function ( data )
	   		if data and data.D then
	   			GuildCopyFunc.setGuildCopy(data.D.GuildCopy)
	   			GuildCopyFunc.setGuildCopyRecord(data.D.Record)
	   			HuntHelper.updateTreasureInterior( setTreasure )
	   		end
	 	end)
	-- end
end

function HuntHelper.updateTreasureInterior( setTreasure )
	local record = GuildCopyFunc.getGuildCopyRecord()
	for i=1,3 do
		local percent = GuildCopyFunc.getBoxProcess(i)

		setTreasure[string.format("bg_box%d_btn", i)]:setListener(function ( ... )
			GleeCore:showLayer("DHuntBoxKey", {boxIndex = i})
		end)
		setTreasure[string.format("bg_box%d_btnOk", i)]:setListener(function ( ... )
			if percent >= 1 then
				socketC:send(netModel.getModelGuildCopyBoxOpen(i), function ( data )
					if data and data.D then
						GuildCopyFunc.setGuildCopyRecord(data.D.Record)
						require "AppData".updateResource(data.D.Resource)
						res.doActionGetReward(data.D.Reward)
						HuntHelper.updateTreasure( setTreasure )
					end
				end)
			else
				require "EventCenter".eventInput("GoToHunt", {AreaId = 0})
			end
		end)
		if record and record[string.format("Box%dOpened", i)] then
			setTreasure[string.format("bg_box%d_btnOk_point", i)]:setVisible(false)
			setTreasure[string.format("bg_box%d_btnOk", i)]:setEnabled(false)
			setTreasure[string.format("bg_box%d_btnOk_text", i)]:setString( res.locString("Hunt$OpenRewardFinish") )
		else
			setTreasure[string.format("bg_box%d_btnOk", i)]:setEnabled(true)
			setTreasure[string.format("bg_box%d_btnOk_point", i)]:setVisible(percent >= 1)
			setTreasure[string.format("bg_box%d_btnOk_text", i)]:setString(percent >= 1 and res.locString("Hunt$OpenReward") or res.locString("Hunt$Tansuo"))
		end

		setTreasure[string.format("bg_box%d_base", i)]:removeAllChildrenWithCleanup(true)
		local process = createCellSet("@process")
		setTreasure[string.format("bg_box%d_base", i)]:addChild(process[1])
		HuntHelper.updateProcess(process, 130, percent)
	end
end

function HuntHelper.updateProcess( set, width, process, scale )
	process = math.min(process, 1)
	local color
	if process >= 1 then
		color = 1
	elseif process >= 0.2 then
		color = 2
	else
		color = 3
	end
	set["pro_l"]:setResid(string.format("N_SLC_jindu%d_1.png", color))
	set["pro_pro0"]:setResid(string.format("N_SLC_jindu%d_2.png", color))
	set["pro_r"]:setResid(string.format("N_SLC_jindu%d_3.png", color))
	set["bg_bg0"]:setScaleX( width / 2 )
	set["pro_pro0"]:setScaleX( width / 2 * process )
	set["percent"]:setString(string.format("%d%%", process * 100))
	set["pro"]:setPosition( ccp(-width / 2 + width * process / 2, 0) )
	set[1]:setScale(scale or 1)
end

return HuntHelper