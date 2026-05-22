extends Control

@onready var summ_scene : String = "res://Prototypes/Menus/RoundSummary/RoundSumm.tscn"
@onready var fight_scene : PackedScene = preload("res://Prototypes/Shmup/FightLevel/fight_level.tscn")
@onready var solar_system : PackedScene = preload("res://Prototypes/Menus/Missions Menu/missions_menu.tscn")
@onready var planet: Sprite2D = $Sprites/Planet


@onready var planet_name: Label = $Details/PlanetName
@onready var type: Label = $Details/Data1/Info1
@onready var distance: Label = $Details/Data3/Info3
@onready var surf_temp: Label = $Details/Data2/Info2
@onready var curr_temp: Label = $Details/Data6/Info6
@onready var surf_dens: Label = $Details/Data4/Info4
@onready var curr_dens: Label = $Details/Data7/Info7
@onready var atmos: Label = $Details/Data8/Info8
@onready var tier: Label = $Details/Data5/Info5


@onready var ship: Sprite2D = $Sprites/Ship
@onready var layers: Node = $Layers

var planet_info : Dictionary

func _ready() -> void:
	planet_info = PLANETS.referenced_planets.get(PREP.selected_planet_id)
	var scale_factor = planet_info.get("details").get("details_scale")
	var reg_x = planet_info.get("details").get("texture_region").get("x")*2
	var reg_w = 1600
	var reg_y = planet_info.get("details").get("texture_region").get("y")*2
	var reg_h = 1600
	planet.texture.set_region(Rect2(reg_x, reg_y, reg_w, reg_h))
	planet.scale = Vector2(scale_factor, scale_factor)
	move_ship()
	set_details()

func move_ship()->void:
	ship.global_position = layers.get_child(PLANETS.current_planet_round-1).global_position

func set_details()->void:
	planet_name.text = planet_info.get("details").get("name")
	type.text = planet_info.get("details").get("surface_type")
	var converted_distance = (planet_info.get("details").get("distance_star")/133)
	distance.text = "%.2f" %  converted_distance +" AU" #
	surf_temp.text = "%.2f" %  process_temperatures(3) + " ºC"
	curr_temp.text = "%.2f" %  process_temperatures(PLANETS.current_planet_round) + " ºC" #
	surf_dens.text = str(planet_info.get("details").get("density")) + " kg/m³"
	curr_dens.text = str(process_densities(PLANETS.current_planet_round)) + " kg/m³" #
	atmos.text = str(planet_info.get("details").get("density_factor")) + " KM" #
	tier.text = str(planet_info.get("details").get("tier"))

func process_densities(layer:int)->float:
	planet_info = PLANETS.referenced_planets.get(PREP.selected_planet_id)
	var surface_density = planet_info.get("details").get("density")
	var density_factor = planet_info.get("details").get("density_factor")
	var density_exosfera = surface_density - (density_factor*4)
	var density_estratosfera = surface_density - (density_factor*2)
	var density_surface = surface_density 
	var air_density : float
	
	if layer == 1:
		if density_exosfera < 0:
			density_exosfera = 0
		air_density = density_exosfera
		return air_density
	elif layer == 2:
		if density_estratosfera < 0:
			density_estratosfera = 0
		air_density = density_estratosfera
		return air_density
	elif layer == 3:
		if density_surface < 0:
			density_surface = 0
		air_density = density_surface
		return air_density
	else:
		air_density = 0
		return air_density

func process_temperatures(layer : int)->float:
	planet_info = PLANETS.referenced_planets.get(PREP.selected_planet_id)
	var surface_temp = planet_info.get("details").get("temp")
	var temp_factor = planet_info.get("details").get("temp_factor")
	var distance_factor = 1/planet_info.get("details").get("distance_star")

	print("Base temp: ", surface_temp)
	var temp_surface = surface_temp + ((1000*distance_factor)**3)
	var temp_exosfera = temp_surface - (temp_factor*4)
	var temp_estratosfera = temp_surface - (temp_factor*2)
	var temperature
	if layer == 1:
		temperature = temp_exosfera
		return temperature
	elif layer == 2:
		temperature = temp_estratosfera
		return temperature
	elif layer == 3:
		temperature = temp_surface
		return temperature
	else:
		temperature = 20
		return temperature

func _on_next_pressed() -> void:
	PLANETS.current_location = PLANETS.last_focused_planet
	PREP.get_densities(1)
	PREP.get_temperatures(1)
	get_tree().change_scene_to_packed(fight_scene)

func _on_back_pressed() -> void:
	if GLOBAL.planet_menu_prev_scene == "system":
		get_tree().change_scene_to_packed(solar_system)
	elif GLOBAL.planet_menu_prev_scene == "summ": 
		get_tree().change_scene_to_file(summ_scene)
