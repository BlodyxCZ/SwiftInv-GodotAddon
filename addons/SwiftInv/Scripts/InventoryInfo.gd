## Basic node for displaying tooltips of [InventoryItem]s. [br]
## Make sure the children nodes are offset from the origin (0, 0). ([InventoryInfo] may flicker otherwise)
class_name InventoryInfo extends Control

## Stores the currently hovered [Control] node.
var hovered:
	set(value):
		hovered = value
		if hovered is InventorySlot:
			if hovered.item:
				show()
				hovered_item = hovered.item
			else:
				hide()
		else:
			hide()

## Stores the value of the most recently hovered [InventorySlot] with [InventoryItem].
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
	hovered = get_viewport().gui_get_hovered_control()

## Use this method to assign [member hovered_item] values to other [Control] nodes.
func on_info_changed() -> void:
	pass
