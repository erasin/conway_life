require("life")

local cellSize = 10

board = {}

function board.load()
	board.state = "ready"

	board.m = math.ceil(win.width / cellSize)
	board.n = math.ceil(win.height / cellSize)

	board.life = Life:new(board.m, board.n)


	board.life:live(3,2)
	board.life:live(3,3)
	board.life:live(3,4)
	board.life:live(2,4)
	board.life:live(1,3)
	-- board.life:live(3,2)
	-- board.life:live(3,3)
end

function board.update(dt)
	if board.state == "run" then 
		local sleep_time = love.timer.getTime() - time_start
		if sleep_time > 0.1 then 
			print("update")
			board.life:next_gen()
			time_start = love.timer.getTime()
		end 
	end
end

function board.draw()
	local matrix = board.life.matrix 
	local s = cellSize * scale
	for i = 0, board.m do 
		for j = 0, board.n do 
			if matrix[i][j] == 1 then 
				love.graphics.rectangle("fill",  i*s , j*s, s, s)
			end 
		end
	end	
end

function board.keypressed(key, scancode, isrepeat)
	print(key)

	if key == "space" then 
		if board.state == "ready" then
			board.state = "run"
			print("run")
		else 
			board.state = "ready"
			print("ready")
		end	
	end

end

--  鼠标处理
function board.mousereleased (x, y, button, isTouch)
	if board.state == "ready" then
		if button == 1 then 
			board.set_live(x,y)
		end
	end
	
	if button == 2 then
		if board.state == "ready" then
			board.state = "run"
		else 
			board.state = "ready"
		end
	end
end

function board.set_live(x,y)
	m = math.ceil(x / (cellSize * scale)) - 1
	n = math.ceil(y / (cellSize * scale)) - 1
	print("m n", m,n)
	board.life:live(m,n)
end
