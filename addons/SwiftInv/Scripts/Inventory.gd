## Basic [Inventory] resource.
@tool @icon("res://addons/SwiftInv/Icons/Inventory.svg")
class_name Inventory extends Resource


## Manualy changing [member items] size automaticaly adds [InventorySlot]s to the scene tree.
@export var items: Array[InventoryItem] = []:
	set(value):
		items = value
		changed.emit()

## Stores an [InventoryItem] in the first empty slot. [br]
## Returs [constant FAILED] if item couldn't be added and [constant ok] otherwise.
func add_item(item: InventoryItem) -> Error:
	if is_full():
		return FAILED
	add_item_to(item, _get_first_empty())
	return OK

## Stores an [InventoryItem] at the specified index. [br]
## Returs [constant FAILED] if item couldn't be added and [constant ok] otherwise.
func add_item_to(item: InventoryItem, index: int) -> Error:
	if not is_slot_empty(index):
		return FAILED
	items[index] = item
	return OK

## Returns an [InventoryItem] at the specified index. [br]
## Returs [code]null[/code] if item isn't found.
func get_item_by_index(index: int) -> InventoryItem:
	if not is_slot_empty(index):
		return items[index]
	else:
		printerr("No item with index %s found" % index)
		return null

## Moves an [InventoryItem] from a position to another. [br]
## Automaticaly swaps [InventoryItem]s if both from and to indexes have an [InventoryItem]. [br]
## Returs [constant FAILED] if items couldn't be moved and [constant ok] otherwise.
func move_from_to(from: int, to: int) -> Error:
	if is_slot_empty(from):
		return FAILED
	elif is_slot_empty(to):
		items[to] = items[from]
	else:
		var tmp: InventoryItem = items[to]
		items[to] = items[from]
		items[from] = tmp
	return OK


## Removes an [InventoryItem] from the inventory at the specified index. [br]
## Returs [constant FAILED] if item isn't found and [constant OK] otherwise.
func remove_by_index(index: int) -> Error:
	if is_slot_empty(index):
		printerr("No item found")
		return FAILED
	else:
		items[index]
		return OK

## Returns [code]true[/code] if inventory is full.
func is_full() -> bool:
	if _get_first_empty() == -1:
		return true
	else:
		return false


func _get_first_empty(from: int = 0) -> int:
	# check each slot
	for item in items:
		# if item exists
		if item:
			return from
		else:
			from += 1
	if items.size() - 1 > from:
		printerr("Invalid Inventory Index")
	else:
		printerr("Inventory is full")
	return -1

## Returns [code]true[/code] if there is no [InventoryItem] at index.
func is_slot_empty(index: int) -> bool:
	if items[index]:
		return false
	else:
		return true

## Returns [code]true[/code] if has spcified [InventoryItem].
func has_item(item: InventoryItem) -> bool:
	return items.has(item)

## Call to manualy save the resource as autosaving is not always perfect.
func save() -> void:
	ResourceSaver.save(self)
