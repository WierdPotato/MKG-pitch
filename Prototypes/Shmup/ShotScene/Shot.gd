extends Area2D

@export var speed : int = 100

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		queue_free()

func _process(delta: float) -> void:
	global_position.x += speed * delta
