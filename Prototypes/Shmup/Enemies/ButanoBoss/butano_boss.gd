extends Node2D

signal intruder
signal cleared
signal phase_2
signal boss_completed

@onready var alive : bool = true
@onready var turret_1: Sprite2D = $Turret1
@onready var turret_2: Sprite2D = $Turret2
@onready var swarm_1: Node2D = $Swarm1
@onready var swarm_2: Node2D = $Swarm2
@onready var shield: Area2D = $Shield

@onready var turret_number : int = 2
@export var hp : float = 1000
var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func activate_systems() -> void:
	turret_1.activate()
	turret_2.activate()
	swarm_1.activate()
	swarm_2.activate()
	shield.activate()

func check_turrets() -> void:
	if turret_number == 0:
		var swarms : Array = [swarm_1, swarm_2]
		var offsetted : Node2D = swarms.pick_random()
		offsetted.shot_offset = 5
		phase_2.emit()
		
func _on_main_body_body_entered(body: Node2D) -> void:
	if body is Player:
		STATS.crashes += 1
		body.get_child(0).integrity = 0


func _on_main_body_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		hp -= PREP.equiped_parts["wpn"].get("Damage")
		if hp <= 0:
			manage_death() 

func manage_death():
	STATS.kills += 1
	alive = false
	if turret_1:
		turret_1.manage_death()
	if turret_2:
		turret_2.manage_death()
	boss_completed.emit()
	self.queue_free()
