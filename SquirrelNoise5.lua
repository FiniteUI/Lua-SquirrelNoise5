require("UInt32")

SquirrelNoise5 = {}
SquirrelNoise5.__index = SquirrelNoise5
SquirrelNoise5.__name = "SquirrelNoise5"
SquirrelNoise5.BIT_NOISE_1 = UInt32:new("d2a80a3f")
SquirrelNoise5.BIT_NOISE_2 = UInt32:new("a884f197")
SquirrelNoise5.BIT_NOISE_3 = UInt32:new("6C736F4B")
SquirrelNoise5.BIT_NOISE_4 = UInt32:new("B79F3ABB")
SquirrelNoise5.BIT_NOISE_5 = UInt32:new("1b56c4f5")
SquirrelNoise5.PRIME_1 = 198491317
SquirrelNoise5.PRIME_2 = 6542989
SquirrelNoise5.MAX = UInt32.max
SquirrelNoise5.MIN = UInt32.min
SquirrelNoise5.HALF = UInt32.max // 2
SquirrelNoise5.NORMAL = 1 / UInt32.max

-- private functions
local function get2DInput(x, y)
    assert(type(x) == "number", "Error: X must be an integer.")
    assert(math.type(x) == "integer", "Error: X must be an integer.")
    assert(type(y) == "number", "Error: Y must be a integer.")
    assert(math.type(y) == "integer", "Error: Y must be an integer.")

    local input = x + y * SquirrelNoise5.PRIME_1
    return input
end

local function get3DInput(x, y, z)
    assert(type(x) == "number", "Error: X must be an integer.")
    assert(math.type(x) == "integer", "Error: X must be an integer.")
    assert(type(y) == "number", "Error: Y must be a integer.")
    assert(math.type(y) == "integer", "Error: Y must be an integer.")
    assert(type(z) == "number", "Error: Z must be a integer.")
    assert(math.type(z) == "integer", "Error: Z must be an integer.")

    local input = x + y * SquirrelNoise5.PRIME_1 + z * SquirrelNoise5.PRIME_2
    return input
end

-- instance functions
function SquirrelNoise5:new(seed)
    assert(type(seed) == "number", "Error: Seed must be an integer.")
    assert(math.type(seed) == "integer", "Error: Seed must be an integer.")

    --table for new object    
    local new = {}

    --inherit from UInt32
    setmetatable(new, self)

    new.seed = UInt32:new(seed)
    new.position = -1
    return new
end

--1D functions
function SquirrelNoise5:noise(input)
    assert(type(input) == "number", "Error: Input must be an integer.")
    assert(math.type(input) == "integer", "Error: Input must be an integer.")

    local noise = UInt32:new(input)
    noise = noise * SquirrelNoise5.BIT_NOISE_1
    noise = noise + self.seed
    noise = noise ~ (noise >> 9)
    noise = noise + SquirrelNoise5.BIT_NOISE_2
    noise = noise ~ (noise >> 11)
    noise = noise * SquirrelNoise5.BIT_NOISE_3
    noise = noise ~ (noise >> 13)
    noise = noise + SquirrelNoise5.BIT_NOISE_4
    noise = noise ~ (noise >> 15)
    noise = noise * SquirrelNoise5.BIT_NOISE_5
    noise = noise ~ (noise >> 17)

    return noise:integer()
end

function SquirrelNoise5:normalizedNoise(input)
    local noise = self:noise(input)
    noise = noise * SquirrelNoise5.NORMAL
    
    return noise
end

function SquirrelNoise5:rangeNoise(input, min, max)
    assert(type(min) == "number", "Error: Min must a number.")
    assert(type(max) == "number", "Error: Max must a number.")
    assert(min < max, "Error: Min must be less than Max.")

    local range = max - min
    local noise = range * self:normalizedNoise(input)
    noise = noise + min

    return noise
end

function SquirrelNoise5:rangeNoiseInteger(input, min, max)
    assert(type(min) == "number", "Error: Min must an integer.")
    assert(type(max) == "number", "Error: Max must an integer.")
    assert(math.type(min) == "integer", "Error: Min must an integer.")
    assert(math.type(max) == "integer", "Error: Max must an integer.")
    assert(min < max, "Error: Min must be less than Max.")

    local range = max - min
    local noise = self:noise(input) % (range + 1)
    noise = noise + min

    return noise
end

function SquirrelNoise5:noiseBoolean(input)
    local noise = self:noise(input)

    if noise <= SquirrelNoise5.HALF then
        return true
    else
        return false
    end
end

function SquirrelNoise5:noiseBooleanThreshold(input, threshold)
    assert(type(threshold) == "number", "Error: Threshold must a float.")
    assert(math.type(threshold) == "float", "Error: Threshold must a float.")
    assert(threshold > 0 and threshold < 1, "Error: Threshold must be between 0 and 1.")

    local noise = self:normalizedNoise(input)

    if noise < threshold then
        return true
    else
        return false
    end
end

--2D functions
function SquirrelNoise5:noise2D(x, y)
    local input = get2DInput(x, y)

    return self:noise(input)
end

function  SquirrelNoise5:normalizedNoise2D(x, y)
    local input = get2DInput(x, y)

    return self:normalizedNoise(input)
end

function  SquirrelNoise5:rangeNoise2D(x, y, min, max)
    local input = get2DInput(x, y)

    return self:rangeNoise(input, min, max)
end

function  SquirrelNoise5:rangeNoiseInteger2D(x, y, min, max)
    local input = get2DInput(x, y)

    return self:rangeNoiseInteger(input, min, max)
end

function  SquirrelNoise5:noiseBoolean2D(x, y)
    local input = get2DInput(x, y)

    return self:noiseBoolean(input)
end

function  SquirrelNoise5:noiseBooleanThreshold2D(x, y, threshold)
    local input = get2DInput(x, y)

    return self:noiseBooleanThreshold(input, threshold)
end

--3D functions
function SquirrelNoise5:noise3D(x, y)
    local input = get3DInput(x, y)

    return self:noise(input)
end

function  SquirrelNoise5:normalizedNoise3D(x, y, z)
    local input = get3DInput(x, y, z)

    return self:normalizedNoise(input)
end

function  SquirrelNoise5:rangeNoise3D(x, y, z, min, max)
    local input = get3DInput(x, y, z)

    return self:rangeNoise(input, min, max)
end

function  SquirrelNoise5:rangeNoiseInteger3D(x, y, z, min, max)
    local input = get3DInput(x, y, z)

    return self:rangeNoiseInteger(input, min, max)
end

function  SquirrelNoise5:noiseBoolean3D(x, y, z)
    local input = get3DInput(x, y, z)

    return self:noiseBoolean(input)
end

function  SquirrelNoise5:noiseBooleanThreshold3D(x, y, z, threshold)
    local input = get3DInput(x, y, z)

    return self:noiseBooleanThreshold(input, threshold)
end

--random functions
function SquirrelNoise5:randomInteger()
    self.position = self.position + 1

    return self:noise(self.position)
end

function SquirrelNoise5:randomIntegerRange(min, max)
    self.position = self.position + 1

    return self:rangeNoiseInteger(self.position, min, max)
end

function SquirrelNoise5:randomFloatRange(min, max)
    self.position = self.position + 1

    return self:rangeNoise(self.position, min, max)
end

function SquirrelNoise5:randomBoolean()
    self.position = self.position + 1

    return self:noiseBoolean(self.position)
end

function SquirrelNoise5:randomBooleanPercentage(chance)
    self.position = self.position + 1

    return self:noiseBooleanThreshold(self.position, chance)
end

function SquirrelNoise5:randomNormalizedFloat()
    self.position = self.position + 1

    return self:normalizedNoise(self.position)
end