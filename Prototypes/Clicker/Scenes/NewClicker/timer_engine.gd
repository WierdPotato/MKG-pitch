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
	clicker_timer.start(time)
	timer_progress_donut.max_value = time

func _on_new_clicker_stop_time() -> void:
	clicker_timer.paused = true

func _on_new_clicker_resume_time() -> void:
	clicker_timer.paused = false

func _on_clicker_timer_timeout() -> void:
	clicker_ended.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	timer_progress_donut.value = clicker_timer.time_left
	seconds_label.text = str(int(round(clicker_timer.time_left)))
