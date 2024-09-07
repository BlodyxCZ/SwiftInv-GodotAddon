@tool @icon("res://addons/SwiftInv/Icons/InventoryContainer.svg")
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
	for slot: InventorySlot in get_children():
		remove_child(slot)
	for i in range(inventory.items.size()):
		var slot: InventorySlot = slot_scene.instantiate()
		slot.owner = self
		slot.name = "Slot0"
		add_child(slot, true)
