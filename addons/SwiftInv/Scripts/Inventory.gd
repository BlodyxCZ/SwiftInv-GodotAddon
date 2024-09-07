@tool @icon("res://addons/SwiftInv/Icons/Inventory.svg")
class_name Inventory extends Resource


@export var items: Array[InventoryItem] = []:
	set(value):
		items = value
		changed.emit()

func add_item(item: InventoryItem) -> Error:
	if is_full():
		return FAILED
	add_item_to(item, get_first_empty())
	return OK


func add_item_to(item: InventoryItem, index: int) -> Error:
	if not is_slot_empty(index):
		return FAILED
	items[index] = item
	return OK


func get_item_by_index(index: int) -> InventoryItem:
	if not is_slot_empty(index):
		return items[index]
	else:
		printerr("No item with index %s found" % index)
		return null


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


func remove_by_index(index: int) -> Error:
	if is_slot_empty(index):
		printerr("No item found")
		return FAILED
	else:
		items[index]
		return OK


func is_full() -> bool:
	if get_first_empty() == -1:
		return true
	else:
		return false


func get_first_empty(from: int = 0) -> int:
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


func is_slot_empty(index: int) -> bool:
	if items[index]:
		return false
	else:
		return true


func has_item(item: InventoryItem) -> bool:
	for _item in items:
		if _item == item:
			return true
	return false
