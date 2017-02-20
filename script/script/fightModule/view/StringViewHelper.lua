local StringViewHelper = {}

StringViewHelper.setString = function ( nodes, str, resMap)
	-- body
	local len = #str
	local nlen = (#nodes)

	assert(len <= nlen)

	for i=1,len do
		local node = nodes[i]
		local c = string.sub(str, i, i)

		local res = resMap[c]

		assert(res, 'not expected '..c..'!')

		node:setScaleX(1)
		node:setResid(res)

	end

	for i=len+1, nlen do
		local node = nodes[i]
		node:setScaleX(0)
		node:setResid('null')
	end

end


local Round_Big_ResMap = {
	['0'] = 'ZD_YJ_0.png',
	['1'] = 'ZD_YJ_1.png',
	['2'] = 'ZD_YJ_2.png',
	['3'] = 'ZD_YJ_3.png',
	['4'] = 'ZD_YJ_4.png',
	['5'] = 'ZD_YJ_5.png',
	['6'] = 'ZD_YJ_6.png',
	['7'] = 'ZD_YJ_7.png',
	['8'] = 'ZD_YJ_8.png',
	['9'] = 'ZD_YJ_9.png',
	['/'] = 'ZD_YJ_FH.png',
	['回合'] = 'bg_ZDHHWZ.png',
};

local Round_Small_ResMap = {
	['0'] = 'ZD_ZSJ_0.png',
	['1'] = 'ZD_ZSJ_1.png',
	['2'] = 'ZD_ZSJ_2.png',
	['3'] = 'ZD_ZSJ_3.png',
	['4'] = 'ZD_ZSJ_4.png',
	['5'] = 'ZD_ZSJ_5.png',
	['6'] = 'ZD_ZSJ_6.png',
	['7'] = 'ZD_ZSJ_7.png',
	['8'] = 'ZD_ZSJ_8.png',
	['9'] = 'ZD_ZSJ_9.png',
	['/'] = 'ZD_ZSJ_FH.png',
	['回合'] = 'ZD_ZSJ_HH.png',
};

StringViewHelper.setRoundBigString = function ( nodes, str )
	-- body
	return StringViewHelper.setString( nodes, str, Round_Big_ResMap )
end

StringViewHelper.setRoundSmallString = function ( nodes, str )
	-- body
	return StringViewHelper.setString( nodes, str, Round_Small_ResMap )
end

return StringViewHelper