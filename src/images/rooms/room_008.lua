local room = {}

room.size = {64, 160}

room.exits = {}

table.insert(room.exits, exit.up(32))
table.insert(room.exits, exit.down(32))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  16, 160))
table.insert(room.colliders, collider.new(48, 0,  64, 160))





room.spawns = {}

table.insert(room.spawns, spawn.new(16,0,48,160))


return room