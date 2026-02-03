extends Node2D

@export var player : PackedScene
@export var enemy : PackedScene
@export var path_speed : int 

@export var points_goal : int

@onready var spawn_points: Path2D = $SpawnPoints
@onready var spawn_coords: PathFollow2D = $SpawnPoints/PathFollow2D
@onready var player_spawn: Marker2D = $PlayerSpawn

@onready var progress_bar: TextureProgressBar = $UI/Footer/HP
@onready var hp_diff: TextureProgressBar = $"UI/Footer/HP Diff"

@onready var ammo: Label = $UI/Footer/Ammo
@onready var shield: Label = $UI/Footer/Shield

@onready var mission_detail: Label = $UI/Missions/Mission/Detail
@onready var mission_value: Label = $UI/Missions/Mission/Value

@onready var challenge_detail: Label = $UI/Missions/Challenge/Detail
@onready var challenge_value: Label = $UI/Missions/Challenge/Value


var player_instance
var current_points = 0


func _ready() -> void:
	current_points = 0
	player_instance = player.instantiate()
	player_instance.global_position = player_spawn.global_position
	add_child(player_instance)
	progress_bar.max_value = player_instance.integrity_machine.integrity
	hp_diff.max_value = progress_bar.max_value
	
func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_coords.global_position
	add_child(enemy_instance)

func _on_hp_value_changed(value: float) -> void:
	await get_tree().create_timer(0.75).timeout
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	#tween.tween_property(self,"Vs", Vf, time_sim(axis.y, "y")) #Y cambiamos la velocidad en base al tiempo obtenido en la formula.
	tween.tween_property(hp_diff, "value", value, 0.4)
	tween.play()

func _process(delta: float) -> void:
	progress_bar.value = player_instance.integrity_machine.integrity
	ammo.text = str(player_instance.shot_machine.ammo)
	shield.text = str(player_instance.integrity_machine.shield)
	mission_value.text = str(current_points)+" / "+str(points_goal)
	spawn_coords.set_progress(spawn_coords.get_progress() + path_speed * delta)
	if current_points >= points_goal:
		get_tree().change_scene_to_file("res://Prototypes/Clicker/Scenes/clicker_m_scene.tscn")
