local room = {}

room.size = {320, 128}

room.exits = {}

table.insert(room.exits, exit.left(64))
table.insert(room.exits, exit.right(64))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  320, 32))
table.insert(room.colliders, collider.new(0, 96,  320, 128))





room.spawns = {}

table.insert(room.spawns, spawn.new(0,32,320,96))


return room