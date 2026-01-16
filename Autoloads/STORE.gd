extends Node

var all_bodies_list : Array = [
	PARTS_BDY.body_1, 
	PARTS_BDY.body_2
]

var all_cargo_list : Array = [
	PARTS_CRG.cargo_1, 
	PARTS_CRG.cargo_2
]

var all_engines_list : Array = [
	PARTS_ENG.engine_1,
	PARTS_ENG.engine_2
]

var all_shields_list : Array = [
	PARTS_SLD.shield_1,
	PARTS_SLD.shield_2
]

var all_weapons_list : Array = [
	PARTS_WPN.weapon_1, 
	PARTS_WPN.weapon_2
]

var all_parts : Dictionary = {
	"bdy" : all_bodies_list,
	"crg" : all_cargo_list,
	"eng" : all_engines_list,
	"sld" : all_shields_list,
	"wpn" : all_weapons_list
}

var selected_parts : Array
var selected_total_price : int
var cart : Array = []
var cart_total_price : int

var previewing : bool
var preview_blueprint
var preview_name : String
var preview_type : String
var preview_area : String
var preview_weight : String
var preview_speed : String
var preview_force : String
var preview_hp : String
var preview_capacity : String
var preview_damage : String
var preview_cadence : String
var preview_rounds : String
var preview_size : String


func _ready() -> void:
	cart_total_price = 0

func part_selected(part) -> void:
	selected_parts.append(part) 
	selected_total_price += part.Price
	
func part_deselected(part) -> void:
	selected_parts.erase(part)
	selected_total_price -= part.Price
	
func add_to_cart() -> void:
	for i in selected_parts:
		cart.append(i)
		cart_total_price += i.Price	
	
	print(cart)
	selected_parts.clear()

func add_part_to_cart(part) -> void:
	cart.append(part)
	cart_total_price += part.Price
	
func quit_from_cart(part):
	cart.erase(part)
	cart_total_price -= part.Price

func preview_part(part) -> void:
	if part == null:
		previewing = false
		
	else:
		preview_blueprint = part.Blueprint
		preview_name = part.Name
		preview_type = process_type(part.Type)
		preview_area = process_text(part.Area)
		preview_weight = process_text(part.Weight)
		preview_speed = process_text(part.Speed)
		preview_force = process_text(part.Force)
		preview_hp = process_text(part.HP)
		preview_capacity = process_text(part.Capacity)
		preview_damage = process_text(part.Damage)
		preview_cadence = process_text(part.Cadence)
		preview_rounds = process_text(part.Rounds)
		preview_size = process_text(part.Size)
		previewing = true

func buy() -> void:
	print("SELECTED PARTS: ", selected_parts)
	GLOBAL.money -= selected_total_price
	for i in selected_parts:
		print("I = ",i)
		PREP.full_inventory.append(i)
	await get_tree().process_frame
	selected_parts.clear()
	selected_total_price = 0

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
