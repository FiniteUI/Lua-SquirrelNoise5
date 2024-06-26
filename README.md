# Lua-SquirrelNoise5
This is a Lua 5.4 implementation of Squirrel Eiserloh's SquirrelNoise5 algorithm, which is a modified version of his squirrel3 algorithm presented at GDC 2017. There is also a LuaJIT implementation.

## Squirrel Noise 5
The GDC talk can be found here: https://www.youtube.com/watch?v=LWFzPP8ZbdU

The original version can be found here: http://eiserloh.net/noise/SquirrelNoise5.hpp

## Functions
This script implements the base noise function, which returns a "random" 32 bit integer based on a seed and an input, then implements several functions built off of this. There are 1d and 2d implementations of:
- A base noise function
- A noise function with a normalized (0 - 1) float
- A noise function which returns an integer in a specified range
- A noise function which returns a float in a specified range
- A noise function which returns a boolean
- A noise function which returns a boolean which returns true a specified percent of the time

There are also implementations of random functions that can return randomized values without an input. These utilize an internal counter as the input for the basic other built in noise functions. Utilizing these, random values can be generated without requiring an input, but can still be recreated if the same seed is used.
- A function which returns a random 32 bit integer
- A function which returns a random integer in a specified range
- A function which returns a random float in a specified range
- A function which returns a random boolean
- A function which returns a random boolean which returns true a specified percent of the time
- A function which returns a random normalized (0 - 1) float

## Usage
To use the library in a project, copy the [SquirrelNoise5.lua](SquirrelNoise5.lua) file into the main project directory, and require it in the main Lua script:
```lua
require("SquirrelNoise5")
```

To use the LuaJIT version, copy the [SquirrelNoise5-LuaJIT.lua](SquirrelNoise5-LuaJIT.lua) file into the project directory, and require it in the script:
```lua
require("SquirrelNoise5-LuaJIT")
```

To create a new noise generator object, use the new function:
```lua
SquirrelNoise5:new(seed)
```

Then use the desired function to generate noise or random numbers.

Due to the way Lua handles large numbers, the results will not match a different implementation of the algorithm exactly.

This script relies on my Lua UInt32 library, which can be found here: https://github.com/FiniteUI/Lua-UInt32
