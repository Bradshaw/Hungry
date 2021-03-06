local state = gstate.new()


function state:init()

end


function state:enter()
	weapon.all = {}
	---[[
	while #enemy.all<0 do
		if math.random()>0.5 then
			enemy.new(math.random()*640,math.random(0,1)*640)
		else
			enemy.new(math.random(0,1)*640,math.random()*640)
		end
	end


	while #food.all<0 do
		food.new()
	end
	--]]
	spawntime = 1
	time = 20
end


function state:focus()

end


function state:mousepressed(x, y, btn)

end


function state:mousereleased(x, y, btn)
	
end


function state:joystickpressed(joystick, button)
	
end


function state:joystickreleased(joystick, button)
	
end


function state:quit()
	
end


function state:keypressed(key, uni)
	if key=="escape" then
		love.event.push("quit")
	end
end


function state:keyreleased(key, uni)
	
end


function state:update(dt)
	player.all[1].hp = player.all[1].hp - dt
	player.all[2].hp = math.min(player.all[2].hp + dt,100)
	time = math.min(100, time+dt)
	spawntime = spawntime - dt
	shake = math.max(0,shake-shake*10*dt-dt)

	for i,v in ipairs(player.all) do
		v:update(dt)
	end

	---[[
	if #enemy.all<math.min(100, time) and spawntime<=0 then
		spawntime = 1 - (time/200)
		enemy.new()
	end
	if #food.all<5  then
		food.new()
	end
	--]]

	enemy.update(dt)
	bullet.update(dt)
	local i = 1
	while i<=#rails do
		local v = rails[i]
		if v[5]<=0 then
			table.remove(rails, i)
		else
			i=i+1
			v[5]=v[5]-dt*10
		end
	end

	if player.all[1].x>12 and player.all[1].x<86 and
		player.all[1].y>60 and player.all[1].y<165 and player.all[1]:interact() then
		gstate.switch(warping)
	end


	world:update(dt) --this puts the world into motion
	food.update(dt)
	radar.update(dt)

end


function state:draw()
	map:retex()
	love.graphics.push()

	love.graphics.setBackgroundColor(60,70,80)
	love.graphics.setColor(255,255,255)

	love.graphics.translate(math.sin(love.timer.getTime()*75)*6*shake,math.cos(love.timer.getTime()*42)*6*shake)
	love.graphics.translate(320-player.all[1].x, 320-player.all[1].y)


	map:draw()

	for i,v in ipairs(weapon.all) do
		v:draw()
	end	
	food.draw()
	enemy.draw()
	love.graphics.setColor(255,255,255)
	bullet.draw()
	for i,v in ipairs(rails) do
		love.graphics.setLineWidth(0.05+v[5]*10)
		love.graphics.line(v[1],v[2],v[3],v[4])
	end
	love.graphics.setLineWidth(1)

	map:drawShadow(player.all[1].x,player.all[1].y)

	
	player.all[1]:drawShadow()

	for i,v in ipairs(player.all) do
		v:draw()
	end
	if player.all[2] and player.all[2].hp>0 then
		radar.draw()
	end

	love.graphics.pop()
	if player.all[2] and player.all[2].hp>0 then
		map:drawMap()
	end

	love.graphics.setColor(120,30,30)
	love.graphics.rectangle("fill", 0, (1-(player.all[1].hp)/100)*640, 5, ((player.all[1].hp)/100)*640)
	love.graphics.setColor(30,30,120)
	love.graphics.rectangle("fill", 635, (1-(player.all[2].hp)/100)*640, 5, ((player.all[2].hp)/100)*640)

	--love.graphics.print(love.timer.getFPS(),10,10)

end

return state