local level_mt = {}
level = {}

level.tilesize = 32


level.rooms = {}

local i = 1
while love.filesystem.exists("images/rooms/room_"..string.format("%03d",i)..".png") and love.filesystem.exists("images/rooms/room_"..string.format("%03d",i)..".lua") do
	print("loading")
	level.rooms[i] = {
		image = love.graphics.newImage("images/rooms/room_"..string.format("%03d",i)..".png"),
		meta = require("images/rooms/room_"..string.format("%03d",i))
	}
	print(level.rooms[i])
	i = i+1
end

for i,v in ipairs(level.rooms) do
	print("lul"..i,v)
end


function level.new(  )
	local self = setmetatable({},{__index = level_mt})

	self.maptex = love.graphics.newCanvas(1024,1024)
	self.texted = false

	self.xsize = 640/level.tilesize
	self.ysize = 640/level.tilesize

	self.isAWall = true

	self.data = {}
	for i=1,self.xsize do
		self.data[i]={}
		for j=1,self.ysize do
			if false and math.random(1,6)==1 then
				local wall = {}
				wall.body = love.physics.newBody(world, i*level.tilesize-level.tilesize/2, j*level.tilesize-level.tilesize/2, "static") --place the body in the center of the world and make it dynamic, so it can move around
				wall.shape = love.physics.newRectangleShape( level.tilesize, level.tilesize ) --the ball's shape has a radius of 20
				wall.fixture = love.physics.newFixture(wall.body, wall.shape, 1) -- Attach fixture to body and give it a density of 1.
				wall.fixture:setUserData(self)
				wall.fixture:setRestitution(0.1) --let the ball bounce
				--wall.body:setAngle(math.random()*math.pi*2)
				self.data[i][j] = wall
			end
		end
	end

	self.map = {}
	self.doors = {}
	self.blocked = {}
	self.images = {}
	self:addModule(0,0,1)
	for i=1,50 do
		self:append()
	end
	local remove = {}
	for i,v in ipairs(self.doors) do
		for j,u in ipairs(self.doors) do
			if not i==j then
				if useful.almost(v.x, u.x) and useful.almost(v.y, u.y) then
					table.insert(remove, i)
				end
			end
		end
	end
	for i=#remove,1,-1 do
		table.remove(self.doors, remove[i])
	end
	for i,v in ipairs(self.doors) do
		local h = 0
		local w = 0
		if v.t == "left" or v.t == "right" then
			w = 6
			h = 70
		else
			w = 70
			h = 6
		end
		local wall = {}
		wall.body = love.physics.newBody(world, v.x, v.y, "static") --place the body in the center of the world and make it dynamic, so it can move around
		wall.shape = love.physics.newRectangleShape( w, h ) --the ball's shape has a radius of 20
		wall.fixture = love.physics.newFixture(wall.body, wall.shape, 1) -- Attach fixture to body and give it a density of 1.
		wall.fixture:setUserData(self)
		wall.fixture:setRestitution(0.1) --let the ball bounce
		--wall.body:setAngle(math.random()*math.pi*2)
		table.insert(self.map,wall)
	end


	return self
end

function level_mt:append()
	local index = math.random(2,#level.rooms)
	local r = level.rooms[index]
	local door = r.meta.exits[math.random(1,#r.meta.exits)]
	local coord
	local search = ""
	if door.t == "left" then
		search = "right"
		coord ={
			x = 0,
			y = door.c
		}
	end
	if door.t == "right" then
		search = "left"
		coord ={
			x = r.meta.size[1],
			y = door.c
		}
	end
	if door.t == "up" then
		search = "down"
		coord ={
			x = door.c,
			y = 0
		}
	end
	if door.t == "down" then
		search = "up"
		coord ={
			x = door.c,
			y = r.meta.size[2]
		}
	end
	local cand = {}
	for i,v in ipairs(self.doors) do
		if v.t == search then
			table.insert(cand, {i=i, v=v})
		end
	end

	print("Candidates: ",#cand)

	if #cand>0 then
		local ci = math.random(1,#cand)
		local c = cand[ci].v
		local aabb = {
			x = c.x-coord.x,
			y = c.y-coord.y,
			w = r.meta.size[1],
			h = r.meta.size[2]
		}
		local wrong = false
		for i,v in ipairs(self.blocked) do
			local collision = true
			if aabb.x>=v.x+v.w or aabb.x+aabb.w<=v.x  then
				collision = false
				print("Escaped side")
			end
			if aabb.y>=v.y+v.h or aabb.y+aabb.h<=v.y then
				collision = false
				print("Escaped stack")
			end
			if collision then
				wrong = true
				print("Colliddion")
			end
		end

		if not wrong then
			print("Adding a bro")
			table.remove(self.doors, cand[ci].i)
			self:addModule(c.x-coord.x,c.y-coord.y,index,door.t)
		end
	end
end

function level_mt:isDupe(a)
	return false
end
function level_mt:addModule(x, y, index, discard)
	local index = index or math.random(2,#level.rooms)
	local r = level.rooms[index]

	for i,v in ipairs(r.meta.colliders) do
		local wall = {}
		wall.body = love.physics.newBody(world, x+v.w/2+v.x, y+v.h/2+v.y, "static") --place the body in the center of the world and make it dynamic, so it can move around
		wall.shape = love.physics.newRectangleShape( v.w, v.h ) --the ball's shape has a radius of 20
		wall.fixture = love.physics.newFixture(wall.body, wall.shape, 1) -- Attach fixture to body and give it a density of 1.
		wall.fixture:setUserData(self)
		wall.fixture:setRestitution(0.1) --let the ball bounce
		--wall.body:setAngle(math.random()*math.pi*2)
		table.insert(self.map,wall)
	end

	for i,v in ipairs(r.meta.spawns) do
		table.insert(enemy.spawns,{
			x1 = v.x1+x,
			y1 = v.y1+y,
			x2 = v.x2+x,
			y2 = v.y2+y
		})
	end

	table.insert(self.blocked, {
		x=x,
		y=y,
		w = r.meta.size[1],
		h = r.meta.size[2]
	})

	for i,v in ipairs(r.meta.exits) do
		if not discard or discard ~= v.t then
			local dupe = false
			--[[
			for j,u in ipairs(self.doors) do
				if useful.almost(v.x, u.x) or useful.almost(v.y, u.y) then
					dupe = true
				end
			end
			--]]
			if v.t == "left" then
				if not self:isDupe({x, y+v.c}) then
					table.insert(self.doors, {
						x = x,
						y = y+v.c,
						t = v.t
					})
				end
			end
			if v.t == "right" then
				if not self:isDupe({x+r.meta.size[1], y+v.c}) then
					table.insert(self.doors, {
						x = x+r.meta.size[1],
						y = y+v.c,
						t = v.t
					})
				end
			end
			if v.t == "up" then
				if not self:isDupe({x+v.c, y}) then
					table.insert(self.doors, {
						x = x+v.c,
						y = y,
						t = v.t
					})
				end
			end
			if v.t == "down" then
				if not self:isDupe({x+v.c, y+r.meta.size[2]}) then
					table.insert(self.doors, {
						x = x+v.c,
						y = y+r.meta.size[2],
						t = v.t
					})
				end
			end
		end
	end


	table.insert(self.images, {
		x = x,
		y = y,
		im = index})

end

function level_mt:retex(  )
	love.graphics.push()
	self.maptex:clear()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",0,0,1024,1024)
	love.graphics.translate(320-player.all[1].x, 320-player.all[1].y)
	love.graphics.setCanvas(self.maptex)
	love.graphics.setColor(0,16,32)
	love.graphics.setLineWidth(3)
	for i=1,self.xsize do
		for j=1,self.ysize do
			if self.data[i][j] then
				love.graphics.polygon("line", self.data[i][j].body:getWorldPoints(self.data[i][j].shape:getPoints()))
			end
		end
	end
	for i,v in ipairs(self.map) do
		love.graphics.polygon("line", v.body:getWorldPoints(v.shape:getPoints()))
	end
	love.graphics.setColor(0,0,0)
	for i=1,self.xsize do
		for j=1,self.ysize do
			if self.data[i][j] then
				love.graphics.polygon("fill", self.data[i][j].body:getWorldPoints(self.data[i][j].shape:getPoints()))
			end
		end
	end
	for i,v in ipairs(self.map) do
		love.graphics.polygon("fill", v.body:getWorldPoints(v.shape:getPoints()))
	end
	love.graphics.setLineWidth(1)
	love.graphics.setCanvas()
	love.graphics.pop()
end

function level_mt:draw( ... )
	for i=1,self.xsize do
		for j=1,self.ysize do
			if self.data[i][j] then
				--love.graphics.polygon("fill", self.data[i][j].body:getWorldPoints(self.data[i][j].shape:getPoints()))
			end
		end
	end
	for i,v in ipairs(self.map) do
		--love.graphics.polygon("fill", v.body:getWorldPoints(v.shape:getPoints()))
	end
	for i,v in ipairs(self.images) do
		love.graphics.draw(level.rooms[v.im].image,v.x, v.y)
	end

end

function level_mt:drawMap( ... )
	if true or not self.texted then
		--self:retex()
	end
	love.graphics.setColor(255,255,255)
	love.graphics.setBlendMode("additive")
	love.graphics.draw(self.maptex)
	love.graphics.setBlendMode("alpha")
end

function level_mt:drawShadow(x, y)
	love.graphics.setColor(0,0,0)


	for i,v in ipairs(self.map) do
		
		local points = {}
		local farpoints = {}
		buildArray(points, v.body:getWorldPoints(v.shape:getPoints()))
		for i=1,#points,2 do
			local j = i+1
			local dx = points[i]-x
			local dy = points[j]-y
			local d = math.sqrt(dx*dx+dy*dy)
			if d~=0 then
				local nx = dx/d
				local ny = dy/d
				points[i] = points[i]+nx*4
				points[j] = points[j]+ny*4
			end
			farpoints[i] = points[i]+dx*1000
			farpoints[j] = points[j]+dy*1000
		end
		for i=1,#points,2 do

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

	love.graphics.setColor(255,255,255)
end

function buildArray(array, e, ...)
	if e then
		table.insert(array, e)
		buildArray(array, ...)
	end
end

function mod1(n, d)
	return ((n-1)%d)+1
end