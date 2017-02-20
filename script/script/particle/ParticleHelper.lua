local ParticleHelper = {}

function ParticleHelper.addLoginParticles( rootNode, zOrder )
	-- body
	if rootNode then
		local plists = { 'particle/sakura.plist', 'particle/sakura3.plist', 'particle/sakura4.plist' }
		local positions = { ccp(640, 640+20), ccp(0, 640+20), ccp(-640, 640+20) }

		zOrder = zOrder or 100000

		for i,v in ipairs(plists) do

			-- if i==2 then
				local p = CCParticleSystemQuad:create(v)
				rootNode:addChild(p, zOrder)

				p:setPosition(positions[i])
				p:setScale(1.5)
				-- p:setTotalParticles(5)

				p:setLife( p:getLife()*1.5 )
				-- p:setLifeVar( p:getLifeVar()*3 )

				p:setGravity(ccp(5,-5))
			-- end

		end
	end
end

function ParticleHelper.addFlowerParticles( rootNode, zOrder )
	if rootNode then
		local plists = { 'particle/snow.plist', 'particle/snow3.plist', 'particle/snow4.plist'}
		local flowers = {
			"YD_petal1_s.png", "YD_petal1.png", "YD_petal1s.png",
			"YD_petal3s_s.png", "YD_petal3.png", "YD_petal3s.png",
			"YD_petal4s_s.png", "YD_petal4.png", "YD_petal4s.png",
		}

		zOrder = zOrder or 100000

		local bNotify = CCFileUtils:sharedFileUtils():isPopupNotify();
		CCFileUtils:sharedFileUtils():setPopupNotify(false);

		local Particles = 40
		for i=1,Particles do
			local p = CCParticleSystemQuad:create(plists[math.random(3)])
			local tex = CCTextureCache:sharedTextureCache():addImage("particle/" .. flowers[math.random(9)]);
			p:setTexture(tex)

			rootNode:addChild(p, zOrder)

			p:setPosition(ccp(math.random(-640, 640), math.random(640, 660)))
			p:setScale(2.5)

			p:setGravity(ccp(5,-5))
		end

		CCFileUtils:sharedFileUtils():setPopupNotify(bNotify);
	end
end

function ParticleHelper.addSnowParticles( rootNode, zOrder )
	-- body
	if rootNode then
		local plists = { 'particle/snow.plist', 'particle/snow3.plist', 'particle/snow4.plist'}
		zOrder = zOrder or 100000

		local Particles = 25
		for i=1,Particles do
			local p = CCParticleSystemQuad:create(plists[math.random(3)])
			rootNode:addChild(p, zOrder)

			p:setPosition(ccp(math.random(-640, 640), math.random(640, 660)))
			p:setScale(1.5)
			-- p:setTotalParticles(5)

		--	p:setLife( p:getLife()*2 )
			-- p:setLifeVar( p:getLifeVar()*3 )

			p:setGravity(ccp(5,-5))
		end
	end
end

function ParticleHelper.moveParticlesBetween2Nodes( node1, node2 )
	-- body
	if node1 and node2 then
		local count = node1:getChildrenCount()

		local childArr = {}

		for i=1,count do
			local p = tolua.cast(node1:getChildren():objectAtIndex(i-1), "CCNode") 
			p:retain()
			table.insert(childArr, p)
		end

		node1:removeAllChildrenWithCleanup(false)

		for i=1,count do
			local p = childArr[i]
			node2:addChild(p)
			p:release()
		end
	end
end




return ParticleHelper