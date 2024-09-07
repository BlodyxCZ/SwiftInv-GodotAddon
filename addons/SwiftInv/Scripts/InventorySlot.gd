@tool
class_name InventorySlot extends TextureRect


func _get_drag_data(at_position: Vector2) -> Variant:
	if Engine.is_editor_hint(): return
	if get_parent() is not InventoryContainer:
		printerr("Slot parent is not InventoryContainer")
		return
	var data: Dictionary = {}
	data["base_inventory"] = get_parent().inventory
	data["base_slot"] = self
	data["base_item"]
	return data


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if Engine.is_editor_hint(): return false
	if data is not Dictionary: return false
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if Engine.is_editor_hint(): return
	pass
