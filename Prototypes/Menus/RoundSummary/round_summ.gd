extends Control


@onready var clicker_scene : PackedScene = preload("res://Prototypes/Clicker/Scenes/NewClicker/NewClicker.tscn")
@onready var planet_map : PackedScene = preload("res://Prototypes/Menus/Planet/PlanteStageMenu.tscn")

@onready var time: Label = $Details/Data1/Info1
@onready var shots_fired: Label = $Details/Data2/Info2
@onready var shots_missed: Label = $Details/Data3/Info3
@onready var enemies_hit: Label = $Details/Data4/Info4
@onready var block: Label = $Details/Data5/Info5
@onready var hits_recieved: Label = $Details/Data6/Info6
@onready var crashes: Label = $Details/Data7/Info7
@onready var kills: Label = $Details/Data8/Info8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_info()

func _on_next_pressed() -> void:
	if PLANETS.current_planet_round < 4:
		PREP.get_densities(PLANETS.current_planet_round)
		PREP.get_temperatures(PLANETS.current_planet_round)
		GLOBAL.planet_menu_prev_scene = "summ"
		get_tree().change_scene_to_packed(planet_map)
	else:
		PLANETS.reset_inplanet_round()
		GLOBAL.current_step += 1
		get_tree().change_scene_to_packed(clicker_scene)

func set_info()->void:
	time.text = STATS.return_time()
	shots_fired.text = str(STATS.shots_fired)
	enemies_hit.text = str(STATS.enemies_hit)
	block.text = str(STATS.blocked)
	hits_recieved.text = str(STATS.hits_recieved)
	crashes.text = str(STATS.crashes)
	kills.text = str(STATS.kills)
	#shots_missed.text = str()
	
