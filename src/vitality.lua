local food_mt = {}
food = {}

food.all = {}
food.spawns = {}

food.im = {}
food.im[1] = love.graphics.newImage("images/candy_crunch.png")
food.im[2] = love.graphics.newImage("images/mc_guffin.png")

food.snd = love.audio.newSource("audio/eat.ogg")

addPhysCallback(function(f1, f2, contact)
	local u1 = f1:getUserData()
	local u2 = f2:getUserData()
	if u1.isfood and u2.human then
		u1.purge = true
		u2:feed()
		food.snd:play()
	end
	if u2.isfood and u1.human then
		u2.purge = true
		u1:feed()
		food.snd:play()
	end
	
end)


function food.new( x, y )
	local self = setmetatable({},{__index = food_mt})
	self.im = math.random(1,2)
	self.isfood = true
	local wallHit = false
	while not wallHit do
		local spawn = enemy.spawns[math.random(1,#enemy.spawns)]
		self.x = math.random(spawn.x1,spawn.x2)
		self.y = math.random(spawn.y1,spawn.y2)
		wallHit = false
		for i=1,#player.all do

			local cand = player.all[i]

			world:rayCast( self.x, self.y, cand.x, cand.y, function(fix, xc, yc, xn, yn, frac)
				local u = fix:getUserData()
				if u and u.isAWall then
					wallHit = true
					return -1
				end
				return -1
			end )

		end
	end


	self.body = love.physics.newBody(world, self.x, self.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	self.body:setLinearDamping(20)
	self.body:setFixedRotation(true)
	self.body:setMass(1)
	self.shape = love.physics.newCircleShape(4) --the ball's shape has a radius of 20
	self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
	self.fixture:setUserData(self)
	self.fixture:setRestitution(0.1) --let the ball bounce
	self.target = nil
	table.insert(food.all, self)
	return self
end

function food.update( dt )
	local i = 1
	while i<=#food.all do
		local v = food.all[i]
		if v.purge then
			v.body:destroy()
			table.remove(food.all, i)
		else
			v:update(dt)
			i = i+1
		end

	end
end

function food.draw(  )
	for i,v in ipairs(food.all) do
		v:draw()
	end
end

function food_mt:update( dt )
	self.x = self.body:getX()
	self.y = self.body:getY()
end

function food_mt:draw(  )
	love.graphics.setColor(255,255,255)
	love.graphics.draw(food.im[self.im], self.x, self.y, 0, 1, 1, 8, 8)
	
end