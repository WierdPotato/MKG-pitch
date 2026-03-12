extends Node2D

@onready var pause_menu: Control = $PauseMenu


@onready var paths_manager: Node2D = $PathsManager

@onready var lvl_1a: Button = $PathsManager/PathA/Buttons/Lvl1a
@onready var lvl_2a: Button = $PathsManager/PathA/Buttons/Lvl2a
@onready var lvl_1b: Button = $PathsManager/PathB/Buttons/Lvl1b
@onready var lvl_2b: Button = $PathsManager/PathB/Buttons/Lvl2b
@onready var lvl_3: Button = $PathsManager/Final/Boss/Lvl3

@onready var bg_planet: Sprite2D = $Statics/Planet

@onready var mission_details: Control = $MissionDetails

@onready var back: TextureButton = $Menus/Back/Back
@onready var go: TextureButton = $Menus/Go/Go

@onready var all_planet_buttons : Array = [lvl_1a, lvl_1b, lvl_2a,lvl_2b, lvl_3]

var current_selected_button

var selected_planet : Dictionary #Almacena la información del planeta seleccionado
var current_planet_ref : String #Almacena el planeta donde se encuentra el jugador
var current_button : Button


func _ready() -> void:
	prepare_planet_buttons()

func get_current_planet()->void:
	for i in all_planet_buttons:
		if i.my_info.get("my_name") == current_planet_ref:
			current_button = i
		else:
			pass
	if current_button == null:
		print("Current button ref error:")
		print("Ref: ", current_planet_ref)
	else:
		print("Current button positive: ", current_button)

func prepare_planet_buttons()->void:
	lvl_1a.set_info("lvl_1a", 1, 1)
	lvl_1b.set_info("lvl_1b", 1, 2)
	lvl_2a.set_info("lvl_2a", 2, 1)
	lvl_2b.set_info("lvl_2b", 2, 2)
	lvl_3.set_info("lvl_3", 3, 0)
	manage_ready()

func assign_planets() -> void:
	var all_planets_info : Array = PLANETS.planets.duplicate()
	for i in all_planet_buttons:
		var pick : Dictionary = all_planets_info.pick_random()
		i.set_planet(pick)
		all_planets_info.erase(pick)

func manage_ready() -> void:
	manage_progress()
	if GLOBAL.current_step == 0:
		assign_planets()
		selected_planet = lvl_1a.my_planet
		current_planet_ref = "lvl_1a"
		current_button = lvl_1a
		bg_planet.texture = lvl_1a.my_planet.get("background")
	
		debug_progress_sim()
	else:
		for i in all_planet_buttons:
			i.find_my_planet()
		current_planet_ref = GLOBAL.map_button_ref
		get_current_planet()
		update_screen_info(current_button)
		current_button.grab_focus()
		

func update_screen_info(planet:Button) -> void:
	bg_planet.texture = planet.my_planet.get("background")
	pass

func manage_progress()->void: #Bloquea o desbloquea las misiones
	if GLOBAL.current_step == 1: #Si es la primera fase
		var lock_list :Array = [lvl_2a, lvl_2b, lvl_3]#Bloquea las demás fases
		var unlock_list : Array = [lvl_1a, lvl_1b] #Y desbloquea las dos misiones de la primera fase
		paths_manager.lock_missions(lock_list)
		paths_manager.unlock_missions(unlock_list)
		
	elif GLOBAL.current_step == 2: #Si es la segunda fase
		if GLOBAL.current_path == 1: #Primero comprueba el camino que elegimos
			var lock_list :Array = [lvl_1a, lvl_1b, lvl_3, lvl_2b] #Y bloquea las misiones de manera acorde.
			var unlock_list : Array = [lvl_2a]
			paths_manager.lock_missions(lock_list)
			paths_manager.unlock_missions(unlock_list)
			lvl_2a.grab_focus()
			
		elif GLOBAL.current_path == 2:
			var lock_list :Array = [lvl_1a, lvl_1b, lvl_3, lvl_2a]
			var unlock_list : Array = [lvl_2b]
			paths_manager.lock_missions(lock_list)
			paths_manager.unlock_missions(unlock_list)
			lvl_2b.grab_focus()
			
	elif GLOBAL.current_step == 3:
		var lock_list :Array = [lvl_1a, lvl_1b, lvl_2a, lvl_2b]
		var unlock_list : Array = [lvl_3]
		paths_manager.lock_missions(lock_list)
		paths_manager.unlock_missions(unlock_list)
		lvl_3.grab_focus()

func save_temp_data():
	GLOBAL.selected_planet = selected_planet
	GLOBAL.map_button_ref = current_planet_ref
	GLOBAL.ship_icon_coords = current_button.get_child(0).global_position
	GLOBAL.current_path = current_button.my_info.get("path") 

func debug_progress_sim() -> void:
	save_temp_data()
	GLOBAL.current_step += 1 #Indica que se ha pasado a la siguiente fase.
	_ready()

func _on_go_pressed() -> void:
	save_temp_data()
	get_tree().change_scene_to_file("res://Prototypes/Shmup/FightLevel/fight_level.tscn")

func _on_back_pressed() -> void:
	if GLOBAL.current_step == 0:
		GLOBAL.current_step = 1
	save_temp_data()
	get_tree().change_scene_to_file("res://Prototypes/Shmup/Demo/PrepMenuDemo.tscn")

func deselect_prev_button(button : TextureButton)-> void:
	if current_selected_button:
		if current_selected_button != button:
			current_selected_button.deselect_button()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Back"):
		if !pause_menu.visible:
			_on_back_pressed()

func _on_pause_pressed() -> void:
	pause_menu.opened("planets_map")
