extends Node2D

@export var player : PackedScene
@export var enemy : PackedScene
@export var path_speed : int 

@export var points_goal : int

@onready var spawn_points: Path2D = $SpawnPoints
@onready var spawn_coords: PathFollow2D = $SpawnPoints/PathFollow2D
@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var label: Label = $Label

var current_points = 0


func _ready() -> void:
	current_points = 0
	var player_instance = player.instantiate()
	player_instance.global_position = player_spawn.global_position
	add_child(player_instance)

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_coords.global_position
	add_child(enemy_instance)

func _process(delta: float) -> void:
	spawn_coords.set_progress(spawn_coords.get_progress() + path_speed * delta)
	label.text  = str(current_points)+" / "+str(points_goal)
	if current_points >= points_goal:
		get_tree().change_scene_to_file("res://Prototypes/Clicker/Scenes/clicker_m_scene.tscn")
