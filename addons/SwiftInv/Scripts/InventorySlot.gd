@tool @icon("res://addons/SwiftInv/Icons/InventorySlot.svg")
class_name InventorySlot extends TextureRect


@export var drag_preview_size: int = 30

var index: int:
	get():
		return get_index()


func _get_drag_data(at_position: Vector2) -> Variant:
	if Engine.is_editor_hint(): return
	if get_parent() is not InventoryContainer:
		printerr("Slot parent is not InventoryContainer")
		return
	var data: Dictionary = {}
	data["base_inventory"] = get_parent().inventory
	data["base_slot"] = self
	data["base_item"] = get_parent().inventory.items[index]
	set_drag_preview(_get_preview())
	return data

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if Engine.is_editor_hint(): return false
	if data is not Dictionary: return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if Engine.is_editor_hint(): return

func _get_preview() -> Control:
	var preview_texture_rect = TextureRect.new()
	
	preview_texture_rect.texture = texture
	preview_texture_rect.expand_mode = 1
	preview_texture_rect.size = Vector2(drag_preview_size, drag_preview_size)
	preview_texture_rect.position = -preview_texture_rect.size / 2
	
	var preview = Control.new()
	preview.add_child(preview_texture_rect)
	
	return preview
