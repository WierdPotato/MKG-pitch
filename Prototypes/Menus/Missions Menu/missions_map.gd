extends Control

@export var n_paths : int

@onready var grid_manager: Node2D = $GridManager

var steps_buttons_dict : Dictionary = {}
var unchosen_buttons_dict : Dictionary = {}
var step_buttons : Array

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	randomize_path()

func randomize_path() -> void:
	var first_steps_buttons : Array = []
	get_first_step_buttons(first_steps_buttons)
	randomize_first_step(first_steps_buttons)
	generate_path(steps_buttons_dict["Step 1"])
	
func get_first_step_buttons(first_step : Array) -> void:
	while first_step.size() < grid_manager.columns: #Mientras la lista no tenga tantos elementos como columnas la cuadrícula. 
		for i in grid_manager.get_child(0).get_children(): #Por cada botón de la cuadrícula. 
			if i.my_y == 1: #Si la coordenada Y es 1. 
				first_step.append(i) #Añade el botón a la lista
			else:
				pass

func get_step_buttons(step_buttons : Array, step : int) -> void:
	while step_buttons.size() < grid_manager.columns:
		for i in grid_manager.get_child(0).get_children():
			if i.my_y == step:
				step_buttons.append(i)
			else:
				pass

func randomize_first_step(og_button_list : Array) -> void:
	var chosen_buttons : Array = []
	for i in n_paths:
		var random_button : Button = og_button_list.pick_random()
		chosen_buttons.append(random_button)
		og_button_list.erase(random_button)
		
	for n in og_button_list:
		if n in chosen_buttons:
			pass
		else:
			grid_manager.hide_cell(n)
			n.deleted = true
			
	steps_buttons_dict["Step 1"] = chosen_buttons

func generate_path(first_buttons) -> void:
	for total_steps in grid_manager.steps:
		var step : int = total_steps + 1
		var key_name : String = "Step " + str(step)
		if step == 1:
			pass
		else:
			steps_buttons_dict[key_name] = []
			unchosen_buttons_dict[key_name] = []
		
	for current_button in first_buttons:
		var prev_button : Button
		print(current_button)
		for step_iter in grid_manager.steps:
			var step : int = step_iter + 1
			var key_name : String = "Step " + str(step)
			
			if step == 1:
				prev_button = current_button
				
			else:
				var current_step_list : Array = []
				var comparator_list : Array = [prev_button.my_x - 1, prev_button.my_x, prev_button.my_x + 1]
				var final_comparator_list = process_comparator(comparator_list)
				get_step_buttons(current_step_list, step)
				var chosen_x : int = final_comparator_list.pick_random()
				
				for button in current_step_list:
					if button.my_x == chosen_x:
						if button in unchosen_buttons_dict[key_name]:
							unchosen_buttons_dict[key_name].erase(button)
						steps_buttons_dict[key_name].append(button)
						prev_button = button
						
					else:
						if button in steps_buttons_dict[key_name]:
							pass
						else:
							if button in unchosen_buttons_dict[key_name]:
								pass
							else:
								unchosen_buttons_dict[key_name].append(button)
							
	hide_final_buttons()
	process_dict()
	
func hide_final_buttons() -> void:
	for s in unchosen_buttons_dict:
		for b in unchosen_buttons_dict[s]:
			grid_manager.hide_cell(b)
		await get_tree().create_timer(0.3).timeout
func process_comparator(array : Array) -> Array:
	var final_list : Array = []
	for i in array:
		if i < 1 or i > grid_manager.columns:
			pass
		else:
			final_list.append(i)
	return final_list

func process_dict()-> void:
	for s in steps_buttons_dict:
		print(steps_buttons_dict[s])
