function updateCell(p, getNeighbor, setNeighbor)
    if (p.type == 1) then
        return updateDust(p, getNeighbor, setNeighbor)
    elseif (p.type == 2) then
        return updateWater(p, getNeighbor, setNeighbor)
    elseif (p.type == 3) then
        return updateGas(p, getNeighbor, setNeighbor)
    elseif (p.type == 4) then
        return updateWall(p, getNeighbor, setNeighbor)
    elseif (p.type == 5) then
        return updateLife(p, getNeighbor, setNeighbor)
    else
        print("unknown type")
    end
end

function updateWall(p, getNeighbor, setNeighbor)
    setNeighbor({x = 0, y = 0}, p)
end

function updateGas(p, getNeighbor, setNeighbor)
    local d = {x = math.random(-1, 1), y = math.random(-1, 1)}
    if (getNeighbor(d) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    end
end

function updateWater(p, getNeighbor, setNeighbor)
    local d = {x = math.random(-1, 1), y = 1}
    if (getNeighbor(d) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    elseif (getNeighbor({x = d.x, y = 0}) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor({x = d.x, y = 0}, p)
    end
end

function updateDust(p, getNeighbor, setNeighbor)
    local d = {x = math.random(-1, 1), y = 1}
    if (getNeighbor(d) == 0) then
        setNeighbor({x = 0, y = 0}, 0)
        setNeighbor(d, p)
    end
end

function updateLife(p, getNeighbor, setNeighbor)
    local d = {x = 0, y = 0}
    local isAlive = p.rA > 0.5

    local n = -1
    for x = -1, 1 do
        for y = -1, 1 do
            local nbr = getNeighbor({x = x, y = y})
            if (nbr ~= 0 and nbr.type == 5 and nbr.rA > 0.5) then
                n = n + 1
            end
        end
    end
    if (isAlive == false) then
        if (n == 3 or math.random(100) < 1) then
            isAlive = true
        end
    else
        if (n < 2) then
            isAlive = false
        elseif (n < 4) then
            isAlive = true
        else
            isAlive = false
        end
    end
    p.rA = isAlive and 0.9 or 0.1
    setNeighbor({x = 0, y = 0}, p)

    -- if (getNeighbor(d) == 0) then
    -- setNeighbor({x = 0, y = 0}, 0)
    -- setNeighbor(d, p)
    -- end
end
