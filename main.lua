-- Example: Mouse callbacks
width = love.graphics.getWidth()

function love.load()
	love.graphics.setFont(love.graphics.newFont(11))
end

-- Mousepressed: Called whenever a mouse button was pressed,
-- passing the button and the x and y coordiante it was pressed at.
function love.mousepressed(x, y, button, istouch)
	-- Checks which button was pressed.
	local buttonname = ""
	if button == 1 then
		buttonname = "left"
	elseif button == 2 then
		buttonname = "right"
	elseif button == 3 then
		buttonname = "middle"
	else
		-- Some mice can have more buttons
		buttonname = "button" .. button
	end

	last = buttonname .. " pressed @ (" .. x .. "x" .. y .. ")"
end

-- Mousereleased: Called whenever a mouse button was released,
-- passing the button and the x and y coordiante it was released at.
function love.mousereleased(x, y, button, istouch)
	-- Checks which button was pressed.
	local buttonname = ""
	if button == 1 then
		buttonname = "left"
	elseif button == 2 then
		buttonname = "right"
	elseif button == 3 then
		buttonname = "middle"
	else
		-- Some mice can have more buttons
		buttonname = "button" .. button
	end

	last = buttonname .. " released @ (" .. x .. "x" .. y .. ")"
end

-- Load a font
function love.load()
	last = "none"
	lastw = "none"
end

-- Output the last mouse button which was pressed/released.
function love.draw()
	width = love.graphics.getWidth()
	cell_size = 5
	width_cells = width / cell_size
	for i = 1, width_cells * 500 do
		love.graphics.setColor(math.random(0, 100), math.random(0, 100), math.random(0, 100), 255)
		love.graphics.rectangle(
			"fill",
			(i % width_cells) * cell_size,
			(math.floor(i / width_cells) + math.random(0, 10)) * cell_size,
			cell_size,
			cell_size
		)
	end
	-- love.graphics.print("Last mouse click: " .. last, 100, 75)
	-- love.graphics.print("Last wheel move: " .. lastw, 100, 100)
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
