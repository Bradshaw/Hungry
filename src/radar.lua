radar = {}

radar.r1 = 10000
radar.r2 = 10000
radar.x = 320
radar.y = 320
radar.speed = 300

radar.tex = love.graphics.newCanvas(1024,1024)

love.graphics.setCanvas(radar.tex)
love.graphics.setColor(0,0,0)
love.graphics.rectangle("fill",0,0,1024,1024)
love.graphics.setCanvas()
love.graphics.setColor(255,255,255)

function radar.ping(x,y)
	radar.r1 = 0
	radar.r2 = 0
	radar.x = x
	radar.y = y
end

radar.spotted = {}

function radar.update(dt)
	radar.r2=radar.r1
	radar.r1 = math.min(1280,radar.r1+dt*radar.speed)

	local i = 1
	while i<=#radar.spotted do
		local v = radar.spotted[i]
		local dx = radar.x - v.x
		local dy = radar.y - v.y
		local d = math.sqrt(dx*dx+dy*dy)
		if d<=radar.r1+30 and d>=radar.r1 then
			table.remove(radar.spotted, i)
		else
			i=i+1
		end
	end

	for i,v in ipairs(enemy.all) do
		local dx = radar.x - v.x
		local dy = radar.y - v.y
		local d = math.sqrt(dx*dx+dy*dy)
		if d<=radar.r1-15 and d>=radar.r2-15 then
			table.insert(radar.spotted, {x = v.x, y = v.y, a = 255/(radar.r1/100)})
		end
	end
	
	love.graphics.setCanvas()
end

function radar.draw( ... )
	love.graphics.setBlendMode("additive")
	for i,v in ipairs(radar.spotted) do
		love.graphics.setColor(92,0,0,v.a)
		love.graphics.circle("line", v.x, v.y, 6)
	end
	love.graphics.setColor(0,0,92,255/(radar.r1/50))
	love.graphics.circle("line",radar.x,radar.y,radar.r1)
	love.graphics.setBlendMode("alpha")
end