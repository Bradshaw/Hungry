local player_mt = {}
player = {}

player.shadervig = love.graphics.newImage("images/vig.png")

function player.new( joystick, x, y )
	local self = setmetatable({},{__index = player_mt})
	self.joystick = joystick

	self.hp = 100

	self.isPlayer = true

	self.main = weapon.pistol()
	self.secondary = nil -- weapon.ping()

	self.speed = 100
	self.aimx = 0
	self.aimy = -1

	self.x = x --math.random(64,64)
	self.y = y --math.random(64,64)

	self.body = love.physics.newBody(world, self.x, self.y, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	self.body:setLinearDamping(20)
	self.body:setFixedRotation(true)
	self.body:setMass(1)
	self.shape = love.physics.newCircleShape(3) --the ball's shape has a radius of 20
	self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
	self.fixture:setUserData(self)
	self.fixture:setRestitution(0.1) --let the ball bounce
	return self
end


function player_mt:whack( enemy )
	shake = 0.5
	local dx = self.x-enemy.x
	local dy = self.y-enemy.y
	local d = math.sqrt(dx*dx+dy*dy)
	if d ~= 0 then
		local nx = dx/d
		local ny = dy/d
		self.body:applyLinearImpulse(nx*4,ny*4)
	end
	--self.hp = math.max(0,self.hp-math.random(5,20))
end

function player_mt:getWeapon()
	return (self.secondary or self.main)
end

function player_mt:update( dt )
	if self.hp>0 then
		local movex = self.joystick:getAxis(1)
		local movey = self.joystick:getAxis(2)
		local targx = self.joystick:getAxis(3)
		local targy = self.joystick:getAxis(4)

		local doMove = (useful.deadzone(movex)~=0 or useful.deadzone(movey)~=0)
		local doTarg = (useful.deadzone(targx)~=0 or useful.deadzone(targy)~=0)
		

		if doMove then
			local d = math.sqrt(movex*movex+movey*movey)
			local nx = movex/d
			local ny = movey/d
			self.aimx = nx
			self.aimy = ny

			self.body:applyForce(movex*10, movey*10)
		end

		if doTarg then
			local d = math.sqrt(targx*targx+targy*targy)
			local nx = targx/d
			local ny = targy/d
			self.aimx = nx
			self.aimy = ny
		end

		self.main:updateOnCharacter(dt)
		if self.secondary then
			self.secondary:updateOnCharacter(dt)
		end
		if self.joystick:isDown(9) then
			self:getWeapon():fire(self.x,self.y,self.aimx,self.aimy)
		end
		if self.joystick:isDown(8) then
			--radar.ping(self.x, self.y)
			self.main:fire(self.x,self.y,self.aimx,self.aimy)
		end

		self.x = self.body:getX()
		self.y = self.body:getY()
	end

end

function player_mt:draw(  )
	if self.hp>0 then
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",self.body:getX()-2,self.body:getY()-2, 4, 4)
		love.graphics.line(self.body:getX(),self.body:getY(),self.body:getX()+self.aimx*8,self.body:getY()+self.aimy*8)
	end
end

function player_mt:drawShadow()
	for i=0,2 do
		love.graphics.setColor(0,0,0,127+i*(128/2))
		local ang = math.atan2(self.aimy,self.aimx)

		local spread = math.pi*2*(-0.05+0.05*i)
		local count = 10
		local dist = 20+20*i

		local points = {}
		local farpoints = {}
		


		for i=1,count do
			local pa = ang+spread/2 + i*((math.pi*2-spread)/count)
			local px = self.x + math.cos(pa)*dist
			local py = self.y + math.sin(pa)*dist
			table.insert(points, px)
			table.insert(points, py)
		end


		for i=1,#points,2 do
			local j = i+1
			local dx = points[i]-self.x
			local dy = points[j]-self.y
			local d = math.sqrt(dx*dx+dy*dy)
			if d~=0 then
				local nx = dx/d
				local ny = dy/d
				points[i] = points[i]+nx*0
				points[j] = points[j]+ny*0
			end
			farpoints[i] = points[i]+dx*1000
			farpoints[j] = points[j]+dy*1000
		end
		for i=1,#points-4,2 do

			local x1 = points[mod1(i,#points)]
			local y1 = points[mod1(i+1,#points)]
			local x2 = points[mod1(i+2,#points)]
			local y2 = points[mod1(i+3,#points)]
			local x3 = farpoints[mod1(i,#points)]
			local y3 = farpoints[mod1(i+1,#points)]
			local x4 = farpoints[mod1(i+2,#points)]
			local y4 = farpoints[mod1(i+3,#points)]
			love.graphics.polygon("fill", x1, y1, x2, y2, x4, y4, x3, y3)
		end
	end
	love.graphics.setColor(0,0,0)
	love.graphics.draw(player.shadervig,self.x, self.y, 0, 0.75, 0.75, 640, 640)
end