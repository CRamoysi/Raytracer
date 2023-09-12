local Labyrinthe = {}

local utils = require("utils")
--[[






--]]


local attemptMax = 200 -- Tentative max pour inserer une room
local roomMin, roomMax = 4, 12 -- taille minimale et maximal d'une room

function Labyrinthe:new(width, height)
	

	newObj = {
		width = width,
		height = height,
		map = {}
	}
	
	if width == nil then newObj.width = 20 end
	if height == nil then newObj.height = 20 end
	
	for i=1, newObj.width do
		newObj.map[i] = {}
		for j=1, newObj.height do
--			newObj.map[i][j] = j + i*newObj.width
			newObj.map[i][j] = 1
		end
	end
	math.randomseed(os.time())
	self.__index = self
	return setmetatable(newObj, self)
end

function Labyrinthe:gen()
	local stop, stop2 = 0,0
	local roomOK, nbAttemp -- flag
	local rw, rh -- largeur, hauteur room courrante
	local prx, pry -- position de la nouvelle room (coin haut gauche)
	local nbAttempt = 0
	
	local nbRoom = 0
	
	while stop == 0 and nbAttempt < attemptMax do
		roomOK = 0	
		rw, rh = roomMin+math.random(roomMax-roomMin), roomMin+math.random(roomMax-roomMin) -- taille de la nouvelle room	
--		print("rw="..rw.." rh="..rh)
--		print("roomOK="..roomOK.." nbAttempt="..nbAttempt.." attemptMax="..attemptMax)
		while roomOK == 0 and nbAttempt < attemptMax do
			prx, pry = 1+math.random(self.width-2), 1+math.random(self.height-2)
			
--			print("rw="..rw.." rh="..rh.." prx="..prx.." pry="..pry)
			
			if prx+rw > self.width or pry+rh > self.height then -- trop proche d'un bord (du fait que le random se fait sur la taille -1 il n'y aucun risque d'etre sur les bords max) 
				nbAttempt = nbAttempt+1
			else
--			print('ici')
				-- On verifie qu'il ya la place pour mettre la nouvelle salle
				local ii, jj = -1,-1
				while ii < rw +1 and stop2 == 0 do
--					print("ii < rw+1 => "..ii.." < "..rw+1)
					jj = -1
					while jj < rh +1 and stop2 == 0 do
--						print("   jj < rh+1 => "..jj.." < "..rh+1)
						if self.map[prx+ii][pry+jj] ~= 1 then
--							print("STOP?")
							stop2 = 1
						end
						jj = jj + 1
					end
					ii = ii + 1
				end
				-- ------------------------------------
				if stop2 == 0 then -- cas où il y a la place pour mettre la nouvelle salle
--					print("OK pour placer la salle")
					roomOK = 1
					nbAttempt = 0
					nbRoom = nbRoom + 1
--					print("nbRoom="..nbRoom)
					ii, jj = 0,0
					while ii < rw +1 do
						jj = 0
						while jj < rh +1 do
							self.map[prx+ii][pry+jj] = 0
							jj = jj + 1
						end
						ii = ii + 1
					end
					
				else -- il n'y a pas la place pour mettre la salle
					nbAttempt = nbAttempt + 1
					stop2 = 0
				end -- if stop2 == 0 then
			end -- if prx == 0 or pry == 0 then
			
			 
		end -- while room == 0 and nbAttempt < attemptMax do
		if nbAttempt > attemptMax then stop = 1 end
		
	end
--	utils.print_r(self.map)	
end

function Labyrinthe:get()
	return self.map
end

function Labyrinthe:getStart()
	local ii, jj = 1,1
		
	while ii < self.width and self.map[ii][jj] == 1 do
		jj = 1
		
		while jj < self.height and self.map[ii][jj] == 1 do
			print(self.map[ii][jj])
			jj = jj + 1
		end
		ii = ii + 1
	end
	print("ii="..ii.." jj="..jj)
	if self.map[ii+1][jj+1] ~= 1 then
		return ii+1,jj+1
	end
	
end



return Labyrinthe
