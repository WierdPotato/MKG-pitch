extends Control

signal clicker_ended

@onready var new_clicker: Control = $".."

@onready var clicker_timer: Timer = $ClickerTimer
@onready var timer_progress_donut: TextureProgressBar = $TimerProgressDonut
@onready var seconds_label: Label = $SecondsLabel

@onready var time = (new_clicker.clicker_minutes * 60)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initiate_timer()

func initiate_timer() -> void:
	var time_debuff : float = 0
	if GLOBAL.current_step == 2:
		time_debuff = 15
	elif GLOBAL.current_step == 3:
		time_debuff = 30
	clicker_timer.wait_time = time - time_debuff
	timer_progress_donut.max_value = time - time_debuff
	clicker_timer.start()
	clicker_timer.paused = true

func _on_new_clicker_stop_time() -> void:
	clicker_timer.paused = true

func _on_new_clicker_resume_time() -> void:
	clicker_timer.paused = false

func _on_clicker_timer_timeout() -> void:
	clicker_ended.emit()

func _on_points_manager_start_game() -> void:
	clicker_timer.paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	timer_progress_donut.value = clicker_timer.time_left
	seconds_label.text = str(int(round(clicker_timer.time_left)))
