
--[[
20fps
--]]

--[[
暴击文字
第1帧.	出现文字
第2帧.	文字以中心为焦点放大1.6倍
第3帧.	向左下移动2像素
第4帧.	向右下移动3像素
第5帧.	向左上移动2像素
第6帧.	向左上移动4像素
第7帧.	向右上移动3像素
第8帧.	向左下移动3像素
第9帧.	上移3像素，透明度67%
第10帧.	上移3像素，透明度33%
第11帧.	上移3像素，透明度0%


frame-list -> place2 + remove2
				-> p, s, r, a, c, i, ar, v, 
			
			-> ShowFrame
			-> EndFrame

			-> ISwfTag

			    -> getFrameData   Place2 + Remove2
			    -> getShapeData   DefineShape
			    -> getStageData   
			    	->size
			    	->fps
					
			-> shapeMap
			id -> shapeData
			

local _depthData = {}

_depthData.maxF = 20
_depthData.fps = 20
_depthData.size = {1136, 640}

_depthData.shapeMap = {
	[1] = 'shape1', -- 1136 * 640
	[2] = 'shape2', --
	[3] = 'shape3',
	[4] = 'shape4',
	[5] = 'shape5',
}

_depthData.array = {}

--depth 1
_depthData.array[1] = {
	[1] = { f = 1, p = {0,0}, s = {1,1}, r = 0, c={255,255,255}, a=255, i = '', ar = {}, v=true},
	[2] = { f = 2, p = {0,0}, s = {1,1}, r = 0},
	[3] = { f = 3, p = {0,0}, s = {1,1}, r = 0},
}

return _depthData

--]]

local _table = {
		
	{ frame = 1, 	position = {0,0}, 		alpha = 1, 			scale = {1, 1}, 		ease = 0 },
	{ frame = 2, 	position = {0,0}, 		alpha = 1, 			scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 3, 	position = {-2,-2}, 	alpha = 1, 			scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 4, 	position = {3,3}, 		alpha = 1, 			scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 5, 	position = {-2,2}, 		alpha = 1, 			scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 6, 	position = {-4,4}, 		alpha = 1, 			scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 7, 	position = {3,3}, 		alpha = 1, 			scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 8, 	position = {-3,-3}, 	alpha = 1, 			scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 9, 	position = {0,3}, 		alpha = 0.67, 		scale = {1.6, 1.6}, 	ease = 0 },
	{ frame = 10, 	position = {0,3}, 		alpha = 0.33, 		scale = {1.6, 1.6}, 		ease = 0 },
	{ frame = 11, 	position = {0,3}, 		alpha = 0, 			scale = {1.6, 1.6}, 		ease = 0 },
	
}



return _table