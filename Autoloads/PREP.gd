extends Node
var ship_hp : int = 150
var ship_mass : float = 3 #Masa VALOR BASE: 3
var ship_force : int = 40 #Fuerza de empuje VALOR BASE: 25
var ship_area : float = 2 #Superficie de la nave VALOR BASE: 2
var ship_ammo : int = 20
var ship_max_ammo : int = 30
var ship_load : float
var ship_max_speed : int = 500 #Velocidad maxima VALOR BASE: 350
var ship_cadence : int = 1
var air_density : float = 1.2 #Densidad del aire VALOR BASE: 1.2
var ship_damage : int = 100

var temperature : float

var sim_ship_hp : int = 150
var sim_ship_mass : float = 3 
var sim_ship_force : int = 40 
var sim_ship_area : float = 2 
var sim_ship_ammo : int = 0
var sim_ship_max_ammo : int = 30
var sim_ship_load : float
var sim_ship_max_speed : int = 500
var sim_ship_cadence : int = 1
var sim_ship_damage : int = 100

var inventory_ammo : int = 50

var full_inventory : Array = [
	PARTS_BDY.body_1,
	PARTS_CRG.cargo_1,
	PARTS_ENG.engine_1,
	PARTS_SLD.shield_1
]

var equiped_parts : Dictionary = {
	"bdy" : PARTS_BDY.body_1,
	"crg" : PARTS_CRG.cargo_1,
	"eng" : PARTS_ENG.engine_1,
	"sld" : PARTS_SLD.shield_1, 
	"wpn" : PARTS_WPN.weapon_1
}

var sim_parts : Dictionary = {
	"bdy" : PARTS_BDY.body_1,
	"crg" : PARTS_CRG.cargo_1,
	"eng" : PARTS_ENG.engine_1,
	"sld" : PARTS_SLD.shield_1, 
	"wpn" : PARTS_WPN.weapon_1
}

var selected_planet_id : String
var planet_info : Dictionary

var max_fuel: float = 300
var current_fuel: float 

func _ready() -> void:
	update_real_stats()
	simulate_stats()
	current_fuel = max_fuel
func update_real_stats() -> void:
	ship_hp = 0
	ship_mass = 0
	ship_force = 0
	ship_area = 0
	ship_load = 0
	ship_max_ammo = 0
	ship_max_speed = 0
	ship_cadence = 0
	ship_damage = 0
	
	for i in equiped_parts:
		ship_hp += equiped_parts.get(i).get("HP")
		ship_mass += equiped_parts.get(i).get("Weight")
		ship_force += equiped_parts.get(i).get("Force")
		ship_area += equiped_parts.get(i).get("Size")
		ship_load += equiped_parts.get(i).get("Capacity")
		ship_max_ammo += equiped_parts.get(i).get("Rounds")
		ship_max_speed += equiped_parts.get(i).get("Speed")
		ship_cadence += equiped_parts.get(i).get("Cadence")
		ship_damage += equiped_parts.get(i).get("Damage")
		
	if ship_ammo > ship_max_ammo:
		var diff = ship_ammo - ship_max_ammo
		ship_ammo = ship_max_ammo
		inventory_ammo += diff
		sim_ship_ammo = 0
	ship_mass += 0.01 * ship_ammo

func simulate_stats()-> void:
	sim_ship_hp = 0
	sim_ship_mass = 0
	sim_ship_force = 0
	sim_ship_area = 0
	sim_ship_load = 0
	sim_ship_max_ammo = 0
	sim_ship_max_speed = 0
	sim_ship_cadence = 0
	sim_ship_damage = 0
	for i in sim_parts:
		sim_ship_hp += sim_parts.get(i).get("HP")
		sim_ship_mass += sim_parts.get(i).get("Weight")
		sim_ship_force += sim_parts.get(i).get("Force")
		sim_ship_area += sim_parts.get(i).get("Size")
		sim_ship_load += sim_parts.get(i).get("Capacity")
		sim_ship_max_ammo += sim_parts.get(i).get("Rounds")
		sim_ship_max_speed += sim_parts.get(i).get("Speed")
		sim_ship_cadence += sim_parts.get(i).get("Cadence")
		sim_ship_damage += sim_parts.get(i).get("Damage")
		
	sim_ship_mass += 0.01 * (sim_ship_ammo + ship_ammo)
	
func reset_sim() -> void:
	sim_parts.clear()
	sim_parts = equiped_parts.duplicate()
	simulate_stats()

func part_selected(part)-> void:
	if part == equiped_parts.get(part.get("Type")):
		pass
	else:
		sim_parts.set(part.get("Type"), part)
		simulate_stats()

func equip_pressed() -> void:
	equiped_parts.clear() 
	equiped_parts = sim_parts.duplicate()
	update_real_stats()
	reset_sim()

func get_densities(layer : int)->void:
	planet_info = PLANETS.referenced_planets.get(selected_planet_id)
	var surface_density = planet_info.get("details").get("density")
	var density_factor = planet_info.get("details").get("density_factor")
	var density_exosfera = surface_density - (density_factor*4)
	var density_estratosfera = surface_density - (density_factor*2)
	var density_surface = surface_density 
	if layer == 1:
		if density_exosfera < 0:
			density_exosfera = 0
		air_density = density_exosfera
		
	elif layer == 2:
		if density_estratosfera < 0:
			density_estratosfera = 0
		air_density = density_estratosfera
		
	elif layer == 3:
		if density_surface < 0:
			density_surface = 0
		air_density = density_surface
		
	else:
		air_density = 0

func get_temperatures(layer : int)->void:
	planet_info = PLANETS.referenced_planets.get(selected_planet_id)
	var surface_temp = planet_info.get("details").get("temp")
	var temp_factor = planet_info.get("details").get("temp_factor")
	var temp_exosfera = surface_temp - (temp_factor*4)
	var temp_estratosfera = surface_temp - (temp_factor*2)
	var temp_surface = surface_temp
	if layer == 1:
		temperature = temp_exosfera
		
	elif layer == 2:
		temperature = temp_estratosfera
		
	elif layer == 3:
		temperature = temp_surface
		
	else:
		temperature = 20
