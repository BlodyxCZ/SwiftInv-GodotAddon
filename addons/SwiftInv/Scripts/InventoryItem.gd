## Basic [InventoryItem] resource for [Inventory].
@icon("res://addons/SwiftInv/Icons/InventoryItem.svg")
class_name InventoryItem extends Resource


@export_group("Properties")
## Name is used to determine whether [InventoryItem]s should stack or not. [br]
## If you make more [InventoryItem]s with the same name,
## make sure they have the same [member max_stack] value.
@export var name: String = ""
## Text describing your item.
@export var description: String = ""
## The node's [Texture2D] resource.
@export var texture: Texture2D = null
@export_group("Count")
## The amount of [InventoryItem] in [Inventory].
@export var amount: int = 1
## Maximum number of items allowed in a stack. [br]
## Set to [code]1[/code] to make [InventoryItem] unstackable. [br]
## Beware of wololo... (see [member name] for more details)
@export var max_stack: int = 24


## Returns new copy of [InventoryItem] with same properties. [br]
## (solves lots of duplicacy and [ResourceSaver] issues)
func instantiate() -> InventoryItem:
	var i = InventoryItem.new()
	i.name = name
	i.description = description
	i.texture = texture
	i.amount = amount
	i.max_stack = max_stack
	return i
