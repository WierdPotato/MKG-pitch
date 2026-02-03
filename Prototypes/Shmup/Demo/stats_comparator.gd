extends Node2D

@onready var equiped: Node2D = $Equiped
@onready var hp: Label = $Equiped/HP
@onready var size: Label = $Equiped/Size
@onready var speed: Label = $Equiped/Speed
@onready var thrust: Label = $Equiped/Thrust
@onready var damage: Label = $Equiped/Damage
@onready var max_ammo: Label = $Equiped/MaxAmmo
@onready var weight: Label = $Equiped/Weight
@onready var cargo: Label = $Equiped/Cargo
@onready var cadence: Label = $Equiped/Cadence

@onready var sim: Node2D = $Sim
@onready var hp_sim: Label = $Sim/HPSim
@onready var size_sim: Label = $Sim/SizeSim
@onready var speed_sim: Label = $Sim/SpeedSim
@onready var thrust_sim: Label = $Sim/ThrustSim
@onready var damage_sim: Label = $Sim/DamageSim
@onready var max_ammo_sim: Label = $Sim/MaxAmmoSim
@onready var weight_sim: Label = $Sim/WeightSim
@onready var cargo_sim: Label = $Sim/CargoSim
@onready var cadence_sim: Label = $Sim/CadenceSim


var green_text : Color = Color(0.145, 0.443, 0.475)
var normal_text : Color = Color(0.102, 0.11, 0.173)
var red_text : Color = Color(0.694, 0.243, 0.325)

func _ready() -> void:
	update_texts()


func update_texts() -> void:
	hp.text = str(PREP.ship_hp)
	hp_sim.text = str(PREP.sim_ship_hp)
	
	size.text = str(PREP.ship_area)
	size_sim.text = str(PREP.sim_ship_area)
	
	speed.text = str(PREP.ship_max_speed)
	speed_sim.text = str(PREP.sim_ship_max_speed)
	
	thrust.text = str(PREP.ship_force)
	thrust_sim.text = str(PREP.sim_ship_force)
	
	damage.text = str(PREP.ship_damage)
	damage_sim.text = str(PREP.sim_ship_damage)
	
	max_ammo.text = str(PREP.ship_max_ammo)
	max_ammo_sim.text =str(PREP.sim_ship_max_ammo)
	
	weight.text = str(PREP.ship_mass)
	weight_sim.text = str(PREP.sim_ship_mass)
	
	cargo.text = str(PREP.ship_load)
	cargo_sim.text = str(PREP.sim_ship_load)
	
	cadence.text = str(PREP.ship_cadence)
	cadence_sim.text = str(PREP.sim_ship_cadence)
	
	process_text()
	
func process_text() -> void:
	var equiped_list = equiped.get_children()
	var sim_list = sim.get_children()
	
	for i in equiped_list.size():
		
		if i == 6:
			if equiped_list[i].text > sim_list[i].text:
				sim_list[i].set("theme_override_colors/font_color", green_text)
				sim_list[i].set("theme_override_colors/font_outline_color", green_text)
			elif equiped_list[i].text < sim_list[i].text:
				sim_list[i].set("theme_override_colors/font_color", red_text)
				sim_list[i].set("theme_override_colors/font_outline_color", red_text)
			else:

				sim_list[i].set("theme_override_colors/font_color", normal_text)
				sim_list[i].set("theme_override_colors/font_outline_color", normal_text)
				sim_list[i].text = "-"
		else:
			if equiped_list[i].text < sim_list[i].text:
				sim_list[i].set("theme_override_colors/font_color", green_text)
				sim_list[i].set("theme_override_colors/font_outline_color", green_text)
			elif equiped_list[i].text > sim_list[i].text:
				sim_list[i].set("theme_override_colors/font_color", red_text)
				sim_list[i].set("theme_override_colors/font_outline_color", red_text)
			else:

				sim_list[i].set("theme_override_colors/font_color", normal_text)
				sim_list[i].set("theme_override_colors/font_outline_color", normal_text)
				sim_list[i].text = "-"
