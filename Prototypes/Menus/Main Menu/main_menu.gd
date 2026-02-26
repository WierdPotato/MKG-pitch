extends Node2D

@export var play_scene : PackedScene

@onready var play: Button = $Menu/Play/Play
@onready var settings: Button = $Menu/Settings/Settings
@onready var credits: Button = $Menu/Credits/Credits
@onready var exit: Button = $Menu/Exit/Exit
@onready var indicator: Sprite2D = $Menu/Indicator

@onready var play_coords: Marker2D = $Menu/Play/Marker2D
@onready var pause_menu: Control = $PauseMenu



var current_button : Button

func _ready() -> void:
	play.grab_focus()
	current_button = play
	indicator.position = play_coords.position
	print(current_button)



func _on_tree_entered() -> void:
	await get_tree().process_frame
	play.grab_focus()
	current_button = play
	indicator.position = play_coords.position

func move_indicator(coords) -> void:
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	tween.tween_property(indicator,"position", coords, 0.1)
	tween.play()

func check_current_button(button)-> void:
	
	if current_button == null:
		current_button = button
	else:
		if current_button != button:
			print(current_button)
			current_button._on_focus_exited()
			current_button = button
			print(current_button)
		else:
			pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(play_scene)

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_pause_menu_visibility_changed() -> void:
	if pause_menu.visible == true:
		pass
	else:
		settings.grab_focus()
