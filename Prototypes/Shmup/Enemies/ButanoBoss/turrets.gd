extends Sprite2D

@export var turret_hp = 400
@onready var butano_boss: Node2D = $".."
@onready var rotator: Marker2D = $Rotator
@onready var shot_machine: Node2D = $ShotMachine
@onready var area: Area2D = $Area

@onready var turret_collision: CollisionShape2D = area.get_child(0)

var player : CharacterBody2D
var alive : bool = true
var activated : bool = false

func _ready() -> void:
	area.area_entered.connect(self._auto_area_entered) 
	area.body_entered.connect(self._auto_body_entered)
	
func activate() -> void:
	player = butano_boss.player
	shot_machine.activate()
	activated = true

func deactivate() -> void:
	activated = false
	alive = false

func _auto_area_entered(area: Area2D)-> void:
	if area.is_in_group("Shot"):
		turret_hp -= PREP.equiped_parts["wpn"].get("Damage")
		if turret_hp <= 0:
			manage_death() 

func _auto_body_entered(body: Node2D) -> void:
	if body is Player:
		print("turrer hit")
		body.get_child(0).integrity = 0


func manage_death()-> void:
	alive = false
	turret_collision.call_deferred("set_disabled", true)
	#explosion.visible = true
	#sprite_2d.visible = false
	#explosion.play("default")
	#await explosion.animation_finished
	butano_boss.turret_number -= 1
	butano_boss.check_turrets()
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if activated:
		rotator.look_at(player.global_position)
		rotator.rotate(PI)
		if rotator.global_rotation_degrees > -84 and rotator.global_rotation_degrees < 84:
			global_rotation_degrees = lerp(global_rotation_degrees, rotator.global_rotation_degrees, delta*10)
