extends Node2D



@export var speed : int = 100
@export var hp : float


var crash_damage : float = 50
var hit_points_value = 1

func _ready() -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		hp -= PREP.equiped_parts["wpn"].get("Damage")
		get_tree().current_scene.get_child(1).add_points(hit_points_value)
		if hp <= 0:
			self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).integrity -= crash_damage
		body.get_child(1).add_ammo(2)
		self.queue_free()


func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta
