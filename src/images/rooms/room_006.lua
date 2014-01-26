local room = {}

room.size = {320, 192}

room.exits = {}

table.insert(room.exits, exit.left(96))
table.insert(room.exits, exit.right(96))
table.insert(room.exits, exit.down(160))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  320, 16))
table.insert(room.colliders, collider.new(0, 176,  128, 192))
table.insert(room.colliders, collider.new(192, 176,  320, 192))



table.insert(room.colliders, collider.new(0, 0,  32, 64))
table.insert(room.colliders, collider.new(0, 128,  32, 192))

table.insert(room.colliders, collider.new(288, 0,  320, 64))
table.insert(room.colliders, collider.new(288, 128,  320, 192))

table.insert(room.colliders, collider.new(0, 0,  64, 32))
table.insert(room.colliders, collider.new(96, 0,  144, 32))
table.insert(room.colliders, collider.new(176, 0,  224, 32))
table.insert(room.colliders, collider.new(256, 0,  320, 32))

table.insert(room.colliders, collider.new(96, 160,  128, 188))
table.insert(room.colliders, collider.new(192, 160,  224, 188))
table.insert(room.colliders, collider.new(256, 160,  320, 188))




room.spawns = {}

table.insert(room.spawns, spawn.new(24,24,296,170))


return room