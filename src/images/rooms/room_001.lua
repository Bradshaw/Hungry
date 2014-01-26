local room = {}

room.size = {384, 256}

room.exits = {}


table.insert(room.exits, exit.down(192))

room.colliders = {}

-- Bande haute
collider.tiles(room.colliders,
	16,16,0,
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,0,0,1,1,0,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1},
	{1,1,1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1},
	{1,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,1,1,1,0,0,1,1,0,0,1,1,1,0,0,1,1,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1},
	{1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,1},
	{1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1},
	{1,1,1,1,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,1},
	{1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
	{1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1}
	)


room.spawns = {}

table.insert(room.spawns, spawn.new(20,20,130,80))


return room