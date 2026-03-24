extends Area2D

@export var speed : int = 2000

@onready var explosion: AnimatedSprite2D = $Explosion
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var player_node : CharacterBody2D

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		start_explosion()
	elif area.is_in_group("EnemyShot"):
		player_node.get_child(1).add_ammo(3)
		start_explosion()
	elif area.is_in_group("Inmune"):
		start_explosion()
 
func start_explosion() -> void:
	collision_shape_2d.call_deferred("set_disabled", true)
	speed = -500
	sprite_2d.visible = false
	explosion.visible = true
	explosion.play("default")
	await explosion.animation_finished
	queue_free()

func _physics_process(delta: float) -> void:
	global_position.x += speed * delta
