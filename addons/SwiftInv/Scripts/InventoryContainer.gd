## Basic container for [InventorySlot]s.
@tool @icon("res://addons/SwiftInv/Icons/InventoryContainer.svg")
class_name InventoryContainer extends GridContainer

## The nodes [Inventory] resource.
@export var inventory: Inventory:
	set(value):
		inventory = value
		inventory.changed.connect(_on_inventory_changed)

## Defines what scene will be instantiated when changing [member Inventory.size].
@export var slot_scene: PackedScene


func _process(delta: float) -> void:
	for slot: InventorySlot in get_children():
		if slot.auto_update: slot.update_slot()


func _on_inventory_changed() -> void:
	if not slot_scene:
		printerr("No slot scene defined")
		return
	for slot: InventorySlot in get_children():
		remove_child(slot)
	for i in range(inventory.items.size()):
		var slot: InventorySlot = slot_scene.instantiate()
		slot.name = "Slot0"
		add_child(slot, true)
		slot.owner = owner
		slot.slot_changed.connect(inventory.save)
		if not Engine.is_editor_hint() and inventory.items[i]:
			inventory.items[i] = inventory.items[i].instantiate()
	ResourceSaver.save(inventory)

func _enter_tree() -> void:
	_on_inventory_changed()
