local LangAdapter = {}

local LangName = require 'Config'.LangName or ''
local Res = require 'Res'

-------------------------------------------------------------------------------------------------------------------
function selectLang( thai ,tra_ch,vn,kor,en,es,pt,indo,arabic,german)
	if LangName == 'thai' then
		return thai and thai()
	elseif LangName == "tra_ch" then
		return tra_ch and tra_ch()
	elseif LangName == 'vn' then
		return vn and vn()
	elseif LangName == 'kor' then
		return kor and kor()
	elseif LangName == 'english' then
		return en and en()
	elseif LangName == 'ES' then
		if es then
			return es()
		else
			return en and en()
		end
	elseif LangName == 'PT' then
		if pt then
			return pt()
		else
			return en and en()
		end
	elseif LangName == 'Indonesia' then
		if indo then
			return indo()
		else
			return en and en()
		end
	elseif LangName == 'Arabic' then
		if arabic then
			return arabic()
		else
			return en and en()
		end
	elseif LangName == 'German' then
		if german then
			return german()
		else
			return en and en()
		end
	end
end

--[[
	{en=function() ... end}
]]
function selectLangkv( kv )
	local func = kv[LangName]
	if not func and (LangName == 'PT' or LangName == 'Indonesia') then
		func = kv['en']
	end

	return func and func()
end

LangAdapter.selectLang = selectLang
LangAdapter.selectLangkv = selectLangkv

local generateFunc = function ( f,... )
	local nParam = select("#",...)
	local arr = {}
	for i=1,nParam do
		local v = select(i,...)
		arr[i] = function (  )
			f(v)
		end
	end
	selectLang(unpack(arr))
end

function LangAdapter.labelDimensions( node,...)
	if node then
		generateFunc(function ( v )
			return v ~= nil and node:setDimensions(v)
		end,...)
	end
end

if ElfDate.setFormatString then
	ElfDate:setFormatString('','',Res.locString('Activity$DayTaild'),'','','')
end

function LangAdapter.nodePos( node,... )
	if node then
		generateFunc(function ( v )
			return v ~= nil and node:setPosition(v)
		end,...)
	end
end

function LangAdapter.fontSize( node,... )
	if node then
		generateFunc(function ( v )
			return v ~= nil and node:setFontSize(v)
		end,...)
	end
end

function LangAdapter.setVisible( node,... )
	if node then
		generateFunc(function ( v )
			return v ~= nil and node:setVisible(v)
		end,...)
	end
end

function LangAdapter.LabelNodeAutoShrink( labelnode,maxwidth,maxheight )
	if labelnode and labelnode.setString and not labelnode.setStringRaw then
		labelnode.setStringRaw = labelnode.setString

		local scalelabel = function ( labelnode )
			if labelnode:getString() then
				local scalew = 1
				local scaleh = 1
				if labelnode.origfontsize then
					labelnode:setFontSize(labelnode.origfontsize)
				end
				local size = labelnode:getContentSize()
				if maxwidth and labelnode:getScale() == 1 and size.width > maxwidth then
					scalew = labelnode:getScale()*maxwidth/size.width
				end
				if maxheight and labelnode:getScale() == 1 and size.height > maxheight then
					scaleh = labelnode:getScale()*maxheight/size.height
				end
				local finalscale = math.min(scalew,scaleh)
				if finalscale < 1 then
					labelnode.origfontsize = labelnode.origfontsize or labelnode:getFontSize()
					labelnode:setFontSize(finalscale*labelnode.origfontsize)
				end
			end
		end

		labelnode.setString = function (self, string )
			self:setStringRaw(string)
			scalelabel(self)
		end

		scalelabel(labelnode)
	end
end

function LangAdapter.LayoutChildrenReverse( layout )
	if layout and layout:getChildren():count() > 0 then
		layout:getChildren():reverseObjects()
	end
end

function LangAdapter.LayoutChildrenReverseifArabic( layout )
	if LangName == 'Arabic' and layout and layout:getChildren():count() > 0 then
		layout:getChildren():reverseObjects()
	end
end

function LangAdapter.LayoutChildrenReverseWithChildIfArabic( childNode )
	if LangName == 'Arabic' and childNode then
		childNode:getParent():getChildren():reverseObjects()
	end
end

function LangAdapter.NodesPosReverse( ... )
	local nodes = {...}
	if LangName == 'Arabic' and nodes and #nodes > 1 then
		for i=1,(#nodes)/2 do
			local tmp = nodes[#nodes-i+1]
			tmp.opos = tmp.opos or {tmp:getPosition()}
			tmp.ancp = tmp.ancp or tmp:getAnchorPoint()
			nodes[i].opos = nodes[i].opos or {nodes[i]:getPosition()}
			nodes[i].ancp = nodes[i].ancp or nodes[i]:getAnchorPoint()

			tmp:setAnchorPoint(nodes[i].ancp)
			tmp:setPosition(ccp(nodes[i].opos[1],nodes[i].opos[2]))
			nodes[i]:setAnchorPoint(tmp.ancp)
			nodes[i]:setPosition(ccp(tmp.opos[1],tmp.opos[2]))
		end
	end
end

function LangAdapter.LabelNodeSetHorizontalAlignment( labelnode,alignment )
	local datatype = type(labelnode:getHorizontalAlignment())
	if datatype and datatype == 'number' then
		labelnode:setHorizontalAlignment(alignment)
	end
end

function LangAdapter.LabelNodeSetVerticalAlignment(labelnode,alignment)
	local datatype = type(labelnode:getVerticalAlignment())
	if datatype and datatype == 'number' then
		labelnode:setVerticalAlignment(alignment)
	end
end

function LangAdapter.LabelNodeSetHorizontalAlignmentIfArabic( labelnode,alignment )
	if LangName == 'Arabic' and labelnode then
		local datatype = type(labelnode:getHorizontalAlignment())
		if datatype and datatype == 'number' then
			labelnode:setHorizontalAlignment(alignment or kCCTextAlignmentRight)
		end
	end
end

return LangAdapter