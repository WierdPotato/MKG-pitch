extends Control

signal stop_time
signal resume_time

@export var clicker_minutes : float = 0.5
@export var prep_menu : PackedScene

@onready var points_manager: Node = $PointsManager
@onready var all_perks: VBoxContainer = $AllPerks
@onready var pause_menu: Control = $PauseMenu


var game_started : bool
var time_stopped : bool
var simulated_pps : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_started = false
	time_stopped = false
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("PrevTab") and game_started:
		stop_time.emit()
	if Input.is_action_just_released("PrevTab") and game_started:
		resume_time.emit()

func sim_points_per_second() -> void:
	var simulated_click_points : float = points_manager.points_per_click + GLOBAL.total_yellow + (GLOBAL.total_yellow * GLOBAL.total_pcn_yellow) + (GLOBAL.money * GLOBAL.total_gen_pcn_yellow)
	var simulated_points_ps : float = (GLOBAL.total_red + (GLOBAL.total_red * GLOBAL.total_pcn_red))*(1/1-(1-GLOBAL.total_red_cd_reduction))
	simulated_pps = (simulated_click_points*4) + simulated_points_ps
	GLOBAL.simulated_points = simulated_pps

	
func _on_resume_time() -> void:
	time_stopped = false

func _on_stop_time() -> void:
	time_stopped = true

func _on_timer_engine_clicker_ended() -> void:
	GLOBAL.last_focused_perk = all_perks.current_button.my_global_id
	get_tree().change_scene_to_packed(prep_menu)


func _on_pause_menu_visibility_changed() -> void:
	if pause_menu.visible == true:
		pass
	else:
		all_perks.current_button.grab_focus()

func _on_pause_pressed() -> void:
	pause_menu.opened("clicker")
