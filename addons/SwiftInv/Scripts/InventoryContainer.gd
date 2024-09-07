@tool
class_name InventoryContainer extends GridContainer


@export var slot_scene: PackedScene

@export var inventory: Inventory:
	set(value):
		inventory = value
		inventory.changed.connect(_on_inventory_changed)


func _on_inventory_changed() -> void:
	
	if not slot_scene:
		printerr("No slot scene defined")
		return
