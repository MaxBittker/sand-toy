function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

width, height = love.graphics.getDimensions()

cell_size = 2
width_cells = math.floor(width / cell_size)
height_cells = math.floor(height / cell_size)
cells = {} -- create the matrix

function math.clamp(val, lower, upper)
	assert(val and lower and upper, "not very useful error message here")
	if lower > upper then
		lower, upper = upper, lower
	end -- swap if boundaries supplied the wrong way
	return math.max(lower, math.min(upper, val))
end

function make_particle(pos)
	local p = {
		type = 0,
		rA = 0,
		rB = 0,
		color = {
			math.random(50, 200),
			math.random(50, 100),
			math.random(50, 200),
			255
		}
	}
	if (cells[pos.x][pos.y] == 0) then
		cells[pos.x][pos.y] = p
	end
end

function neighborGetter(pos)
	return function(offset)
		local oX = math.clamp(offset.x, -1, 1)
		local oY = math.clamp(offset.y, -1, 1)
		local rX = pos.x + oX
		local rY = pos.y + oY
		if (rX < 1 or rX > width_cells or rY < 1 or rY > height_cells) then
			return nil
		end
		return cells[rX][rY]
	end
end
function neighborSetter(pos)
	return function(offset, v)
		local oX = math.clamp(offset.x, -1, 1)
		local oY = math.clamp(offset.y, -1, 1)
		local rX = pos.x + oX
		local rY = pos.y + oY
		if (rX < 1 or rX > width_cells or rY < 1 or rY > height_cells) then
			print("oob set")
			return nil
		end

		cells[rX][rY] = v
	end
end

function updateDust(p, getNeighbor, setNeighbor)
	local n = 0
	for x = -1, 1 do
		for y = -1, 1 do
			if (getNeighbor({x = x, y = y}) ~= 0) then
				n = n + 1
			end
		end
	end
	-- print(n)
	if (n < 1) then
		p.type = 0
		setNeighbor({x = 0, y = 0}, 0)
	elseif (n > 2) then
		setNeighbor({x = 0, y = 0}, 0)
	else
		local d = {x = math.random(-1, 1), y = math.random(-1, 1)}
		setNeighbor(d, p)
	end
	-- if (getNeighbor(d) == 0) then
	-- setNeighbor({x = 0, y = 0}, 0)
	-- setNeighbor(d, p)
	-- end
end

-- function updateDust(p, getNeighbor, setNeighbor)
-- 	local d = {x = math.random(-1, 1), y = math.random(0, 1)}
-- 	if (getNeighbor(d) == 0) then
-- 		setNeighbor({x = 0, y = 0}, 0)
-- 		setNeighbor(d, p)
-- 	end
-- end
for i = 1, width_cells do
	cells[i] = {} -- create a new row
	for j = 1, height_cells do
		cells[i][j] = 0
		-- make_particle({x = i, y = j})
	end
end
for i = 0, 10000 do
	local pos = {
		x = math.random(1, width_cells - 1),
		y = math.random(1, height_cells - 1)
	}
	make_particle(pos)
end
