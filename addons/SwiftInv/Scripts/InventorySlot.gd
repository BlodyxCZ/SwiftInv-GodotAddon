@tool @icon("res://addons/SwiftInv/Icons/InventorySlot.svg")
class_name InventorySlot extends TextureRect


@export_group("Properties")
## Size in pixels of drag preview
@export var drag_preview_size: int = 30
@export var auto_update: bool = true
@export var hover_time: float = 2.0

@export_group("Nodes")
## Displays [member InventoryItem.amount]
@export var amount_label: Label

## The Slots order in [InventoryContainer]
var index: int:
	set(value):
		pass
	get():
		return get_index()

@export_group("")
## Directly changes and displays [InventoryItem] in it's parents [Inventory] [br]
## (PS: this variables SetGet sometimes throws this error, don't bother with it XD): [br]
## [color=bf3030]   editor/editor_data.cpp:1214 - Condition "!p_node->is_inside_tree()" is true.
@export var item: InventoryItem:
	set(value):
		if get_parent() is InventoryContainer:
			get_parent().inventory.items[index] = value
	get():
		if not get_parent() is InventoryContainer: return null
		return get_parent().inventory.items[index]


## Updates [member texture_rect] and [member amount_label] [br]
## Called with [method Node._process] by if [member auto_update] is [code]true[/code]
func update_slot() -> void:
	if item:
		texture = item.texture
		if amount_label:
			if item.amount > 1:
				amount_label.text = str(item.amount)
			else:
				amount_label.text = ""
	else:
		texture = null
		if amount_label: amount_label.text = ""


func _get_drag_data(at_position: Vector2) -> Variant:
	if not item:
		printerr("Slot does not have an Item")
		return
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
	if data is not Dictionary: return false
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data["base_slot"] == self: return
	if not item or not data["base_item"].name == item.name or item.amount == item.max_stack:
		data["base_slot"].item = item
		item = data["base_item"]
	else:
		var combined = data["base_item"].amount + item.amount
		var overflow = combined - item.max_stack 
		if overflow > 0:
			data["base_item"].amount = overflow
			item.amount = item.max_stack
		else:
			data["base_slot"].item = null
			item.amount = combined
	print("saved")
	ResourceSaver.save(data["base_slot"].get_parent().inventory)
	ResourceSaver.save(get_parent().inventory)

func _get_preview() -> Control:
	var preview_texture_rect = TextureRect.new()
	
	preview_texture_rect.texture = texture
	preview_texture_rect.expand_mode = 1
	preview_texture_rect.size = Vector2(drag_preview_size, drag_preview_size)
	preview_texture_rect.position = -preview_texture_rect.size / 2
	
	var preview = Control.new()
	preview.add_child(preview_texture_rect)
	
	return preview
