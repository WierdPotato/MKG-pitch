extends Node

var money : int = 200000 #Almacena los puntos obtenidos en el clicker

var current_step : int = 0
var selected_path : int
var mission_goal : int = 0

func _ready() -> void:
	current_step = 0


func mission_manager(current_mission : Dictionary) -> void: 
	mission_goal = current_mission.get("goal")

func scale_goal(current_mission : Dictionary) -> void:
	var processed_goal : int
	
	if current_mission.get("typeid") == 0:
		processed_goal = ceil(current_step * 10.75)
		
	elif current_mission.get("typeid") == 1:
		processed_goal = (current_step * 65)
	
	elif current_mission.get("typedid") == 2:
		processed_goal = 1
		
	mission_goal = processed_goal
