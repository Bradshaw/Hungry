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
	love.graphics.setCanvas(radar.tex)
	love.graphics.setColor(0,0,0)
	--love.graphics.rectangle("fill",0,0,1024,1024)
	love.graphics.setCanvas()
	love.graphics.setColor(255,255,255)
end

function radar.update(dt)
	radar.r2=radar.r1
	radar.r1 = math.min(1280,radar.r1+dt*radar.speed)
	love.graphics.setCanvas(radar.tex)
	love.graphics.setColor(64,192,64,255/(radar.r1/50))
	love.graphics.setLineWidth(20)
	love.graphics.circle("line",radar.x,radar.y,radar.r1+2)
	love.graphics.setColor(0,0,0)
	love.graphics.setLineWidth(20)
	love.graphics.circle("line",radar.x,radar.y,radar.r1)
	love.graphics.setLineWidth(1)
	love.graphics.setColor(192,64,64,255/(radar.r1/100))
	for i,v in ipairs(enemy.all) do
		local dx = radar.x - v.x
		local dy = radar.y - v.y
		local d = math.sqrt(dx*dx+dy*dy)
		if d<=radar.r1-15 and d>=radar.r2-15 then
			v:draw()
		end
	end
	
	love.graphics.setCanvas()
end

function radar.draw( ... )
	love.graphics.setColor(255,255,255)
	love.graphics.setBlendMode("additive")
	love.graphics.draw(radar.tex)
	love.graphics.setBlendMode("alpha")
end