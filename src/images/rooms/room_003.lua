local room = {}

room.size = {256,256}

room.exits = {}

table.insert(room.exits, exit.left(128))
table.insert(room.exits, exit.right(128))
table.insert(room.exits, exit.up(128))
table.insert(room.exits, exit.down(128))

room.colliders = {}


table.insert(room.colliders, collider.new(0,0,96,64))
table.insert(room.colliders, collider.new(0,0,64,96))

table.insert(room.colliders, collider.new(160,0,256,64))
table.insert(room.colliders, collider.new(192,0,256,96))

table.insert(room.colliders, collider.new(0,160,64,256))
table.insert(room.colliders, collider.new(0,192,92,256))

table.insert(room.colliders, collider.new(192,160,256,256))
table.insert(room.colliders, collider.new(160,192,256,256))

room.spawns = {}

table.insert(room.spawns, spawn.new(64,64, 192, 192))


return room