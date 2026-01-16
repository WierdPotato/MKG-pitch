extends Node

var ship_mass : float = 3 #Masa VALOR BASE: 3
var ship_force : int = 40 #Fuerza de empuje VALOR BASE: 25
var ship_area : float = 2 #Superficie de la nave VALOR BASE: 2
var ship_ammo : int = 20
var ship_max_ammo : int = 30
var ship_load : float
var ship_max_speed : int = 500 #Velocidad maxima VALOR BASE: 350
var ship_cadence : int = 1
var air_density : float = 1.2 #Densidad del aire VALOR BASE: 1.2

var inventory_ammo : int = 5

var current_button_bdy : Button
var current_button_crg : Button
var current_button_eng : Button
var current_button_sld : Button
var current_button_wpn : Button

var current_buttons_list : Array 

var full_inventory : Array = [
	PARTS_BDY.body_1,
	PARTS_CRG.cargo_1,
	PARTS_ENG.engine_1,
	PARTS_SLD.shield_1,
	PARTS_WPN.weapon_1,
]

var selected_parts_dict : Dictionary = {
	"bdy" : PARTS_BDY.body_1,
	"crg" : PARTS_CRG.cargo_1,
	"eng" : PARTS_ENG.engine_1,
	"sld" : PARTS_SLD.shield_1,
	"wpn" : PARTS_WPN.weapon_1
}

var selected_parts_list : Array = [
	PARTS_BDY.body_1,
	PARTS_CRG.cargo_1,
	PARTS_ENG.engine_1,
	PARTS_SLD.shield_1,
	PARTS_WPN.weapon_1
]

var preselected_parts_dict : Dictionary = {
	"bdy" : PARTS_BDY.body_0,
	"crg" : PARTS_CRG.cargo_0,
	"eng" : PARTS_ENG.engine_0,
	"sld" : PARTS_SLD.shield_0,
	"wpn" : PARTS_WPN.weapon_0
	
}

var preselected_parts_list : Array = [
	PARTS_BDY.body_0,
	PARTS_CRG.cargo_0,
	PARTS_ENG.engine_0, 
	PARTS_SLD.shield_0, 
	PARTS_WPN.weapon_0
]

var default_preselected_dict : Dictionary = {
	"bdy" : PARTS_BDY.body_0,
	"crg" : PARTS_CRG.cargo_0,
	"eng" : PARTS_ENG.engine_0,
	"sld" : PARTS_SLD.shield_0,
	"wpn" : PARTS_WPN.weapon_0
}

var default_preselected_list : Array = [
	PARTS_BDY.body_0,
	PARTS_CRG.cargo_0,
	PARTS_ENG.engine_0, 
	PARTS_SLD.shield_0, 
	PARTS_WPN.weapon_0
]


func _ready() -> void:
	update_ship_stats()

func part_changed(part) -> void: 
	print("part changed called")
	selected_parts_list[part.TypeID - 1] = part
	selected_parts_dict[part.Type] = part
	update_ship_stats()
	reset_preselected()
	pass

func parts_changed() -> void:
	for i in preselected_parts_list:
		if i.ID == 0:
			pass
		else:
			selected_parts_list[i.TypeID - 1] = i
			
	for i in preselected_parts_dict:
		if preselected_parts_dict[i].ID == 0:
			pass
		else:
			selected_parts_dict[i] = preselected_parts_dict[i]
	update_ship_stats()
	await get_tree().process_frame
	reset_preselected()

func selected_button(button):
	if button.my_part.TypeID == 1:
		if current_button_bdy != null and current_button_bdy != button:
			current_button_bdy.do_empty_deselect()
			current_button_bdy = button
		elif current_button_bdy != null and current_button_bdy == button:
			pass
		elif current_button_bdy == null:
			current_button_bdy = button
		
	elif button.my_part.TypeID == 2:
		if current_button_crg != null and current_button_crg != button:
			current_button_crg.do_empty_deselect()
			current_button_crg = button
		elif current_button_crg != null and current_button_crg == button:
			pass
		elif current_button_crg == null:
			current_button_crg = button
	
	elif button.my_part.TypeID == 3:
		if current_button_eng != null and current_button_eng != button:
			current_button_eng.do_empty_deselect()
			current_button_eng = button
		elif current_button_eng != null and current_button_eng == button:
			pass
		elif current_button_eng == null:
			current_button_eng = button
	
	elif button.my_part.TypeID == 4:
		if current_button_sld != null and current_button_sld != button:
			current_button_sld.do_empty_deselect()
			current_button_sld = button
		elif current_button_sld != null and current_button_sld == button:
			pass
		elif current_button_sld == null:
			current_button_sld = button
	
	elif button.my_part.TypeID == 5:
		if current_button_wpn != null and current_button_wpn != button:
			current_button_wpn.do_empty_deselect()
			current_button_wpn = button
		elif current_button_wpn != null and current_button_wpn == button:
			pass
		elif current_button_wpn == null:
			current_button_wpn = button
	
	part_preselected(button.my_part)
	
	pass

func part_preselected(part) -> void:
	preselected_parts_list[part.TypeID - 1] = part
	preselected_parts_dict[part.Type] = part

func reset_preselected():
	#print("Reset called")
	
	#preselected_parts_dict.clear()
	preselected_parts_dict = default_preselected_dict
	#preselected_parts_list.clear()
	preselected_parts_list = default_preselected_list
	#print(current_buttons_list)
	for i in current_buttons_list:
		if i == null:
			pass
		else:
			i.do_deselected()
			#print(i, "DESELECTED FFS")

func update_ship_stats() -> void:
	ship_mass = 0
	ship_force = 0
	ship_area = 0
	#ship_ammo = 0
	ship_load = 0
	ship_max_ammo = 0
	ship_max_speed = 0
	ship_cadence = 0
	
	for i in selected_parts_list:
		ship_mass += i.Weight
		ship_force += i.Force
		ship_area += i.Area
		ship_load += i.Size
		ship_max_ammo += i.Rounds
		ship_max_speed += i.Speed
		ship_cadence += i.Cadence

func _process(_delta: float) -> void:
	current_buttons_list = [current_button_bdy, current_button_crg, current_button_eng, current_button_sld,current_button_wpn]
