local room = {}

room.size = {320, 320}

room.exits = {}

table.insert(room.exits, exit.left(160))
table.insert(room.exits, exit.down(160))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  320, 32))
table.insert(room.colliders, collider.new(288, 0,  320, 320))
table.insert(room.colliders, collider.new(0, 0,  32, 128))
table.insert(room.colliders, collider.new(0, 192,  32, 320))
table.insert(room.colliders, collider.new(0, 288,  128, 320))
table.insert(room.colliders, collider.new(192, 288,  320, 320))

table.insert(room.colliders, collider.new(128, 96,  224, 160))
table.insert(room.colliders, collider.new(192, 96,  224, 256))









room.spawns = {}

table.insert(room.spawns, spawn.new(32,32,288,288))


return room