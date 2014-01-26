local room = {}

room.size = {256, 512}

room.exits = {}

table.insert(room.exits, exit.left(256))
table.insert(room.exits, exit.right(256))
table.insert(room.exits, exit.up(128))
table.insert(room.exits, exit.down(128))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  32, 224))
table.insert(room.colliders, collider.new(0, 0,  96, 32))

table.insert(room.colliders, collider.new(160, 0,  256, 32))
table.insert(room.colliders, collider.new(224, 0,  256, 224))

table.insert(room.colliders, collider.new(0, 288,  32, 512)) 
table.insert(room.colliders, collider.new(0, 480,  96, 512)) 

table.insert(room.colliders, collider.new(160, 480,  256, 512))
table.insert(room.colliders, collider.new(224, 288,  256, 512))

table.insert(room.colliders, collider.new(64, 64,  96, 448))
table.insert(room.colliders, collider.new(160, 64,  192, 448))


room.spawns = {}

table.insert(room.spawns, spawn.new(16,16,224,480))


return room