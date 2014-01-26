local room = {}

room.size = {100, 100}

room.exits = {}

table.insert(room.exits, exit.left(50))
table.insert(room.exits, exit.right(50))
table.insert(room.exits, exit.up(50))
table.insert(room.exits, exit.down(50))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  32, 32))
table.insert(room.colliders, collider.new(68, 0,  100, 32))
table.insert(room.colliders, collider.new(0, 68,  32, 100))
table.insert(room.colliders, collider.new(68, 68,  100, 100))


room.spawns = {}

table.insert(room.spawns, spawn.new(20,20,80,80))


return room