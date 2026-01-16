extends Control

@onready var description_label: Label = $Description
@onready var main_objective: Label = $MainObjective
@onready var challenge: Label = $Challenge
@onready var hide_node: Node2D = $Hide

var selected_mission : Dictionary

func update_info(mission : Dictionary, description : String, challenge_string : String, button: Button) -> void:
	print(description)
	if button.locked == true:
		hide_node.visible = true
	else:
		selected_mission = mission
		hide_node.visible = false
		main_objective.text = mission.get("objective") + str(mission.get("goal")) + mission.get("subject")
		description_label.text = description
		challenge.text = challenge_string

func hide_details() -> void:
	if self.visible == true:
		self.visible = false
	else:
		pass

func show_details() -> void:
	if self.visible == false:
		self.visible = true
	else:
		pass

func _on_button_pressed() -> void:
	GLOBAL.mission_manager(selected_mission)
