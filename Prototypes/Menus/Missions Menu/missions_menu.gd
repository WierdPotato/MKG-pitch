extends Node2D

@export var missions_mode : bool

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

var current_selected_button 

var selected_mission : Dictionary
var selected_planet : Dictionary
var current_planet : Button



func _ready() -> void:
	print("onready ", GLOBAL.current_step)
	if missions_mode:
		missions_ready()
		
	else:
		planets_ready()

func planets_ready() -> void:
	mission_details.visible = false
	manage_progress()
	if GLOBAL.current_step == 0:
		assign_planets()
		selected_mission = lvl_1a.my_mission
		selected_planet = lvl_1a.my_planet
		current_planet = lvl_1a
		bg_planet.texture = lvl_1a.my_planet.get("background")
		update_planet_details()
		debug_progress_sim()
		current_planet.grab_focus()
	else:
		reset_info()
		var all_missions : Array = [lvl_1a, lvl_1b, lvl_2a,lvl_2b, lvl_3]
		for i in all_missions:
			i.find_my_planet()
		
		current_planet = GLOBAL.map_button_ref
		#current_planet.grab_focus()
		#selected_planet = current_planet.my_planet
		update_planet_details()
	if is_instance_valid(current_planet):
		current_planet.call_deferred("grab_focus")
	else:
		print("Estoy to perdido ",is_instance_valid(current_planet))

func assign_planets() -> void:
	var all_planets_info : Array = PLANETS.planets.duplicate()
	var levels_1 = [lvl_1a, lvl_1b]
	var levels_2 = [lvl_2a, lvl_2b]
	var levels_3 = [lvl_3]

	for i1 in levels_1:
		var pick : Dictionary = all_planets_info.pick_random()
		set_base_info(i1, 1, i1.name)
		i1.set_planet(pick)
		all_planets_info.erase(pick)
		
	for i2 in levels_2:
		var pick : Dictionary = all_planets_info.pick_random()
		set_base_info(i2, 2, i2.name)
		i2.set_planet(pick)
		all_planets_info.erase(pick)

	for i3 in levels_3:
		var pick : Dictionary = all_planets_info.pick_random()
		set_base_info(i3, 0, i3.name)
		i3.set_planet(pick)
		all_planets_info.erase(pick)

func reset_info()->void:
	var levels_1 = [lvl_1a, lvl_1b]
	var levels_2 = [lvl_2a, lvl_2b]
	var levels_3 = [lvl_3]

	for i1 in levels_1:
		set_base_info(i1, 1, i1.name)
	for i2 in levels_2:
		set_base_info(i2, 2, i2.name)
	for i3 in levels_3:
		set_base_info(i3, 0, i3.name)

func set_base_info(button, id, own_name)-> void:
	button.set_info(id, own_name)
	pass

func update_planet_details() -> void:
	print("selected planet: ", current_planet)
	

func missions_ready() -> void:
	mission_details.visible = false
	manage_progress()
	if GLOBAL.current_step == 0:
		assign_missions()
		selected_mission = lvl_1a.my_mission
		current_planet = lvl_1a
		update_mission_details()
		debug_progress_sim()
	else:
		var all_missions : Array = [lvl_1a, lvl_1b, lvl_2a,lvl_2b, lvl_3]
		for i in all_missions:
			i.find_my_mission()
		current_planet = GLOBAL.map_button_ref
		current_planet.grab_focus()
		selected_mission = current_planet.my_mission
		update_mission_details()

func assign_missions() -> void: #Asigna misiones de manera aleatoria dependendiendo de la fase.
	var planets_1 : Array = [lvl_1a, lvl_1b]
	var planets_2 : Array = [lvl_2a, lvl_2b]
	var planets_3 : Array = [lvl_3]
	var step_1_missions : Array = MISSIONS.step_1_missions.duplicate()
	var step_2_missions : Array = MISSIONS.step_2_missions.duplicate()
	var step_3_missions : Array = MISSIONS.step_3_missions.duplicate()
	
	for i1 in planets_1:
		var pick : Dictionary = step_1_missions.pick_random()
		i1.set_mission(pick)
		i1.set_info(1)
		step_1_missions.erase(pick)
	
	for i2 in planets_2:
		var pick : Dictionary = step_2_missions.pick_random()
		i2.set_mission(pick)
		i2.set_info(2)
		step_2_missions.erase(pick)
	
	for i3 in planets_3:
		var pick : Dictionary = step_3_missions.pick_random()
		i3.set_mission(pick)
		i3.set_info(0)
		step_3_missions.erase(pick)

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

func update_mission_details() -> void: #Obtiene la información de la mision y la muestra
	var title : Label = mission_details.get_child(0)
	var description : Label = mission_details.get_child(1)
	var objective : Label = mission_details.get_child(2)
	var challenge : Label = mission_details.get_child(3)
	mission_details.visible = true
	title.text = selected_mission.get("name")
	description.text = selected_mission.get("description")
	if selected_mission.get("goal") == 0:
		objective.text = selected_mission.get("main_objective") + selected_mission.get("subject")
	else:
		objective.text = selected_mission.get("main_objective") + " "+str(selected_mission.get("goal")) + selected_mission.get("subject")
	challenge.text = selected_mission.get("challenge")

func _on_go_pressed() -> void:
	if missions_mode:
		GLOBAL.selected_mission = selected_mission 
	else:
		GLOBAL.selected_planet = selected_planet
		
	GLOBAL.map_button_ref = current_planet
	GLOBAL.current_path = current_planet.my_info.get("path") 
	self.queue_free()
	get_tree().change_scene_to_file("res://Prototypes/Shmup/FightLevel/fight_level.tscn")
	#debug_progress_sim()
func _on_back_pressed() -> void:
	current_planet = null
	selected_planet.clear()
	get_tree().change_scene_to_file("res://Prototypes/Shmup/Demo/PrepMenuDemo.tscn")

func debug_progress_sim() -> void:
	if missions_mode:
		GLOBAL.selected_mission = selected_mission #"Guarda" en el Autoload la misión que se ha elegido.
	else:
		GLOBAL.selected_planet = selected_planet
		
	GLOBAL.map_button_ref = current_planet
	GLOBAL.current_path = current_planet.my_info.get("path") #"Guarda" en el Autoload el camino que va a asociado a la misión elegida.
	GLOBAL.current_step += 1 #Indica que se ha pasado a la siguiente fase.
	_ready()

func deselect_prev_button(button : TextureButton)-> void:
	if current_selected_button:
		if current_selected_button != button:
			current_selected_button.deselect_button()
			
	current_selected_button = button

func _process(delta: float) -> void:
	if selected_mission == null or current_planet == null:
		go.disabled = true
	else:
		go.disabled = false
