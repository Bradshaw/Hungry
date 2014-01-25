local weapon_mt = {}
weapon = {}

weapon.all = {}

function weapon.new()
	local self = setmetatable({},{__index = weapon_mt})	

	self.rot = math.random()*math.pi*2
	self.cooldown = 0.1
	self.time = 0

	return self
end

function weapon.pistol( ... )
	local self = weapon.new( ... )

	self.fire = function(weap, x, y, dx, dy)
		if weap.time==0 then
			shake=shake+0.1
			weap.time = weap.cooldown
			bullet.pistol(x, y, dx*1200, dy*1200)
		end
	end

	return self
end

function weapon.ping( ... )
	local self = weapon.new( ... )

	self.cooldown = 2
	self.fire = function(weap, x, y)
		if weap.time==0 then
			weap.time = weap.cooldown
			radar.ping(x, y)
		end
		
	end
	return self
end

rails = {}

function weapon.rail( ... )
	local self = weapon.new( ... )
	self.cooldown = 0.5
	self.fire =  function(weap, x, y, dx, dy)
		if weap.time==0 then
			shake = shake + 0.5
			weap.time = weap.cooldown
			local xh = x+dx*1000
			local yh = y+dy*1000
			local hits={{xh,yh}}
			world:rayCast( x, y, xh, yh, function(fix, xc, yc, xn, yn, frac)
				local u = fix:getUserData()
				if u and u.isAWall then
					table.insert(hits,{xc,yc})
					return -1
				end
				return -1
			end )
			hit = hits[1]
			for i,v in ipairs(hits) do
				if math.abs(v[1]-x)<math.abs(hit[1]-x) or math.abs(v[2]-y)<math.abs(hit[2]-y) then
					hit = v
				end
			end

			local perpx = dy/3
			local perpy = -dx/3
			for i=-5,5 do
				world:rayCast( x+perpx, y+perpy, hit[1]+perpx, hit[2]+perpy, function(fix, xc, yc, xn, yn, frac)
					local u = fix:getUserData()
					if u and u.hp then
						u.hp = u.hp-10
					end
					return -1
				end )	
			end
			table.insert(rails,{x, y, hit[1], hit[2], 1})
		end
	end
	return self
end


function weapon_mt:fire(x,y,dx,dy)
	
end

function weapon_mt:updateOnFloor(dt)
	
end

function weapon_mt:drawOnFloor()
	
end


function weapon_mt:updateOnCharacter(dt)
	self.time = math.max(0,self.time-dt)
end

function weapon_mt:drawOnCharacter(character)
	
end
