extends Sprite2D

var reload_start_color : Color = Color(0.957, 0.957, 0.957, 1.0)
var reloaded_color : Color = Color(0.141, 0.827, 0.231, 1.0)
var reloading_color : Color = Color(1.0, 0.804, 0.459, 1.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func manage_behaviour(step : String) -> void:
	set_color(step)

func set_color(step : String) -> void:
	if step == "starting":
		visible = true
		self_modulate = reload_start_color
	elif step == "reloading":
		self.self_modulate = reloading_color
	elif step == "reloaded":
		self.self_modulate = reloaded_color
		await get_tree().create_timer(0.5).timeout
		visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
