@tool @icon("res://addons/SwiftInv/Icons/InventoryContainer.svg")
class_name InventoryContainer extends GridContainer


@export var autosafe: bool = true

@export var slot_scene: PackedScene

@export var inventory: Inventory:
	set(value):
		inventory = value
		inventory.changed.connect(_on_inventory_changed)


func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	if autosafe: ResourceSaver.save(inventory)


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


func _enter_tree() -> void:
	_on_inventory_changed()
