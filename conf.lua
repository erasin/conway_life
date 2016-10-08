
scale = 1
win = { width = 600, height = 600 }

function love.conf (w)
	w.title  = "conway life"
	-- w.version = "0.10.1"

	w.window.width = win.width * scale
	w.window.height = win.height * scale
	w.window.fullscreen = false
	w.window.vsync = true
end