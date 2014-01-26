exit = {}
collider = {}

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

