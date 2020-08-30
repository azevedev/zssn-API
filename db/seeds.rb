puts "seeding..."

s = Survivor.new(name: "Jorge", age: "21", gender: "Male")
s.location = Location.new(latitude: 318273, longitude: 6532)
s.inventory = Inventory.new()
s.inventory.items.push(Item.new(name: "water",      value: 4, weight: 2, amount: 3))
s.inventory.items.push(Item.new(name: "food",       value: 3, weight: 3, amount: 4))
s.inventory.items.push(Item.new(name: "medication", value: 2, weight: 1, amount: 8))
s.inventory.items.push(Item.new(name: "ammunition", value: 1, weight: 4, amount: 12))
s.inventory.items.push(Item.new(name: "coin",       value: 1, weight: 0, amount: 234))
s.save

s = Survivor.new(name: "Marge", age: "32", gender: "Female")
s.location = Location.new(latitude: 452, longitude: 5452)
s.inventory = Inventory.new()
s.inventory.items.push(Item.new(name: "water",      value: 4, weight: 2, amount: 8))
s.inventory.items.push(Item.new(name: "food",       value: 3, weight: 3, amount: 3))
s.inventory.items.push(Item.new(name: "medication", value: 2, weight: 1, amount: 5))
s.inventory.items.push(Item.new(name: "ammunition", value: 1, weight: 4, amount: 14))
s.inventory.items.push(Item.new(name: "coin",       value: 1, weight: 0, amount: 521))
s.save 

s = Survivor.new(name: "Phill", age: "19", gender: "Male")
s.location = Location.new(latitude: 741823, longitude: 4521)
s.inventory = Inventory.new()
s.inventory.items.push(Item.new(name: "water",      value: 4, weight: 2, amount: 1))
s.inventory.items.push(Item.new(name: "food",       value: 3, weight: 3, amount: 2))
s.inventory.items.push(Item.new(name: "medication", value: 2, weight: 1, amount: 0))
s.inventory.items.push(Item.new(name: "ammunition", value: 1, weight: 4, amount: 2))
s.inventory.items.push(Item.new(name: "coin",       value: 1, weight: 0, amount: 0))
s.save 

s = Survivor.new(name: "Pamn", age: "24", gender: "Female")
s.location = Location.new(latitude: 86357, longitude: 153542)
s.inventory = Inventory.new()
s.inventory.items.push(Item.new(name: "water",      value: 4, weight: 2, amount: 18))
s.inventory.items.push(Item.new(name: "food",       value: 3, weight: 3, amount: 33))
s.inventory.items.push(Item.new(name: "medication", value: 2, weight: 1, amount: 15))
s.inventory.items.push(Item.new(name: "ammunition", value: 1, weight: 4, amount: 65))
s.inventory.items.push(Item.new(name: "coin",       value: 1, weight: 0, amount: 1021))
s.save 

s = Survivor.new(name: "John", age: "67", gender: "Male")
s.location = Location.new(latitude: 452, longitude: 5452)
s.inventory = Inventory.new()
s.inventory.items.push(Item.new(name: "water",      value: 4, weight: 2, amount: 3))
s.inventory.items.push(Item.new(name: "food",       value: 3, weight: 3, amount: 5))
s.inventory.items.push(Item.new(name: "medication", value: 2, weight: 1, amount: 6))
s.inventory.items.push(Item.new(name: "ammunition", value: 1, weight: 4, amount: 387))
s.inventory.items.push(Item.new(name: "coin",       value: 1, weight: 0, amount: 723))
s.save 

s = Survivor.new(name: "Matthew", age: "31", gender: "Male", infected: true, reports: 6)
s.location = Location.new(latitude: 12, longitude: 421)
s.inventory = Inventory.new()
s.inventory.items.push(Item.new(name: "water",      value: 4, weight: 2, amount: 5))
s.inventory.items.push(Item.new(name: "food",       value: 3, weight: 3, amount: 2))
s.inventory.items.push(Item.new(name: "medication", value: 2, weight: 1, amount: 12))
s.inventory.items.push(Item.new(name: "ammunition", value: 1, weight: 4, amount: 0))
s.inventory.items.push(Item.new(name: "coin",       value: 1, weight: 0, amount: 0))
s.save 

s = Survivor.new(name: "Kayle", age: "42", gender: "Female", infected: true, reports: 4)
s.location = Location.new(latitude: 6881, longitude: 42149)
s.inventory = Inventory.new()
s.inventory.items.push(Item.new(name: "water",      value: 4, weight: 2, amount: 0))
s.inventory.items.push(Item.new(name: "food",       value: 3, weight: 3, amount: 2))
s.inventory.items.push(Item.new(name: "medication", value: 2, weight: 1, amount: 33))
s.inventory.items.push(Item.new(name: "ammunition", value: 1, weight: 4, amount: 10))
s.inventory.items.push(Item.new(name: "coin",       value: 1, weight: 0, amount: 72))
s.save 


puts "seeding...ok!"
