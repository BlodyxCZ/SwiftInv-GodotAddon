extends InventoryInfo


func on_info_changed() -> void:
	$Name.text = hovered_item.name
	$Desc.text = hovered_item.description
