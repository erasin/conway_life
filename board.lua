Life = require("life")
local tween = require 'tween'
local map = require("map")

--单元格大小
local cellSize = 10

board = {}

function board.load()
	board.state = "ready"

	board.m = math.ceil(win.width / cellSize)
	board.n = math.ceil(win.height / cellSize)
	print(board.m, board.n)

	local s = cellSize * scale

	cubeColor       = {color = {28, 163, 39, 0}, size = {s,s}, pos = {115,115}  }
	cubeColorTarget = {color = {28, 163, 39, 255}, size = {s-2,s-2}, pos = {121,121}  }
	cubeTween = tween.new(0.8,cubeColor, cubeColorTarget ,tween.easing.inBack)

	-- board.life = Life:new(board.m, board.n)
	board.life = Life(board.m, board.n)
				board.life:live(1,1)
	-- load map
	for title,ps in pairs(map) do
		local x,y = 0,0
		print("load: "..title)
		for i,p in pairs(ps) do
			if i%2 == 0 then
				y = p
				board.life:live(x,y)
			else	
				x = p
			end
		end
	end

end

function board.update(dt)
	cubeTween:update(dt)

    -- 运行状态
	if board.state == "run" then 
		local sleep_time = love.timer.getTime() - time_start
		if sleep_time > 0.1 then 
			-- print("update")
			board.life:next_gen()
			time_start = love.timer.getTime()
		end 
	end
end

function board.draw()
	board.grid()

	local bc = cubeColor.color
	local sc = cubeColor.size
	-- pos = cubeColor.pos
	love.graphics.setColor(bc[1],bc[2],bc[3],bc[4])
	-- love.graphics.rectangle("fill", pos[1] , pos[2] , sc[1], sc[2])

	local matrix = board.life.matrix 
	local s = cellSize * scale
	for i = 0, board.m do 
		for j = 0, board.n do 
			if matrix[i][j] == 1 then 
				love.graphics.rectangle("fill",  i*s+1 , j*s+1, sc[1], sc[2])
                -- create tween
                -- 追加新创建动画对象
			end 
		end
	end	

    -- tween draw
    -- 单元格对象的渲染处理    
end

--键盘事件处理
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

-- 存活处理 
function board.set_live(x,y)
	m = math.ceil(x / (cellSize * scale)) - 1
	n = math.ceil(y / (cellSize * scale)) - 1
	print("("..m..","..n..")")
	board.life:toggle(m,n)
end

function board.grid()
	local s = cellSize * scale
	local max_m = board.m * s  
	local max_n = board.n * s

	love.graphics.setColor(34, 34, 34)
	love.graphics.setLineWidth(0.5)
	love.graphics.setLineStyle("smooth")
	
	for i = 1, board.m do 
		love.graphics.line(i*s, 0, i*s , max_n)
	end
	
	for i = 1, board.n do 
		love.graphics.line(0, i*s, max_m, i*s) 
	end
	love.graphics.setColor(28, 163, 39)
end


return board
