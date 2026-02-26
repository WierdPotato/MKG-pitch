extends Control

@onready var pause_menu: Control = $"../PauseMenu"


func _on_settings_pressed() -> void:
	pause_menu.opened("main_menu")
