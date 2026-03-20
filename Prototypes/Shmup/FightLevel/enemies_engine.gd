extends Node

@export var path_speed : int = 500

@export var max_duendes : int = 0
@export var max_chonky : int = -1

@onready var enemies: Node = $Enemies

@onready var saeta_spawn_timer = $Timers/SaetaSpawnTimer
@onready var duende_spawn_timer: Timer = $Timers/DuendeSpawnTimer
@onready var chonky_spawn_timer: Timer = $Timers/ChonkySpawnTimer


@onready var spawn_points: Path2D = $SpawnPoints
@onready var spawn_coords: PathFollow2D = $SpawnPoints/PathFollow2D

@onready var saeta : PackedScene = preload("res://Prototypes/Shmup/Enemies/Saeta/saeta.tscn")
@onready var duende : PackedScene = preload("res://Prototypes/Shmup/Enemies/Duende Verde/DuendeVerde.tscn")
@onready var chonky : PackedScene = preload("res://Prototypes/Shmup/Enemies/Chonky/Chonky.tscn")

@onready var duende_spawns: Node = $SpawnMarkers/DuendeSpawns
@onready var chonky_spawns: Node = $SpawnMarkers/ChonkySpawns

@onready var placements: Node = $Placements

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	#saeta_spawn_timer.start(randf_range(1.5, 2)) 
	duende_spawn_timer.start(randf_range(1.5, 2))
	chonky_spawn_timer.start(randf_range(8, 10))
	

func _on_saeta_spawn_timer_timeout() -> void:
	var saeta_instance = saeta.instantiate()
	saeta_instance.global_position = spawn_coords.global_position
	enemies.get_child(1).add_child(saeta_instance)
	saeta_spawn_timer.start(randf_range(1.5, 2))

func _on_duende_spawn_timer_timeout() -> void:
	if enemies.get_child(0).get_child_count() < max_duendes + GLOBAL.current_step:
		var duende_instance = duende.instantiate()
		duende_instance.global_position = duende_spawns.get_children().pick_random().global_position 
		enemies.get_child(0).add_child(duende_instance)
		duende_instance.initial_placement(placements.get_children().pick_random().global_position)
	
	duende_spawn_timer.start(randf_range(8, 10))

func _on_chonky_spawn_timer_timeout() -> void:
	if enemies.get_child(2).get_child_count() < max_chonky + GLOBAL.current_step:
		var chonky_instance = chonky.instantiate()
		chonky_instance.global_position = chonky_spawns.get_children().pick_random().global_position 
		enemies.get_child(2).add_child(chonky_instance)
		chonky_instance.initial_placement(placements.get_children().pick_random().global_position)
	
	chonky_spawn_timer.start(randf_range(10, 20))

func get_enemies() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_enemies()
	spawn_coords.set_progress(spawn_coords.get_progress() + path_speed * delta)
