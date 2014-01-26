local state = gstate.new()


function state:init()

end


function state:enter()
	world = love.physics.newWorld(0, 0, true)
	world:setSleepingAllowed(false)

	world:setCallbacks(function(...)
		for i,v in ipairs(wcb) do
			v(...)
		end
	end)	

	needplayers = 2
	player.all = {}
	wait = 0
	timeleft = wait

	

	map = level.new()
	allJoysticks = love.joystick.getJoysticks()

end


function state:focus()

end


function state:mousepressed(x, y, btn)

end


function state:mousereleased(x, y, btn)
	
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
	if #player.all>0 then
		timeleft = timeleft-dt
	end
	if timeleft<= 0 and #player.all>=needplayers then
		gstate.switch(game)
	end
	for i, joystick in ipairs(allJoysticks) do
		local buttons = joystick:getButtonCount()
		for b=1,buttons do
			if joystick:isDown(b) then
				timeleft = wait
				table.insert(player.all, player.new(joystick))
				if #player.all==2 then
					player.all[2].main = weapon.ping()
					player.all[2].secondary = weapon.rail()
				end
				table.remove(allJoysticks, i)
			end
		end
	end
end


function state:draw()

	local joysticks = love.joystick.getJoysticks()
	love.graphics.print("Players:"..#player.all, 10, 0)
	love.graphics.print("Play in:"..math.floor(timeleft*100)/100, 10, 20)

	local l = 3
	for i, joystick in ipairs(joysticks) do
		local buttons = joystick:getButtonCount()
		for b=1,buttons do
			if joystick:isDown(b) then
				love.graphics.print(joystick:getName().." button "..b, 10, l * 20)
				l=l+1
			end
		end
	end
end

return state