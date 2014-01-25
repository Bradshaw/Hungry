local room = {}

room.exits = {}

table.insert(room.exits, exit.left(48))
table.insert(room.exits, exit.right(48))

room.colliders = {}

-- Bande haute
table.insert(room.colliders, collider.new(0, 0,  150, 6))
--Bande basse
table.insert(room.colliders, collider.new(0, 92,  150, 100))


table.insert(room.colliders, collider.new(0, 0,  19, 26))
table.insert(room.colliders, collider.new(0, 72,  19, 100))

table.insert(room.colliders, collider.new(47, 0,  60, 26))
table.insert(room.colliders, collider.new(47, 72,  60, 100))

table.insert(room.colliders, collider.new(87, 0,  102, 26))
table.insert(room.colliders, collider.new(87, 72,  102, 100))

table.insert(room.colliders, collider.new(129, 0,  150, 26))
table.insert(room.colliders, collider.new(129, 72,  150, 100))


return room