local Player = {}





function Player:new(x, y, direction)
	

	newObj = {
		x = x,
		y = y,
		direction = direction	
	}
	
	self.__index = self
	return setmetatable(newObj, self)
end





return Player
