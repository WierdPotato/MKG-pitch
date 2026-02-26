extends Control

@onready var parts_list: Control = $PartsList

@onready var all_button: TextureButton = $Tabs/All/AllButton
@onready var bodies_button: TextureButton = $Tabs/Bodies/BodiesButton
@onready var engines_button: TextureButton = $Tabs/Engines/EnginesButton
@onready var shields_button: TextureButton = $Tabs/Shields/ShieldsButton
@onready var cargo_button: TextureButton = $Tabs/Cargo/CargoButton


@onready var all_tabs : Array = [all_button, bodies_button, engines_button, shields_button, cargo_button]

var tab_id : int

func _on_all_button_pressed() -> void:
	parts_list.current_filter.clear() 
	parts_list.current_filter = STORE.store_list.duplicate()
	parts_list.update_filtered()
	tab_id = 0
	
func _on_bodies_button_pressed() -> void:
	var list : Array
	for i in STORE.store_list:
		if i.get("Type") == "bdy":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()
	tab_id = 1

func _on_engines_button_pressed() -> void:
	var list : Array
	for i in STORE.store_list:
		if i.get("Type") == "eng":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()
	tab_id = 2


func _on_shields_button_pressed() -> void:
	var list : Array
	for i in STORE.store_list:
		if i.get("Type") == "sld":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()
	tab_id = 3

func _on_cargo_button_pressed() -> void:
	var list : Array
	for i in STORE.store_list:
		if i.get("Type") == "crg":
			list.append(i)
			
	parts_list.current_filter.clear() 
	parts_list.current_filter = list
	parts_list.update_filtered()
	tab_id = 4

func _on_background_pressed() -> void:
	pass # Replace with function body.

func process_tabs(next : bool) -> void:
	if next:
		if tab_id == 4:
			tab_id = 0
		else:
			tab_id += 1
	else:
		if tab_id == 0:
			tab_id = 4
		else:
			tab_id -= 1
	
	#print(all_tabs.get(tab_id))
	all_tabs.get(tab_id).grab_focus()
	all_tabs.get(tab_id).emit_signal("pressed")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("NextTab"):
		process_tabs(true)
		
	elif Input.is_action_just_released("PrevTab"):
		process_tabs(false)

	elif Input.is_action_just_released("ListDown"):
		parts_list._on_list_down_pressed()
	
	elif Input.is_action_just_released("ListUp"):
		parts_list._on_list_up_pressed()
