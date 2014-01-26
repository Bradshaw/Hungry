local bullet_mt = {}
bullet = {}

bullet.all = {}

function bullet.new( x, y, dx, dy )
	local self = setmetatable({},{__index=bullet_mt})

	self.x = x
	self.y = y
	self.dx = dx
	self.dy = dy

	table.insert(bullet.all, self)
	return self
end

function bullet.pistol( ... )
	local self = bullet.new( ... )

	return self
end

function bullet.update( dt )
	local i = 1
	while i<=#bullet.all do
		local v = bullet.all[i]
		if v.purge then
			table.remove(bullet.all, i)
		else
			v:update(dt)
			i=i+1
		end
	end
end

function bullet.draw(  )
	for i,v in ipairs(bullet.all) do
		v:draw()
	end
end

function bullet_mt:doDamage( target )
	if target.hp then
		target.hp = target.hp - 1
	end
	self.purge = true
end

function bullet_mt:update( dt )
	local oldx = self.x
	local oldy = self.y
	self.x = self.x+self.dx*dt
	self.y = self.y+self.dy*dt

	world:rayCast(oldx,oldy,self.x,self.y, function(fix, x, y, xn, yn, fraction)
		local u = fix:getUserData()
		if u and u.isAWall then
			self.purge = true
			return 0
		else
			return -1
		end
	end)

	for i,v in ipairs(enemy.all) do
		local dx = self.x-v.x
		local dy = self.y-v.y
		local d = math.sqrt(dx*dx+dy*dy)
		if d<10 then
			local speed = math.sqrt(self.dx*self.dx+self.dy*self.dy)
			local nx = self.dx/speed
			local ny = self.dy/speed
			v.body:applyLinearImpulse(nx*2,ny*2)
			self:doDamage(v)
			return
		end
	end
end

function bullet_mt:draw(  )
	love.graphics.circle("fill",self.x, self.y, 4)
end