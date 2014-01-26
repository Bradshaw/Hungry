local state = gstate.new()


function state:init()

end


function state:enter()
	--wcb = {}
	world:setCallbacks(nil, nil, nil, nil)
	local j1 = player.all[1].joystick
	local j2 = player.all[2].joystick
	player.all = {}
	for i,v in ipairs(map.map) do
		--v.body:destroy()
	end
	enemy.all = {}
	map = nil
	--world:destroy()
	--world = nil



	--world = love.physics.newWorld(0, 0, false)

	--[[
	world:setCallbacks(function(...)
		for i,v in ipairs(wcb) do
			v(...)
		end
	end)
	--]]

	local bodies = world:getBodyList()
	print(#bodies.." bodies left")
	for i,v in ipairs(bodies) do
		v:destroy()
	end
	bodies = world:getBodyList()
	print(#bodies.." bodies left")

	map = level.new()
	table.insert(player.all, player.new(j1, 144, 40))
	table.insert(player.all, player.new(j2, 262, 25))
	player.all[2].main = weapon.ping()
	player.all[2].secondary = weapon.rail()
	map = level.new()

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
	gstate.switch(game)
end


function state:draw()

end

return state