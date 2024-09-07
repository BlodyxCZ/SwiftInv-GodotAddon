@icon("res://addons/SwiftInv/Icons/InventoryItem.svg")
class_name InventoryItem extends Resource


@export_group("Properties")
## Name is used to determine if [InventoryItem]s should stack or not on pickup
@export var name: String = ""
## Can be seen in [ItemInfo] [br]
## (for shops, you can display item price here)
@export var description: String = ""
## Texture for [InventorySlot]
@export var texture: Texture2D = null
@export_group("Count")
## The amount of [InventoryItem] in [Inventory]
@export var amount: int = 1
## Set to [code]1[/code] to make [InventoryItem] instackable
@export var max_stack: int = 24


## Returns new copy of [InventoryItem] with same properties [br]
## (solves lots of duplicacy issues)
func instantiate() -> InventoryItem:
	var i = InventoryItem.new()
	i.name = name
	i.description = description
	i.texture = texture
	i.amount = amount
	i.max_stack = max_stack
	return i