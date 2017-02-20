local CfgHelper = require 'CfgHelper'

local SkinManager = {}
local Cache = {}

function SkinManager.charactorIdToRoleId( charactorId )
	-- local roleid = CfgHelper.getCache('pve_charactor', 'charactorId', tonumber(charactorId), 'roleid')
	-- if not roleid then
	-- 	roleid = 29
	-- end
	-- roleid = tonumber(roleid)
	charactorId = tonumber(charactorId)
	assert(charactorId)
	
	if charactorId < 10 then
		charactorId = '00'..charactorId
	elseif charactorId < 100 then
		charactorId = '0'..charactorId
	else
		charactorId = tostring(charactorId)
	end
	
	return charactorId
end

function SkinManager.charactorToSkin( charactorId )
	-- local roleid = CfgHelper.getCache('pve_charactor', 'charactorId', tonumber(charactorId), 'roleid')
	-- if not roleid then
	-- 	roleid = 29
	-- end
	-- roleid = tonumber(roleid)
	charactorId = tonumber(charactorId)
	assert(charactorId)

	if charactorId < 10 then
		charactorId = '00'..charactorId
	elseif charactorId < 100 then
		charactorId = '0'..charactorId
	else
		charactorId = tostring(charactorId)
	end
	
	return charactorId
end

function SkinManager.getTouImage( charactorId )
	-- body
	local roleid = tonumber(charactorId)
	assert(roleid, ''..charactorId)

	return string.format('skin_%dt.png', roleid)
end

function SkinManager.getNormalFaceImage( charactorId )
	-- body
	local roleid = tonumber(charactorId)
	assert(roleid, ''..charactorId)
	
	return string.format('face_%d_normal.png', roleid)
end

function SkinManager.getAnimateTimeByCharactorIdAndName( charactorId, name )
	-- body
	-- if name == '大招' then
	-- 	return 10000
	-- end

	local skin = SkinManager.getRoleXMLByCharactorId(charactorId)

	local time = CfgHelper.getCache('BonesData', 'name', skin, name) or 0
	-- assert(time, string.format('BonesData: Not Found %s : %s', tostring(charactorId), tostring(name)))
	
	return time
end

function SkinManager.makeSureCache( skin )
	-- body
	local t = Cache[skin]

	if not t then
		t = {}
		Cache[skin] = t
	end

	return t
end

--获得xml
function SkinManager.getRoleXMLByCharactorId( charactorId )
	-- body
	local skin = SkinManager.charactorToSkin(charactorId)
	local t = SkinManager.makeSureCache(skin)

	if not t.RoleXML then

		t.RoleXML = string.format('role-%s', skin)

		print('SkinManager:'..t.RoleXML)
	end

	return t.RoleXML
end

--[[
1.全身像
2.裁切图
--]]
function SkinManager.getRoleBigIcon2ByCharactorId( charactorId )
	-- body
	local skin = SkinManager.charactorToSkin(charactorId)
	local t = SkinManager.makeSureCache(skin)

	if not t.BigIcon2 then
		t.BigIcon2 = {}
		t.BigIcon2[1] = string.format('role_%s.png', skin)
		t.BigIcon2[2] = string.format('role_%s-1.png', skin)
	end

	return t.BigIcon2
end

return SkinManager