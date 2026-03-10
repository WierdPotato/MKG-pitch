extends CharacterBody2D

@export var speed : int
@export var hp : float

@onready var shoot_machine: Node2D = $ShootMachine
@onready var move_cd: Timer = $MoveCD
@onready var screensize = get_viewport_rect().size
@onready var area_2d: Area2D = $Area2D


@onready var ignore_clamps : bool = true

var crash_damage : float = 150
var hit_points_value = 1

var current_vector : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func initial_placement(target_coords) -> void:
	var new_vector : Vector2 = target_coords -global_position 
	print("Position Vector: ", new_vector.normalized())
	current_vector = new_vector.normalized()

func vector_randomizer() -> void:
	current_vector = Vector2(randf_range(-0.5, 0.5), randf_range(-2, 2))

func _on_move_cd_timeout() -> void:
	move_cd.start(randf_range(1, 2))
	speed = randi_range(4000, 5000)
	vector_randomizer()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		hp -= PREP.equiped_parts["wpn"].get("Damage")
		if hp <= 0:
			get_tree().current_scene.get_child(1).add_points(hit_points_value)
			self.queue_free()
	
	elif area.is_in_group("Positions"):
		move_cd.start()
		ignore_clamps = false
		area_2d.get_child(0).call_deferred("set_disabled", false)
		shoot_machine.activate()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_child(0).integrity -= crash_damage
		body.get_child(1).add_ammo(3)
		self.queue_free()


func _physics_process(delta: float) -> void:
	if !ignore_clamps:
		position.x = clamp(position.x, screensize.x/2 , screensize.x - 80)
		position.y = clamp(position.y, 54, screensize.y - screensize.y/7)
	velocity = current_vector * speed * delta
	move_and_slide()
