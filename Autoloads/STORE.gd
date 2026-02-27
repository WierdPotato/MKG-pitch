extends Node

var all_bodies_list : Array = [
	PARTS_BDY.body_1, 
	PARTS_BDY.body_2, 
	PARTS_BDY.body_3, 
	PARTS_BDY.body_4
]

var all_cargo_list : Array = [
	PARTS_CRG.cargo_1, 
	PARTS_CRG.cargo_2, 
	PARTS_CRG.cargo_3, 
	PARTS_CRG.cargo_4
]

var all_engines_list : Array = [
	PARTS_ENG.engine_1,
	PARTS_ENG.engine_2,
	PARTS_ENG.engine_3,
	PARTS_ENG.engine_4,
	PARTS_ENG.engine_5,
	PARTS_ENG.engine_6,
	PARTS_ENG.engine_7
]

var all_shields_list : Array = [
	PARTS_SLD.shield_1,
	PARTS_SLD.shield_2,
	PARTS_SLD.shield_3,
	PARTS_SLD.shield_4,
	PARTS_SLD.shield_5,
	PARTS_SLD.shield_6,
	PARTS_SLD.shield_7
]

var all_weapons_list : Array = [
	PARTS_WPN.weapon_1, 
	PARTS_WPN.weapon_2
]

var all_parts : Dictionary = {
	"bdy" : all_bodies_list,
	"crg" : all_cargo_list,
	"eng" : all_engines_list,
	"sld" : all_shields_list
}


var sim_parts : Dictionary = {
	"bdy" : PARTS_BDY.body_1,
	"crg" : PARTS_CRG.cargo_1,
	"eng" : PARTS_ENG.engine_1,
	"sld" : PARTS_SLD.shield_1
}

var equiped_parts : Dictionary

var ship_hp
var ship_mass 
var ship_force 
var ship_area 
var ship_load
var ship_max_ammo 
var ship_max_speed 
var ship_cadence
var ship_damage

var sim_ship_hp 
var sim_ship_mass 
var sim_ship_force 
var sim_ship_area 
var sim_ship_load 
var sim_ship_max_ammo 
var sim_ship_max_speed 
var sim_ship_cadence 
var sim_ship_damage 

var selected_part 

var store_list : Array

func _ready() -> void:
	pass
	
func on_ready() -> void:
	print("On ready called")
	equiped_parts.clear()
	equiped_parts = PREP.equiped_parts.duplicate()
	prepare_store_list()
	part_deselected()
	update_real_stats()
	reset_sim()

func prepare_store_list()->void:
	print("Prepare list called")
	store_list.clear()
	for k in all_parts:
		for i in all_parts.get(k):
			if PREP.full_inventory.has(i) or store_list.has(i):
				pass
			else:
				store_list.append(i)
	for p in store_list:
		print("Elemento:", p)


func part_selected(part) -> void:
	part_deselected()
	reset_sim()
	selected_part = part
	sim_parts.set(part.get("Type"), part)
	simulate_stats()
	
	
func part_deselected() -> void:
	selected_part = null
	reset_sim()
	simulate_stats()

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

func reset_sim() -> void:
	sim_parts.clear()
	sim_parts = equiped_parts.duplicate()


func buy() -> void:
	print("Le doy a comprar")
	if selected_part:
		print("COMPRO ALGO")
		GLOBAL.money -= selected_part.get("Price")
		PREP.full_inventory.append(selected_part)
		on_ready()
	else:
		pass

func process_type(type : String):
	if type == "bdy":
		return("BODY")
	elif type == "crg":
		return("CARGO")
	elif type == "eng":
		return("ENGINE")
	elif type == "sld":
		return("SHIELD")
	elif type == "wpn":
		return("WEAPON")

func process_text(value):
	if value == 0:
		return("-")
	else:
		return(str(value))
