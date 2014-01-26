local room = {}

room.size = {128, 320}

room.exits = {}

table.insert(room.exits, exit.up(64))
table.insert(room.exits, exit.down(64))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  32, 320))
table.insert(room.colliders, collider.new(96, 0,  128, 320))





room.spawns = {}

table.insert(room.spawns, spawn.new(32,0,96,320))


return room