Types = require("types")

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
function add(a, b)
	return {x = a.x + b.x, y = a.y + b.y}
end

function math.clamp(val, lower, upper)
	assert(val and lower and upper, "not very useful error message here")
	if lower > upper then
		lower, upper = upper, lower
	end -- swap if boundaries supplied the wrong way
	return math.max(lower, math.min(upper, val))
end

width, height = love.graphics.getDimensions()
cell_size = 2
width_cells = math.floor(width / cell_size)
height_cells = math.floor(height / cell_size)
cells = {} -- create the matrix

function make_particle(pos, type)
	local p = {
		type = type,
		rA = 0.5 + math.random() * 0.1,
		rB = 0
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
		if (rX < 1 or rX >= width_cells + 1 or rY < 1 or rY >= height_cells) then
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
		if (rX < 1 or rX >= width_cells + 1 or rY < 1 or rY >= height_cells) then
			print("oob set")
			return nil
		end

		cells[rX][rY] = v
		if (v ~= 0) then
			imageData:setPixel(rX - 1, rY - 1, v.type / 10., v.rA, v.rB, 1)
		else
			imageData:setPixel(rX - 1, rY - 1, 0, 0, 0, 1)
		end
	end
end

for i = 1, width_cells do
	cells[i] = {} -- create a new row
	for j = 1, height_cells do
		cells[i][j] = 0
		-- make_particle({x = i, y = j})
	end
end

for i = 0, 10000 do
	local pos = {
		x = math.random(1, width_cells),
		y = math.random(1, height_cells - 1)
	}
	make_particle(pos, 1)
end
