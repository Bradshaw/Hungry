function love.load(arg)

	math.randomseed(os.time())
	wcb = {}
	function addPhysCallback(f)
		table.insert(wcb, f)
	end

	require("useful")
	require("levelgen")
	require("radar")
	require("player")
	require("weapon")
	require("bullet")
	require("enemy")
	require("level")


	love.physics.setMeter(64)


	shake = 0

	gstate = require "gamestate"
	lobby = require("lobby")
	game = require("game")
	gstate.switch(lobby)
end


function love.focus(f)
	gstate.focus(f)
end

function love.mousepressed(x, y, btn)
	gstate.mousepressed(x, y, btn)
end

function love.mousereleased(x, y, btn)
	gstate.mousereleased(x, y, btn)
end

function love.joystickpressed(joystick, button)
	gstate.joystickpressed(joystick, button)
end

function love.joystickreleased(joystick, button)
	gstate.joystickreleased(joystick, button)
end

function love.quit()
	gstate.quit()
end

function love.keypressed(key, uni)
	gstate.keypressed(key, uni)
end

function keyreleased(key, uni)
	gstate.keyreleased(key)
end

function love.update(dt)
	gstate.update(dt)
end

function love.draw()
	gstate.draw()
end
