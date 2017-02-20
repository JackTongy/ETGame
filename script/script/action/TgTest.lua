
local Swf = require 'framework.swf.Swf'

local myswf = Swf.new('Swf_TongGuan')
xxx:addChild( myswf:getRootNode() )

local shapeMap = {
	['shape-2'] = 'xxx.png',
}
myswf:play(shapeMap, nil, func)
