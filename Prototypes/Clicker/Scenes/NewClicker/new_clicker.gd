extends Control

signal stop_time
signal resume_time

@export var clicker_minutes : float = 2

@onready var points_manager: Node = $PointsManager


var time_stopped : bool
var simulated_pps : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_stopped = false
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("PrevTab"):
		stop_time.emit()
	if Input.is_action_just_released("PrevTab"):
		resume_time.emit()

func sim_points_per_second() -> void:
	var simulated_click_points : float = points_manager.points_per_click + GLOBAL.total_yellow + (GLOBAL.total_yellow * GLOBAL.total_pcn_yellow) + (GLOBAL.money * GLOBAL.total_gen_pcn_yellow)
	var simulated_points_ps : float = (GLOBAL.total_red + (GLOBAL.total_red * GLOBAL.total_pcn_red))*(1/1-(1-GLOBAL.total_red_cd_reduction))
	simulated_pps = (simulated_click_points*4) + simulated_points_ps
	GLOBAL.simulated_points = simulated_pps
	print("Simulated points: ", GLOBAL.simulated_points)
func _on_resume_time() -> void:
	time_stopped = false

func _on_stop_time() -> void:
	time_stopped = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
