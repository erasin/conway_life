
require("board")

function love.load()
	time_start = love.timer.getTime()
	board.load()	
end

function love.update(dt)
	board.update(dt)
end

function love.draw()
	board.draw()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "=" then 
		if scale < 5 then
			scale = scale + 1
		end
	end
	if key == "-" then 
		if scale > 1 then 
			scale = scale - 1
		end
	end
	if key == "q" then
		love.event.quit()
	end

	board.keypressed(key, scancode, isrepeat)
end

function love.mousereleased (x, y, button, isTouch)
	board.mousereleased(x, y, button, isTouch)
end