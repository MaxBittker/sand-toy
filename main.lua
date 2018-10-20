Engine = require("engine")

love.graphics.setDefaultFilter("nearest")

mouse = nil
currentType = 1
function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			local s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
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
	end

	mouse = {x = math.floor(x / cell_size), y = math.floor(y / cell_size)}
end

function love.mousemoved(x, y, dx, dy)
	if mouse ~= nil then
		mouse = {x = math.floor(x / cell_size), y = math.floor(y / cell_size)}
	end
end

-- Mousereleased: Called whenever a mouse button was released,
-- passing the button and the x and y coordiante it was released at.
function love.mousereleased(x, y, button, istouch)
	-- Checks which button was pressed.
	local buttonname = ""
	mouse = nil
end

function love.keypressed(key)
	local n = tonumber(key)
	if (n ~= nil) then
		currentType = n
	end
end

-- Load a font
function love.load()
	last = "none"
	lastw = "none"
	myShader = love.graphics.newShader("shader.fs")

	-- myShader:send("width_cells", width_cells)
	-- myShader:send("height_cells", height_cells)
end
-- function update

function love.update()
	local n = 5
	if (mouse ~= nil) then
		for x = -n, n do
			for y = -n, n do
				make_particle({x = mouse.x + x, y = mouse.y + y}, currentType)
			end
		end
	end
	for x, c in ipairs(cells) do
		for y, p in ipairs(c) do
			local pos = {x = x, y = y}
			if (p ~= 0) then
				updateCell(p, neighborGetter(pos), neighborSetter(pos))
			end
		end
	end
end
imageData = love.image.newImageData(width_cells, height_cells)

function love.draw()
	love.graphics.setShader(myShader) --draw something here
	-- imageData = love.image.newImageData(width_cells, height_cells)
	image = love.graphics.newImage(imageData)

	myShader:send("tex", image)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.rectangle("fill", 0, 0, width * 10, height * 10)

	love.graphics.setShader()

	love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS() .. " GC: " .. gcinfo()), 10, 10)
end
