extends Control

@onready var grafismos: Node2D = $Grafismos
@onready var botones: Node2D = $Botones

var called_from

func opened(id : String) -> void:
	self.visible = true
	called_from = id
	botones.get_focus()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_texture_button_pressed() -> void:
	self.visible = false

func _on_main_button_pressed() -> void:
	get_tree().paused = false
	if called_from == "main_menu":
		self.visible = false
	else:
		grafismos.ignore_exit = true
		get_tree().change_scene_to_file("res://Prototypes/Menus/Main Menu/Main menu.tscn")
