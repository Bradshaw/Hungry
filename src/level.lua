local level_mt = {}
level = {}

level.tilesize = 32


level.rooms = {}

local i = 1
while love.filesystem.exists("images/rooms/room_"..string.format("%03d",i)..".png") and love.filesystem.exists("images/rooms/room_"..string.format("%03d",i)..".lua") do
	print(i)
	level.rooms = {
		image = love.graphics.newImage("images/rooms/room_"..string.format("%03d",i)..".png"),
		meta = require("images/rooms/room_"..string.format("%03d",i))
	}
	i = i+1
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
			if math.random(1,6)==1 then
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


	return self
end

function level_mt:addModule(module, index)
	local index = index or math.random(1,#level.rooms)

end

function level_mt:retex(  )
	love.graphics.setCanvas(self.maptex)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",0,0,1024,1024)
	love.graphics.setColor(0,32,92)
	love.graphics.setLineWidth(3)
	for i=1,self.xsize do
		for j=1,self.ysize do
			if self.data[i][j] then
				love.graphics.polygon("line", self.data[i][j].body:getWorldPoints(self.data[i][j].shape:getPoints()))
			end
		end
	end
	love.graphics.setColor(0,0,0)
	for i=1,self.xsize do
		for j=1,self.ysize do
			if self.data[i][j] then
				love.graphics.polygon("fill", self.data[i][j].body:getWorldPoints(self.data[i][j].shape:getPoints()))
			end
		end
	end
	love.graphics.setLineWidth(1)
	love.graphics.setCanvas()
end

function level_mt:draw( ... )
	for i=1,self.xsize do
		for j=1,self.ysize do
			if self.data[i][j] then
				love.graphics.polygon("fill", self.data[i][j].body:getWorldPoints(self.data[i][j].shape:getPoints()))
			end
		end
	end
end

function level_mt:drawMap( ... )
	if not self.texted then
		self:retex()
	end
	love.graphics.setColor(255,255,255)
	love.graphics.setBlendMode("additive")
	love.graphics.draw(self.maptex)
	love.graphics.setBlendMode("alpha")
end

function level_mt:drawShadow(x, y)
	love.graphics.setColor(0,0,0)
	for i=1,self.xsize do
		for j=1,self.ysize do
			if self.data[i][j] then
				local points = {}
				local farpoints = {}
				buildArray(points, self.data[i][j].body:getWorldPoints(self.data[i][j].shape:getPoints()))
				for i=1,#points,2 do
					local j = i+1
					local dx = points[i]-x
					local dy = points[j]-y
					local d = math.sqrt(dx*dx+dy*dy)
					if d~=0 then
						local nx = dx/d
						local ny = dy/d
						points[i] = points[i]+nx*8
						points[j] = points[j]+ny*8
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