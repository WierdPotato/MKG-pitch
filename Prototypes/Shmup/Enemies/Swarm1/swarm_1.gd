extends CharacterBody2D

@export var speed : int = 100000
@export var hp : float = 1

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var area_2d: Area2D = $Area2D
@onready var lock_timer: Timer = $LockTimer

var target_locked : bool = false

var crash_damage : float = 10

var player : CharacterBody2D
var current_vector : Vector2
var placing : bool = true
var my_target_coords : Vector2
var final_lock = false

func initial_placement(target_coords : Vector2) -> void:
	my_target_coords = target_coords
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_coords, 0.5).set_trans(Tween.TRANS_SINE)
	await tween.finished
	lock_timer.start(1)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		hp -= PREP.equiped_parts["wpn"].get("Damage")
		if hp <= 0:
			player.get_child(1).add_ammo(3)
			manage_death()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).integrity -= crash_damage
		body.get_child(1).add_ammo(1)
		manage_death()

func manage_death() -> void:
	collision_shape_2d.call_deferred("set_disabled", true)
	explosion.visible = true
	sprite_2d.visible = false
	explosion.play("default")
	await explosion.animation_finished
	self.queue_free()

func _physics_process(delta: float) -> void:
	if target_locked:
		if !final_lock:
			current_vector = current_vector.lerp(player.global_position - global_position, delta*5).normalized()
		else:
			pass
		velocity = current_vector * speed * delta
		move_and_slide()

func _on_lock_timer_timeout() -> void:
	target_locked = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_aux_area_area_entered(area: Area2D) -> void:
	final_lock = true
