extends Node2D

@export var pointer_speed : float #Lo que tarda el pointer en ir de un lado a otro.

@onready var ammo_indicator: Node = $"../AmmoIndicator"

@onready var target: Area2D = $Target
@onready var pointer: Area2D = $Pointer
@onready var early: Area2D = $Early
@onready var late: Area2D = $Late
@onready var missed: Area2D = $Missed
@onready var start: Marker2D = $Start
@onready var finish: Marker2D = $Finish

@onready var border_feedback: Sprite2D = $"../BorderFeedback"

signal early_reload
signal perfect_reload
signal late_reload
signal missed_reload

var pointer_moving : bool

var soon : bool
var perfect : bool
var bad : bool

var tween : Tween 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pointer_moving = false

func reload_attempt() -> void:
	if pointer_moving:
		if soon:
			reset_pointer()
			emit_signal("early_reload")
		elif perfect:
			reset_pointer()
			emit_signal("perfect_reload")
		elif bad and perfect == false:
			reset_pointer()
			emit_signal("late_reload")
		await get_tree().process_frame
	else:
		pass

func reload_pressed() -> void:
	if pointer_moving:
		reload_attempt()
		
	else:
		call_reload()
	
func call_reload() -> bool:
	if await move_pointer():
		return false
	else:
		return false

func move_pointer() -> bool:
	border_feedback.manage_behaviour("starting")
	tween = get_tree().create_tween() #Creamos el tween
	tween.tween_property(pointer,"global_position", finish.global_position, 1.6).set_trans(Tween.TRANS_SINE)
	tween.play()
	pointer_moving = true
	await tween.finished
	return false

func _on_target_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pointer"):
		perfect = true

func _on_early_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pointer"):
		soon = true

func _on_late_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pointer"):
		bad = true

func _on_missed_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pointer"):
		reset_pointer()
		emit_signal("missed_reload")

func reset_pointer() -> void:
	tween.stop()
	pointer.get_child(1).set_deferred("disabled", true)
	pointer.global_position = start.global_position
	pointer.get_child(1).set_deferred("disabled", false)

	pointer_moving = false

	perfect = false
	soon = false
	bad = false


func _on_target_area_exited(area: Area2D) -> void:
	if area.is_in_group("Pointer"):
		perfect = false

func _on_early_area_exited(area: Area2D) -> void:
	if area.is_in_group("Pointer"):
		soon = false

func _on_late_area_exited(area: Area2D) -> void:
	if area.is_in_group("Pointer"):
		bad = false

func _on_missed_area_exited(_area: Area2D) -> void:
	pass
