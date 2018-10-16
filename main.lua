-- Example: Mouse callbacks

width, height = love.graphics.getDimensions()
cell_size = 3
width_cells = math.floor(width / cell_size)
height_cells = math.floor(height / cell_size)
particles = {}
cells = {} -- create the matrix

for i = 1, width_cells do
	cells[i] = {} -- create a new row
	for j = 1, height_cells do
		cells[i][j] = nil
	end
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
function math.clamp(val, lower, upper)
	assert(val and lower and upper, "not very useful error message here")
	if lower > upper then
		lower, upper = upper, lower
	end -- swap if boundaries supplied the wrong way
	return math.max(lower, math.min(upper, val))
end
function make_particle()
	p = {
		x = math.random(1, width_cells - 1),
		y = math.random(1, height_cells - 1),
		color = {
			math.random(50, 200),
			math.random(50, 200),
			math.random(50, 200),
			255
		}
	}
	if (cells[p.x][p.y] == nil) then
		table.insert(particles, p)
		cells[p.x][p.y] = p
	end
end

function updateDust(p)
	newx = math.clamp(p.x + math.random(-1, 1), 1, width_cells - 1)
	newy = math.clamp(p.y + math.random(-0, 1), 1, height_cells - 1)
	-- print(newx, newy)
	if (cells[newx][newy] == nil) then
		cells[p.x][p.y] = nil
		p.x = newx
		p.y = newy
		cells[p.x][p.y] = p
	end
end
-- function update
function love.update()
	for i, p in ipairs(particles) do
		updateDust(p)
	end
end
function love.draw()
	for i, p in ipairs(particles) do
		love.graphics.setColor(p.color)
		love.graphics.rectangle("fill", p.x * cell_size, p.y * cell_size, cell_size, cell_size)
		-- if (i > 1000) then
		-- break
		-- end
	end
	-- love.graphics.print("Last mouse click: " .. last, 100, 75)
	-- love.graphics.print("Last wheel move: " .. lastw, 100, 100)
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS() .. " GC: " .. gcinfo()), 10, 10)
end

for i = 0, 10000 do
	make_particle()
end
