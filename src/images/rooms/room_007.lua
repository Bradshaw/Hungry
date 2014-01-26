local room = {}

room.size = {160, 64}

room.exits = {}

table.insert(room.exits, exit.left(32))
table.insert(room.exits, exit.right(32))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  160, 16))
table.insert(room.colliders, collider.new(0, 48,  160, 64))





room.spawns = {}

table.insert(room.spawns, spawn.new(0,16,160,48))


return room