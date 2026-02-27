extends Node2D

@onready var paths_manager: Node2D = $PathsManager

@onready var lvl_1a: Button = $PathsManager/PathA/Buttons/Lvl1a
@onready var lvl_2a: Button = $PathsManager/PathA/Buttons/Lvl2a
@onready var lvl_1b: Button = $PathsManager/PathB/Buttons/Lvl1b
@onready var lvl_2b: Button = $PathsManager/PathB/Buttons/Lvl2b
@onready var lvl_3: Button = $PathsManager/Final/Boss/Lvl3

@onready var mission_details: Control = $MissionDetails

@onready var back: TextureButton = $Menus/Back
@onready var go: TextureButton = $Menus/Go


var selected_mission : Dictionary
var current_planet : Button

func _ready() -> void:
	mission_details.visible = false
	manage_progress()
	if GLOBAL.current_step == 0:
		assign_missions()
	else:
		var all_missions : Array = [lvl_1a, lvl_1b, lvl_2a,lvl_2b, lvl_3]
		for i in all_missions:
			i.find_my_mission()

func assign_missions() -> void:
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
	GLOBAL.current_step = 1

func manage_progress()->void:
	print(GLOBAL.current_step)
	if GLOBAL.current_step == 1:
		var lock_list :Array = [lvl_2a, lvl_2b, lvl_3]
		var unlock_list : Array = [lvl_1a, lvl_1b]
		paths_manager.lock_missions(lock_list)
		paths_manager.unlock_missions(unlock_list)
		
	elif GLOBAL.current_step == 2:
		if GLOBAL.current_path == 1:
			var lock_list :Array = [lvl_1a, lvl_1b, lvl_3, lvl_2a]
			var unlock_list : Array = [lvl_2b]
			paths_manager.lock_missions(lock_list)
			paths_manager.unlock_missions(unlock_list)
			
		elif GLOBAL.current_path == 2:
			var lock_list :Array = [lvl_1a, lvl_1b, lvl_3, lvl_2b]
			var unlock_list : Array = [lvl_2a]
			paths_manager.lock_missions(lock_list)
			paths_manager.unlock_missions(unlock_list)
			
	elif GLOBAL.current_step == 3:
		var lock_list :Array = [lvl_1a, lvl_1b, lvl_2a, lvl_2b]
		var unlock_list : Array = [lvl_3]
		paths_manager.lock_missions(lock_list)
		paths_manager.unlock_missions(unlock_list)

func update_mission_details() -> void:
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
	get_tree().change_scene_to_file("res://Prototypes/Shmup/FightLevel/fight_level.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Prototypes/Shmup/Demo/PrepMenuDemo.tscn")

func debug_progress_sim() -> void:
	_ready()
	GLOBAL.selected_mission = selected_mission
	GLOBAL.current_path = current_planet.my_info.get("path")
	GLOBAL.current_step += 1
	print(GLOBAL.selected_mission)

func _process(delta: float) -> void:
	if selected_mission == null or current_planet == null:
		go.disabled = true
	else:
		go.disabled = false
