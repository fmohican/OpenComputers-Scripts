local component = require'component'
local rs = component.redstone
local sides = require('sides')
local term = require("term")
local event = require("event")
local cube = component.ultimate_energy_cube

local function TurnOff()
	print("Energy level is O.K. TurnOff machines.")
	rs.setOutput(sides.back, 0)
	return true
end

local function TurnOn()
	print("Current Energy is Low. TurnOn Machines")
	rs.setOutput(sides.back, 15)
	return true
end

function toMRF(data)
	local data = data / 2.5 / 1000000
	return math.floor(data * 10^2) / 10^2
end

local function MainCheck()
	local want = cube.getMaxEnergy() / 1.2 -- Were using RAW Energy to calculate neccesare enegy
	print("Current Energy Level: ", toMRF(cube.getEnergy()))
	print("Wanted Energy Level: ", toMRF(want))
	print("Maximum Energy Level: ", toMRF(cube.getMaxEnergy()))
	if(cube.getEnergy() > want) then
		TurnOff()
		return false
	else
		TurnOn()
		return true
	end
end

local function Main()
	repeat
		term.clear()
		MainCheck()
	until event.pull(60) == "interrupted"
end

Main()
