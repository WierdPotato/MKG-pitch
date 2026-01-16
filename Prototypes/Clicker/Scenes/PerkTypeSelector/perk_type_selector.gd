extends Node2D

signal perk_type_1
signal perk_type_2
signal perk_type_3

@onready var indicator: Node2D = $Indicator

var indicator_position : int

func _ready() -> void:
	indicator_position = 1
	indicator.rotation_degrees = 0

func _on_button_pressed() -> void:
	var final_degrees : int
	if indicator_position == 1:
		indicator_position = 2
		final_degrees = 120
		perk_type_2.emit()
		
	elif indicator_position == 2:
		indicator_position = 3
		final_degrees = 240
		perk_type_3.emit()
	
	elif indicator_position == 3:
		indicator_position = 1
		final_degrees = 360
		perk_type_1.emit()

	var tween : Tween = get_tree().create_tween()
	await tween.tween_property(indicator, "rotation_degrees", final_degrees, 0.1).finished
	if final_degrees == 360:
		indicator.rotation_degrees = 0
