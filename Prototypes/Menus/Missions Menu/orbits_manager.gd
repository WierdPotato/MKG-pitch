extends Node

@onready var missions_menu: Node2D = $"../.."
@onready var planets: Node = $Planets
@onready var planet_template : PackedScene = preload("res://Prototypes/Menus/Missions Menu/planet.tscn")
@onready var star: Sprite2D = $"../Star"
@onready var range: TextureCircle = $"../Range"



@onready var orbit_1: Path2D = $Orbit1
@onready var orbit_2: Path2D = $Orbit2
@onready var orbit_3: Path2D = $Orbit3
@onready var orbit_4: Path2D = $Orbit4


const PLANETA_AZUL_CLARO = preload("uid://cniyucwa5t6mk")
const PLANETA_BLANCO = preload("uid://cmiyhqpa3sjjr")
const PLANETA_AZUL = preload("uid://jwk0hjymfmej")
const planets_spritesheet = preload("uid://8yv3h7mhvswa")

const planets_sprites : Array = [PLANETA_AZUL, PLANETA_AZUL_CLARO, PLANETA_BLANCO]

var O1_planets : int
var O2_planets : int
var O3_planets : int
var O4_planets : int

var all_planets : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GLOBAL.current_step)
	range.radius = PREP.current_fuel
	if GLOBAL.current_step == 0:
		O1_planets = randi_range(1, 2)
		get_points(orbit_1, O1_planets)
		O2_planets = randi_range(3, 4)
		get_points(orbit_2, O2_planets)
		O3_planets = randi_range(3, 5)
		get_points(orbit_3, O3_planets)
		O4_planets = randi_range(5, 7)
		get_points(orbit_4, O4_planets)
		await get_tree().process_frame
		modify_planets()
	else:
		recover_planets()

func get_points(orbit : Path2D, sectors : int)->void:
	var increments : float = 1.0/sectors
	var sector_beginning : float = 0
	var sector_finish : float = increments
	for i in sectors:
		var point = randf_range(sector_beginning+(0.01*sectors), sector_finish-(0.01*sectors))
		orbit.get_child(0).progress_ratio = point
		var planet_instance = planet_template.instantiate()
		planet_instance.scale = Vector2(0.12, 0.12)
		planets.add_child(planet_instance)
		planet_instance.global_position = orbit.get_child(0).global_position
		sector_beginning += increments
		sector_finish += increments
		all_planets.append(planet_instance)

func modify_planets()->void:
	var planets_list = PLANETS.all_planets_list.duplicate()
	for i in all_planets:
		i.star_coords = star.global_position
		i.missions_menu = missions_menu
		var planet_pick =  planets_list.pick_random()
		i.my_map_coords = i.global_position
		await i.set_info(planet_pick)
		planets_list.erase(planet_pick)
		GLOBAL.current_step = 1 
	get_distances(true)

func recover_planets()->void:
	for i in PLANETS.referenced_planets:
		var planet_instance = planet_template.instantiate()
		planet_instance.star_coords = star.global_position
		planet_instance.missions_menu = missions_menu
		planet_instance.scale = Vector2(0.12, 0.12)
		planets.add_child(planet_instance)
		planet_instance.recover_info(PLANETS.referenced_planets.get(i).get("details"))
		planet_instance.global_position = PLANETS.referenced_planets.get(i).get("coords")
		all_planets.append(planet_instance)
	get_distances(false)


func get_distances(first : bool)->void:
	if first:
		for i in all_planets:
			i.range_ring = range
			var iter_list : Array = all_planets.duplicate()
			iter_list.erase(i)
			for p in iter_list:
				i.add_distances(p.my_details, p.my_map_coords)
				PLANETS.assign_refs(i.my_details.get("name"),i.my_details, i.my_map_coords, p.distances)
			i.check_focused()

	else:
		for i in all_planets:
			i.range_ring = range
			i.distances = PLANETS.referenced_planets.get(i.my_details.get("name")).get("distances")
			i.check_focused()
	
