local room = {}

room.size = {160, 96}

room.exits = {}

table.insert(room.exits, exit.left(48))
table.insert(room.exits, exit.right(48))
table.insert(room.exits, exit.down(80))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  160, 8))
table.insert(room.colliders, collider.new(0, 88,  64, 96))
table.insert(room.colliders, collider.new(96, 88,  160, 96))



table.insert(room.colliders, collider.new(0, 0,  16, 32))
table.insert(room.colliders, collider.new(0, 64,  16, 96))

table.insert(room.colliders, collider.new(144, 0,  160, 32))
table.insert(room.colliders, collider.new(144, 64,  160, 96))

table.insert(room.colliders, collider.new(0, 0,  32, 16))
table.insert(room.colliders, collider.new(48, 0,  72, 16))
table.insert(room.colliders, collider.new(88, 0,  112, 16))
table.insert(room.colliders, collider.new(128, 0,  160, 16))

table.insert(room.colliders, collider.new(48, 80,  64, 96))
table.insert(room.colliders, collider.new(96, 80,  112, 96))
table.insert(room.colliders, collider.new(128, 80,  160, 96))




room.spawns = {}

table.insert(room.spawns, spawn.new(24,24,296,170))


return room