extends Node2D

@export var play_scene : PackedScene
@onready var play: Button = $Container/Play


func _ready() -> void:
	play.grab_focus()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(play_scene)

func _on_exit_pressed() -> void:
	get_tree().quit()
