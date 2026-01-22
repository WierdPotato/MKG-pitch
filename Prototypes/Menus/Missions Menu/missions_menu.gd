extends Node2D

@onready var lvl_1a: Button = $PathsManager/PathA/Buttons/Lvl1a
@onready var lvl_2a: Button = $PathsManager/PathA/Buttons/Lvl2a
@onready var lvl_1b: Button = $PathsManager/PathB/Buttons/Lvl1b
@onready var lvl_2b: Button = $PathsManager/PathB/Buttons/Lvl2b
@onready var lvl_3: Button = $PathsManager/Lvl3

@onready var paths_manager: Node2D = $PathsManager



@onready var mission_details: Control = $MissionDetails



func _ready() -> void:
	GLOBAL.current_step = 1
	if GLOBAL.current_step == 1:
	
		var available_missions_1 : Array = MISSIONS.step_1_missions.duplicate() #Hace una copia de la lista de misiones de cada fase
		var available_missions_2 : Array = MISSIONS.step_2_missions.duplicate()
		var available_missions_3 : Array = MISSIONS.step_3_missions.duplicate()
		
		var step_1_buttons : Array = [lvl_1a, lvl_1b]
		var step_2_buttons: Array = [lvl_2a, lvl_2b]
		var step_3_buttons : Array = [lvl_3]
		
		set_up_info(available_missions_1, step_1_buttons)
		set_up_info(available_missions_2, step_2_buttons)
		set_up_info(available_missions_3, step_3_buttons)

	else:
		if GLOBAL.selected_path == 0:
			pass
	
	lvl_1a.grab_focus()
func set_up_info(missions : Array, buttons : Array) -> void:
	for i in buttons:
		var current_mission = missions.pick_random()
		i.my_mission.set("mission", current_mission)
		var current_descrp_id = current_mission.get("descriptions").keys().pick_random()
		i.my_mission.set("description", current_mission.get("descriptions").get(str(current_descrp_id)))
		i.my_mission.set("challenge", current_mission.get("challenges").pick_random().get("objective"))
		missions.erase(current_mission)

#########################################
#Cuando botón es seleccionado o se pone encima el ratón, muestra la información que tiene establecida

func _on_lvl_1_focus_entered() -> void:
	mission_details.update_info(lvl_1a.my_mission.get("mission"), lvl_1a.my_mission.get("description"), lvl_1a.my_mission.get("challenge"), lvl_1a)
	mission_details.show_details()
	
func _on_lvl_1_mouse_entered() -> void:
	mission_details.update_info(lvl_1a.my_mission.get("mission"), lvl_1a.my_mission.get("description"), lvl_1a.my_mission.get("challenge"), lvl_1a)
	mission_details.show_details()


#########################################


func _on_lvl_1b_focus_entered() -> void:
	mission_details.update_info(lvl_1b.my_mission.get("mission"), lvl_1b.my_mission.get("description"), lvl_1b.my_mission.get("challenge"), lvl_1b)
	mission_details.show_details()

func _on_lvl_1b_mouse_entered() -> void:
	mission_details.update_info(lvl_1b.my_mission.get("mission"), lvl_1b.my_mission.get("description"), lvl_1b.my_mission.get("challenge"), lvl_1b)
	mission_details.show_details()

#########################################


func _on_lvl_2_focus_entered() -> void:
	mission_details.update_info(lvl_2a.my_mission.get("mission"), lvl_2a.my_mission.get("description"), lvl_2a.my_mission.get("challenge"),lvl_2a)
	mission_details.show_details()

func _on_lvl_2_mouse_entered() -> void:
	mission_details.update_info(lvl_2a.my_mission.get("mission"), lvl_2a.my_mission.get("description"), lvl_2a.my_mission.get("challenge"), lvl_2a)
	mission_details.show_details()


#########################################


func _on_lvl_2b_focus_entered() -> void:
	mission_details.update_info(lvl_2b.my_mission.get("mission"), lvl_2b.my_mission.get("description"), lvl_2b.my_mission.get("challenge"),lvl_2b)
	mission_details.show_details()

func _on_lvl_2b_mouse_entered() -> void:
	mission_details.update_info(lvl_2b.my_mission.get("mission"), lvl_2b.my_mission.get("description"), lvl_2b.my_mission.get("challenge"),lvl_2b)
	mission_details.show_details()


##########################################


func _on_lvl_3_focus_entered() -> void:
	mission_details.update_info(lvl_3.my_mission.get("mission"), lvl_3.my_mission.get("description"), lvl_3.my_mission.get("challenge"),lvl_3)
	mission_details.show_details()

func _on_lvl_3_mouse_entered() -> void:
	mission_details.update_info(lvl_3.my_mission.get("mission"), lvl_3.my_mission.get("description"), lvl_3.my_mission.get("challenge"),lvl_3)
	mission_details.show_details()
