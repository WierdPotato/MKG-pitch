extends Node

signal start_game
signal hide_unchosen

@onready var new_clicker: Control = $".."
@onready var all_perks: VBoxContainer = $"../AllPerks"

@export var cheat : bool = false
@export var autopoints_cd : float = 1

@onready var clicker: TextureButton = $Clicker
@onready var autopoints_timer: Timer = $AutopointsTimer
@onready var total_money_lbl: Label = $TotalMoneyLBL


var float_points : float
var total_points : int
var points_per_click : float
var click_point_value : int = 1
var click_percentage_amm : float
var points_per_second : float
var auto_point_value : int = 0
var auto_percentage_amm : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if cheat:
		float_points = 99999999
	else:
		float_points = GLOBAL.money
		
	points_per_click = 1
	points_per_second = 0
	auto_percentage_amm = 0

func _on_start_game() -> void:
	new_clicker.game_started = true
	all_perks.current_button.grab_focus()
	hide_unchosen.emit()
	autopoints_timer.start(autopoints_cd)
	print(autopoints_timer.wait_time)

func _on_clicker_pressed() -> void:
	manage_click()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click"):
		manage_click()

func manage_click() -> void:
	if !new_clicker.game_started and all_perks.current_button != null:
		start_game.emit()
		
	if !new_clicker.time_stopped:
		add_click_points()

func add_click_points() -> void:
	if new_clicker.game_started:
		float_points += points_per_click + GLOBAL.total_yellow + (GLOBAL.total_yellow * GLOBAL.total_pcn_yellow) + (GLOBAL.money * GLOBAL.total_gen_pcn_yellow)

func clicks_percentage(percentage : int) -> void:
	click_percentage_amm += percentage
	print("Porcentaje aumentado: ", auto_percentage_amm / 100)

func _on_autopoints_timer_timeout() -> void:
	autopoints_timer.wait_time = autopoints_cd - GLOBAL.total_red_cd_reduction
	float_points += GLOBAL.total_red + (GLOBAL.total_red * GLOBAL.total_pcn_red)
	print(GLOBAL.total_red)
	
	
func _on_new_clicker_stop_time() -> void:
	autopoints_timer.paused = true

func _on_new_clicker_resume_time() -> void:
	autopoints_timer.paused = false

func autopoints_percentage(percentage : int) -> void:
	auto_percentage_amm += percentage 
	print("Porcentaje aumentado: ", auto_percentage_amm / 100)

func manage_points() -> void:
	total_points = floori(float_points)
	GLOBAL.money = total_points

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	manage_points()
	total_money_lbl.text = str(total_points)
