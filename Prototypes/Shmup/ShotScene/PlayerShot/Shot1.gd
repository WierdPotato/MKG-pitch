extends Area2D

@export var speed : int = 2000

var player_node : CharacterBody2D

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		queue_free()
	elif area.is_in_group("EnemyShot"):
		player_node.get_child(1).add_ammo(3)
		queue_free()

func _physics_process(delta: float) -> void:
	global_position.x += speed * delta
