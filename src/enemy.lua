local enemy_mt = {}
enemy = {}

enemy.all = {}
enemy.spawns = {}

addPhysCallback(function(f1, f2, contact)
	local u1 = f1:getUserData()
	local u2 = f2:getUserData()
	if u1.isEnemy then
		if u2.isPlayer then
			u2:whack(u1)
		end
	end
	if u2.isEnemy then
		if u1.isPlayer then
			u1:whack(u2)
		end
	end
	
end)


function enemy.new( x, y )
	local self = setmetatable({},{__index = enemy_mt})

	self.isEnemy = true
	local wallHit = false
	while not wallHit do
		local spawn = enemy.spawns[math.random(1,#enemy.spawns)]
		self.x = math.random(spawn.x1,spawn.x2)
		self.y = math.random(spawn.y1,spawn.y2)
		wallHit = false
		for i=1,#player.all do

			local cand = player.all[math.random(1,#player.all)]

			world:rayCast( self.x, self.y, cand.x, cand.y, function(fix, xc, yc, xn, yn, frac)
				local u = fix:getUserData()
				if u and u.isAWall then
					wallHit = true
					return 0
				end
				return -1
			end )

		end
	end


	self.hp = 3
	self.forget = math.random()*5
	self.body = love.physics.newBody(world, self.x, self.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	self.body:setLinearDamping(20)
	self.body:setFixedRotation(true)
	self.body:setMass(1)
	self.shape = love.physics.newCircleShape(6) --the ball's shape has a radius of 20
	self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
	self.fixture:setUserData(self)
	self.fixture:setRestitution(0.1) --let the ball bounce
	self.target = nil
	table.insert(enemy.all, self)
	return self
end

function enemy.update( dt )
	local i = 1
	while i<=#enemy.all do
		local v = enemy.all[i]
		if v.purge then
			v.body:destroy()
			table.remove(enemy.all, i)
		else
			v:update(dt)
			i = i+1
		end

	end
end

function enemy.draw(  )
	for i,v in ipairs(enemy.all) do
		v:draw()
	end
end

function enemy_mt:update( dt )
	self.forget = self.forget-dt
	if self.forget<0 then
		self.target = nil
		self.forget = math.random()*5
	end
	if self.hp<=0 then
		self.purge = true
	end
	if not self.target or self.target.purge then
		local p = {}
		for i,v in ipairs(player.all) do
			if not v.purge then
				table.insert(p, v)
			end
		end
		local wallHit = false

		local cand = p[math.random(1,#p)]

		world:rayCast( self.x, self.y, cand.x, cand.y, function(fix, xc, yc, xn, yn, frac)
			local u = fix:getUserData()
			if u and u.isAWall then
				wallHit = true
				return 0
			end
			return -1
		end )
		if not wallHit then
			self.target = cand
		end
	end
	if self.target then
		local targ = self.target
		local dx = targ.x-self.x
		local dy = targ.y-self.y
		local d = math.sqrt(dx*dx+dy*dy)
		local nx = dx/d
		local ny = dy/d
		if d>0 then
			self.body:applyForce(nx*35, ny*35)
		end
	end

	self.x = self.body:getX()
	self.y = self.body:getY()
end

function enemy_mt:draw(  )
	love.graphics.setColor(255,0,0)
	love.graphics.circle("fill",self.x, self.y, 6)
end