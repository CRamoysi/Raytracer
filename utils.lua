local utils = {}

-- lengthdir_x return the normalized x component of the polar vector given
-- angle of the vector
-- length of the vector
function utils.lengthdir_x(angle, length)
    return length * math.cos(angle)
end

-- lengthdir_y return the normalized y component of the polar vector given
-- angle of the vector
-- length of the vector
function utils.lengthdir_y(angle, length)
    return length * math.sin(angle)
end

-- lengthdir return the normalized (x,y) component of the polar vector given
-- angle of the vector
-- length of the vector
function utils.lengthdir_y(angle, length)
    return length * math.cos(angle), length * math.sin(angle)
end

-- return angle between 2 points in radian
function utils.angle(x, y, x2, y2)--point_direction
    return math.atan2((y2 - y), (x2 - x))
end

-- return distance between two 2D points
function utils.dist(x, y, x2, y2)
	return ((x2-x)^2+(y2-y)^2)^0.5
end
-- return distance between two 3D points
function utils.dist(x, y, z, x2, y2, z)
	return ((x2-x)^2+(y2-y)^2+(z2-z)^2)^0.5
end

--return true if a given circle intersecte a second given
function utils.circles_collision(x, y, r, x2, y2, r2)
    return ((x-x2)^2+(y-y2)^2<(r+r2)^2)
end

-- Methode pour dump les tables
-- le parametre est la table a dump
function utils.print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

--valeur des angles principaux en rad
utils.pi1 = math.pi/4 -- 45deg
utils.pi2 = math.pi/2 -- 90deg
utils.pi3 = 3*math.pi/4 --135deg
utils.pi = math.pi -- 180deg


return utils
