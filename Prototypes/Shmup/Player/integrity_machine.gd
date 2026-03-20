extends Node2D

signal player_dead

@onready var player: Player = $".."
@onready var shot_machine: Node2D = $"../ShotMachine"
@onready var explosion: AnimatedSprite2D = $"../Explosion"
@onready var ship_sprite: Sprite2D = $"../ShipSprite"
@onready var collision: CollisionShape2D = $"../Collision"


var integrity : float #Almacena la vida del jugadors
var shield : float #Almacena la integridad de los escudos

var one_time_call : int = 1

func _ready() -> void:
	integrity = PREP.ship_hp
	shield = PREP.equiped_parts["sld"].get("HP")
	
func shot_hit(impact : float) -> void:
	var burst : float = 0
	burst = impact - shield
	if burst < 0:
		burst = 0
	shield -= impact
	integrity -= burst
	if shield < 0:
		shield = 0

func process_death() -> void:
	one_time_call -= 1
	
	explosion.visible = true
	ship_sprite.visible = false
	explosion.play("default")
	collision.call_deferred("set_disabled", true)
	PREP.ship_ammo = shot_machine.ammo
	await explosion.animation_finished
	player_dead.emit()
	#await get_tree().process_frame
	#get_parent().queue_free()
	#get_tree().change_scene_to_file("res://Prototypes/Menus/Main Menu/Main menu.tscn")



func _process(_delta: float) -> void:
	if integrity <= 0 and one_time_call >= 1:
		process_death()
	else:
		pass
