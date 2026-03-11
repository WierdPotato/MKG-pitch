extends Node
@onready var level: Node2D = $"../.."

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $Label

var player_ref
var bullets_mode : bool = true

var ignore_process : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func connect_player() -> void:
	var timer_node = player_ref.get_child(1).get_child(4)
	var ammo_machine_node = player_ref.get_child(1)
	timer_node.timeout.connect(self.reload_finished)
	ammo_machine_node.reload_started.connect(self.reload_started)
	

func set_progress_donut(type : String) -> void:
	if type == "bullets":
		bullets_mode = true
		texture_progress_bar.max_value = player_ref.get_child(1).max_chamber
		texture_progress_bar.step = 1
		texture_progress_bar.tint_progress = Color8(244, 244, 244)
		
	elif type == "load":
		bullets_mode = false
		texture_progress_bar.step = 0.01
		texture_progress_bar.max_value = player_ref.get_child(1).reload_timer.wait_time
		texture_progress_bar.tint_progress = Color8(167, 0, 0)
		
	ignore_process = false

func update_progress_bar() -> void:
	if bullets_mode:
		texture_progress_bar.value = player_ref.get_child(1).chamber
	else:
		texture_progress_bar.value =player_ref.get_child(1).reload_timer.wait_time - player_ref.get_child(1).reload_timer.time_left

func reload_started() -> void:
	set_progress_donut("load")

func reload_finished() -> void:
	ignore_process = true
	await get_tree().process_frame
	set_progress_donut("bullets")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !ignore_process:
		label.text = str(player_ref.get_child(1).chamber)
		update_progress_bar()
