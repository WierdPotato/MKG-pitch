extends Node2D

@export var player : PackedScene

@export var points_goal : int

@onready var pause_menu: Control = $"../PauseMenu"

@onready var enemy_timers: Node = $EnemiesEngine/Timers


@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var progress_bar: TextureProgressBar = $UI/Footer/HP
@onready var hp_diff: TextureProgressBar = $"UI/Footer/HP Diff"


@onready var reload_machine: Node2D = $UI/ReloadMachine

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
	player_instance.get_child(1).reload_machine = reload_machine
	


func _on_hp_value_changed(value: float) -> void:
	await get_tree().create_timer(0.75).timeout
	var tween : Tween = get_tree().create_tween() #Creamos el tween
	#tween.tween_property(self,"Vs", Vf, time_sim(axis.y, "y")) #Y cambiamos la velocidad en base al tiempo obtenido en la formula.
	tween.tween_property(hp_diff, "value", value, 0.4)
	tween.play()

func _on_pause_pressed() -> void:
	pause_menu.opened("flight")

func _on_pause_menu_visibility_changed() -> void:
	if pause_menu.visible == true:
		pass
	else:
		pass
		#get_tree().paused = false

func add_points(hit_points_value) -> void:
	current_points += hit_points_value
	if current_points >= points_goal:
		manage_win() 
		
func manage_win() -> void:
	stop_spawn_timers()
	PREP.ship_ammo = player_instance.shot_machine.ammo
	await get_tree().create_timer(1).timeout
	GLOBAL.current_step += 1
	get_tree().change_scene_to_file("res://Prototypes/Clicker/Scenes/clicker_m_scene.tscn")

func stop_spawn_timers() -> void:
	for i in enemy_timers.get_children():
		i.stop()

func _on_reload_machine_early_reload() -> void:
	player_instance.shot_machine.reload(1)

func _on_reload_machine_perfect_reload() -> void:
	player_instance.shot_machine.reload(2)

func _on_reload_machine_late_reload() -> void:
	player_instance.shot_machine.reload(3)


func _on_reload_machine_missed_reload() -> void:
	player_instance.shot_machine.reload(4)


func _process(delta: float) -> void:
	progress_bar.value = player_instance.integrity_machine.integrity
	ammo.text = str(player_instance.shot_machine.ammo)
	shield.text = str(player_instance.integrity_machine.shield)
	mission_value.text = str(current_points)+" / "+str(points_goal)
	
