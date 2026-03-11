extends CharacterBody2D

@export var speed : int
@export var hp : float

@onready var shoot_machine: Node2D = $ShootMachine
@onready var move_cd: Timer = $MoveCD
@onready var screensize = get_viewport_rect().size
@onready var area_2d: Area2D = $Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var collision_shape_2d: CollisionPolygon2D = $Area2D/CollisionShape2D


@onready var ignore_clamps : bool = true

var crash_damage : float = 90
var hit_points_value = 1

var current_vector : Vector2
var next_vector : Vector2
var alive : bool
var smoothing : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	smoothing = false
	alive = true
	shoot_machine.alive = true

func initial_placement(target_coords) -> void:
	var new_vector : Vector2 = target_coords -global_position 
	print("Position Vector: ", new_vector.normalized())
	current_vector = new_vector.normalized()

func vector_randomizer() -> void:
	if alive:
		var new_x : float = randf_range(-1.5, 1.5)
		var new_y : float = randf_range(-1.5, 1.5)
		if smoothing:
			next_vector = Vector2(new_x, new_y)
		else:
			current_vector = Vector2(new_x, new_y)

func _on_move_cd_timeout() -> void:
	move_cd.start(randf_range(1, 2))
	speed = randi_range(10000, 14000)
	vector_randomizer()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		hp -= PREP.equiped_parts["wpn"].get("Damage")
		if hp <= 0:
			get_tree().current_scene.get_child(1).add_points(hit_points_value)
			manage_death()
	
	elif area.is_in_group("Positions"):
		smoothing = true
		move_cd.start()
		ignore_clamps = false
		area_2d.get_child(0).call_deferred("set_disabled", false)
		shoot_machine.activate()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).integrity -= crash_damage
		body.get_child(1).add_ammo(3)
		manage_death()

func manage_death() -> void:
	alive = false
	shoot_machine.alive = false
	collision_shape_2d.call_deferred("set_disabled", true)
	explosion.visible = true
	sprite_2d.visible = false
	explosion.play("default")
	await explosion.animation_finished
	self.queue_free()


func _physics_process(delta: float) -> void:
	if !ignore_clamps:
		position.x = clamp(position.x, screensize.x/2 , screensize.x - 80)
		position.y = clamp(position.y, screensize.y/7, screensize.y - screensize.y/7)
		
	if smoothing:
		current_vector = current_vector.lerp(next_vector, delta*0.5)
	else:
		pass
		
	velocity = current_vector * speed * delta
	#$Label.text = str(current_vector)
	move_and_slide()
