extends Node2D

@onready var my_turret: Sprite2D = $".."
@export var shot : PackedScene
@export var my_hit_dmg : int
@export var shot_cd : float = 2

@onready var shot_timer: Timer = $ShotCD
@onready var shot_spawn: Marker2D = $ShotSpawn

var can_shoot : bool = true

func activate()->void:
	await get_tree().create_timer(randf_range(1, 2)).timeout
	shot_timer.start(shot_cd)

func shoot() ->void:
	if can_shoot and my_turret.alive:
		var shot_instance = shot.instantiate() #Instancia la escena con el disparo
		
		shot_instance.global_position = shot_spawn.global_position #Establece la posición del disparo a la del marcador. 
		
		shot_instance.current_vector = -Vector2.from_angle(my_turret.global_rotation) 
		
		shot_instance.global_rotation_degrees = my_turret.global_rotation_degrees
		
		shot_instance.hit_damage = my_hit_dmg

		await get_tree().process_frame
		get_tree().call_group("Level", "add_child", shot_instance)
		shot_timer.start(randf_range((shot_cd-0.5), (shot_cd+0.5)))

func _on_shot_cd_timeout() -> void:
	shoot()
