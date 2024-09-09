@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_custom_type("Inventory", "Resource", preload("res://addons/SwiftInv/Scripts/Inventory.gd"), preload("res://addons/SwiftInv/Icons/Inventory.svg"))
	add_custom_type("InventoryContainer", "GridContainer", preload("res://addons/SwiftInv/Scripts/InventoryContainer.gd"), preload("res://addons/SwiftInv/Icons/InventoryContainer.svg"))
	add_custom_type("InventoryItem", "Resource", preload("res://addons/SwiftInv/Scripts/InventoryItem.gd"), preload("res://addons/SwiftInv/Icons/InventoryItem.svg"))
	add_custom_type("InventorySlot", "TextureRect", preload("res://addons/SwiftInv/Scripts/InventorySlot.gd"), preload("res://addons/SwiftInv/Icons/InventorySlot.svg"))
	add_custom_type("InventoryInfo", "Control", preload("res://addons/SwiftInv/Scripts/InventoryInfo.gd"), preload("res://addons/SwiftInv/Icons/InventoryInfo.svg"))


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_custom_type("Inventory")
	remove_custom_type("InventoryContainer")
	remove_custom_type("InventoryItem")
	remove_custom_type("InventorySlot")
	remove_custom_type("InventoryInfo")
