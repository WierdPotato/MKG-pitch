extends Node2D

@onready var butano_boss: Node2D = $".."
@export var swarm : PackedScene
@export var base_cd : float = 20
@export var shot_cd : float = 20

@onready var shot_timer: Timer = $ShotCD
@onready var shot_spawn: Marker2D = $Spawn

@onready var targets: Node2D = $Targets



var can_shoot : bool = true
var swarm_list : Array = []
var shot_offset : float = 0

func activate()->void:
	await get_tree().create_timer(randf_range(1, 2)).timeout
	print("Shot timer called")
	shot_timer.start(shot_cd)

func shoot() ->void:
	print("Swarm out")
	var targets_list : Array = targets.get_children()
	if can_shoot and butano_boss.alive:
		var iter : int = 0
		for i in targets.get_child_count():
			var swarm_instance = swarm.instantiate() #Instancia la escena con el disparo
			swarm_instance.name = "Swarm"+str(iter)
			swarm_instance.global_position = shot_spawn.global_position #Establece la posición del disparo a la del marcador. 
			swarm_instance.player = butano_boss.player
			await get_tree().process_frame
			get_tree().call_group("Level", "add_child", swarm_instance)
			swarm_instance.initial_placement(targets_list[iter].global_position)
			iter += 1
			await get_tree().create_timer(0.3).timeout
		shot_timer.start(shot_cd)
		
func _on_shot_cd_timeout() -> void:
	shoot()

func _on_butano_boss_phase_2() -> void:
	shot_cd = 10
	base_cd = shot_cd
	shot_timer.stop()
	await get_tree().create_timer(shot_offset).timeout
	shot_timer.start(shot_cd)
	
func _on_butano_boss_intruder() -> void:
	shoot()
	shot_timer.stop()
	shot_cd = 5


func _on_butano_boss_cleared() -> void:
	shot_cd = base_cd
