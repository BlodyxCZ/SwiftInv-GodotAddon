class_name InventoryInfo extends Control


var hovered_slot:
	set(value):
		hovered_slot = value
		if hovered_slot is InventorySlot:
			if hovered_slot.item:
				show()
				hovered_item = hovered_slot.item
			else:
				hide()
		else:
			hide()

var hovered_item: InventoryItem:
	set(value):
		hovered_item = value
		on_info_changed()


func _init() -> void:
	mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE


func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	hovered_slot = get_viewport().gui_get_hovered_control()


func on_info_changed() -> void:
	pass
