extends Area2D

@export var speed : int = 1000
@export var hit_damage : int = 20

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var current_vector : Vector2

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).shot_hit(hit_damage)
		start_explosion()
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		start_explosion()

func start_explosion() -> void:
	collision_shape_2d.call_deferred("set_disabled", true)
	speed = 500
	sprite_2d.visible = false
	explosion.visible = true
	explosion.play("default")
	await explosion.animation_finished
	queue_free()

func _physics_process(delta: float) -> void:
	global_position += current_vector * speed * delta
