extends Area2D

@export var speed : int = 1000
@export var hit_damage : int

var current_vector : Vector2

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).shot_hit(hit_damage)
		self.queue_free()
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		self.queue_free()

func _physics_process(delta: float) -> void:
	global_position += current_vector * speed * delta
