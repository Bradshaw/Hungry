exit = {}
collider = {}
spawn = {}

function spawn.new(x1, y1, x2, y2)
	return {
		x1= x1,
		y1= y1,
		x2= x2,
		y2= y2
	}
end

function exit.left( h )
	return {
		t = "left",
		c = h
	}
end

function exit.right( h )
	return {
		t = "right",
		c = h
	}
end

function exit.up( h )
	return {
		t = "up",
		c = h
	}
end

function exit.down( h )
	return {
		t = "down",
		c = h
	}
end

function collider.new(x1, y1, x2, y2)
	return {
		x= x1,
		y= y1,
		w= (x2-x1),
		h= (y2-y1)
	}
end

function collider.tiles(colliderbox, tx, ty, line, tilerow, ...)
	if tilerow then
		for i,v in ipairs(tilerow) do
			if v~=0 then
				table.insert(colliderbox, collider.new(tx*i-tx, ty*line, tx*i, ty*line+ty))
			end
		end
		collider.tiles(colliderbox, tx, ty, line+1, ...)
	end
end

