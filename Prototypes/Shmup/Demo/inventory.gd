extends Control
@onready var parts_list: Control = $PartsList



func _on_all_button_pressed() -> void:
	parts_list.current_filter.clear() 
	parts_list.current_filter = PREP.full_inventory.duplicate()
	parts_list.update_filtered()
	
func _on_bodies_button_pressed() -> void:
	var list : Array
	for i in PREP.full_inventory:
		if i.get("Type") == "bdy":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()


func _on_engines_button_pressed() -> void:
	var list : Array
	for i in PREP.full_inventory:
		if i.get("Type") == "eng":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()


func _on_shields_button_pressed() -> void:
	var list : Array
	for i in PREP.full_inventory:
		if i.get("Type") == "sld":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()


func _on_cargo_button_pressed() -> void:
	var list : Array
	for i in PREP.full_inventory:
		if i.get("Type") == "crg":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()
