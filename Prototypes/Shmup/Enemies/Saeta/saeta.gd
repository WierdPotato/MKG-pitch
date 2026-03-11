extends Node2D

@export var speed : int = 100
@export var hp : float

@onready var sprite_2d: Sprite2D = $Area2D/Sprite2D
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D



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
			manage_death()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).integrity -= crash_damage
		body.get_child(1).add_ammo(2)
		manage_death()

func manage_death() -> void:
	collision_shape_2d.call_deferred("set_disabled", true)
	speed = 500
	explosion.visible = true
	sprite_2d.visible = false
	explosion.play("default")
	await explosion.animation_finished
	self.queue_free()

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta
