extends Control

@onready var grafismos: Node2D = $Grafismos
@onready var botones: Node2D = $Botones


var called_from

func opened(id : String) -> void:
	get_tree().paused = true
	self.visible = true
	called_from = id
	botones.get_focus()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("Pause"):
		if self.visible == false:
			opened("self")
		else:
			close()
	elif Input.is_action_just_released("Back"):
		close()
		
func close()->void:
	get_tree().paused = false
	await get_tree().process_frame
	self.visible = false



func _on_texture_button_pressed() -> void:
	close()

func _on_main_button_pressed() -> void:
	get_tree().paused = false
	if called_from == "main_menu":
		self.visible = false
	else:
		grafismos.ignore_exit = true
		get_tree().change_scene_to_file("res://Prototypes/Menus/Main Menu/Main menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
