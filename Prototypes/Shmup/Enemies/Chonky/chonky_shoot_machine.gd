extends Node2D

@onready var chonky: CharacterBody2D = $".."
@export var shot : PackedScene
@export var my_hit_dmg : int

@onready var shot_cd: Timer = $ShotCD
@onready var marker_2d: Marker2D = $Marker2D

var player_in_range : bool
var can_shoot : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shot_cd.start(8)

func activate() ->void:
	pass

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player in range")
		player_in_range = true
		shoot()

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		print("Player out of range")
		player_in_range = false

func _on_shot_cd_timeout() -> void:
	can_shoot = true
	if player_in_range:
		shoot()
	shot_cd.start(5)

func shoot() ->void:
	if can_shoot and chonky.alive:
		var shot_instance1 = shot.instantiate() #Instancia la escena con el disparo
		var shot_instance2 = shot.instantiate()
		var shot_instance3 = shot.instantiate()
		var shots_array : Array = [shot_instance1, shot_instance2, shot_instance3]
		var iter : int = 1
		for i in shots_array:
			i.global_position = marker_2d.global_position #Establece la posición del disparo a la del marcador. 
			if iter == 1:
				i.current_vector = Vector2(-0.9659,-0.2588)
				i.rotation_degrees = 15
			elif iter == 2:
				i.current_vector = Vector2(-1, 0)
			elif iter == 3:
				i.current_vector = Vector2(-0.9659,0.2588)
				i.rotation_degrees = -15
			i.hit_damage = my_hit_dmg
			iter += 1
			await get_tree().process_frame
			get_tree().call_group("Level", "add_child", i)
		can_shoot = false
