Engine = require("engine")

love.graphics.setDefaultFilter("nearest")

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
	end

	last = buttonname .. " released @ (" .. x .. "x" .. y .. ")"
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
	for x, c in ipairs(cells) do
		for y, p in ipairs(c) do
			local pos = {x = x, y = y}
			if (p ~= 0) then
				updateDust(p, neighborGetter(pos), neighborSetter(pos))
			end
		end
	end
end

function love.draw()
	love.graphics.setShader(myShader) --draw something here
	imageData = love.image.newImageData(width_cells, height_cells)

	for x, c in ipairs(cells) do
		for y, p in ipairs(c) do
			-- imageData:setPixel(x - 1, y - 1, 0, 0, 0, 255)

			if (p ~= 0) then
				imageData:setPixel(x - 1, height_cells - y, p.color[1], p.color[2], p.color[3], 255)
			-- love.graphics.setColor(p.color)
			-- love.graphics.rectangle("fill", x * cell_size, y * cell_size, cell_size, cell_size)
			end
		end
	end
	image = love.graphics.newImage(imageData)
	myShader:send("tex", image)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("fill", 0, 0, width, height)

	love.graphics.setShader()

	love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS() .. " GC: " .. gcinfo()), 10, 10)
end
